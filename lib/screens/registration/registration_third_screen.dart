import 'dart:math';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:elrond/model/select_word_model.dart';
import 'package:elrond/screens/registration/dialog_invalid.dart';
import 'package:elrond/settings/constants.dart';
import 'package:elrond/settings/st.dart';
import 'package:elrond/widgets/btn_gradient.dart';
import 'package:elrond/widgets/btn_text.dart';
import 'package:elrond/widgets/custom_back.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'registration_done_screen.dart';

class RegistrationThirdScreen extends StatefulWidget {
  const RegistrationThirdScreen(this.listPhrase, {super.key});
  final List<String> listPhrase;

  @override
  State<RegistrationThirdScreen> createState() => _RegistrationThirdScreenState();
}

class _RegistrationThirdScreenState extends State<RegistrationThirdScreen> {
  SelectWordModel? _firstWord;
  SelectWordModel? _secondWord;
  SelectWordModel? _thirdWord;
  final rnd = Random();
  int? iMenuField;
  int? iActivityField;
  bool isError = false;

  @override
  void initState() {
    createSelectWord();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: 33.h),
          const CustomBack(title: "Validate Secret Phrase"),
          SizedBox(height: 10.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 27.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 6.h),
                      child: Image.asset('assets/images/warning.png',
                          width: 15.r, height: 15.r),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Text(
                        "Let's check if you wrote down your secret phrase correctly.",
                        style: ST.my(18, 500, height: 1.39),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 11.h),
                Text(
                  "Enter the words from your Secret Phrase as indicated below.",
                  style: ST.my(18, 500, height: 1.39),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 18.h),
                _buildSelectWord(_firstWord),
                SizedBox(height: 30.h),
                _buildSelectWord(_secondWord),
                SizedBox(height: 30.h),
                _buildSelectWord(_thirdWord),
              ],
            ),
          ),
          const Spacer(),
          SizedBox(height: 10.h),
          BtnGradient(
            onPressed: _firstWord?.selectedWord == "" ||
                    _secondWord?.selectedWord == "" ||
                    _thirdWord?.selectedWord == "" ||
                    isError
                ? null
                : () {
                    if (checkWord()) {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                RegistrationDoneScreen(phrase: widget.listPhrase.join(" "))),
                          (_) => false);
                    } else {
                      isError = true;
                      setState(() {
                        showDialog(
                          context: context,
                          builder: (_) => const DialogInvalid(),
                        );
                      });
                    }
                  },
            margin: EdgeInsets.symmetric(horizontal: 37.w),
            text: "Continue",
          ),
          SizedBox(height: 11.h),
          Center(
            child: BtnText(
              onPressed: () => Navigator.pop(context),
              text: "Back to words",
              style: ST.my(15, 400, height: 1.6),
            ),
          ),
          SizedBox(height: 32.h + AppSetting.sBottom),
        ],
      ),
    );
  }

  //# ==================================================
  ///
  Column _buildSelectWord(SelectWordModel? word) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          "Select word #${word?.id == null ? "" : word!.id + 1}",
          style: ST.my(15, 500, height: 1.6),
        ),
        DropdownButtonHideUnderline(
          child: DropdownButton2<String>(
            isExpanded: true,
            selectedItemBuilder: (_) => word!.words
                .map(
                  (item) => Align(
                    alignment: Alignment.centerLeft,
                    child: Text(item, style: ST.my(18, 500, height: 1)),
                  ),
                )
                .toList(),
            items: word?.words
                .map(
                  (String item) => DropdownMenuItem<String>(
                    value: item,
                    child: Container(
                      height: 36.h,
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      color: item == word.selectedWord
                          ? const Color(0xFFDE652C)
                          : Colors.transparent,
                      child: Text(item, style: ST.my(16, 600, height: 1.44)),
                    ),
                  ),
                )
                .toList(),
            value: word?.selectedWord == "" ? null : word?.selectedWord,
            onMenuStateChange: (_) => setState(() {
              iActivityField = word?.id;
              iMenuField = iMenuField == word?.id ? null : word?.id;
            }),
            onChanged: (value) {
              isError = false;
              setState(() => word?.selectedWord = value ?? "");
            },
            buttonStyleData: ButtonStyleData(
              height: 50,
              padding: const EdgeInsets.only(left: 14, right: 14),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                    color: iActivityField == word?.id
                        ? const Color(0xFFDE652C)
                        : const Color(0xFF4A55C1),
                    width: 2),
              ),
              overlayColor: WidgetStateProperty.all(Colors.transparent),
              elevation: 0,
            ),
            iconStyleData: IconStyleData(
              icon: Image.asset('assets/images/arrow_down.png',
                  width: 25, height: 12),
              openMenuIcon: Image.asset('assets/images/arrow_up.png',
                  width: 25, height: 12),
            ),
            dropdownStyleData: DropdownStyleData(
              padding: const EdgeInsets.all(2),
              elevation: 0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: const Color(0xFF4A55C1),
              ),
              offset: const Offset(0, -4),
            ),
            menuItemStyleData: MenuItemStyleData(
              height: 36,
              padding: const EdgeInsets.all(2),
              overlayColor: WidgetStateProperty.all(Colors.transparent),
            ),
          ),
        ),
      ],
    );
  }

  /// Генерація випадкових слів
  void createSelectWord() {
    final index = _rndIndex();
    final tempList = List.from(widget.listPhrase);
    final word1 = widget.listPhrase[index.$1];
    final word2 = widget.listPhrase[index.$2];
    final word3 = widget.listPhrase[index.$3];
    debugPrint("#1 = $word1   #2 = $word2    #3 = $word3");
    debugPrint("$tempList");
    tempList.remove(word1);
    tempList.remove(word2);
    tempList.remove(word3);
    debugPrint("$tempList");
    _firstWord = SelectWordModel(
      index.$1,
      word1,
      [
        word1,
        tempList.removeAt(rnd.nextInt(tempList.length)),
        tempList.removeAt(rnd.nextInt(tempList.length)),
      ]..shuffle(Random()),
    );
    _secondWord = SelectWordModel(
      index.$2,
      word2,
      [
        word2,
        tempList.removeAt(rnd.nextInt(tempList.length)),
        tempList.removeAt(rnd.nextInt(tempList.length)),
      ]..shuffle(Random()),
    );
    _thirdWord = SelectWordModel(
      index.$3,
      word3,
      [
        word3,
        tempList.removeAt(rnd.nextInt(tempList.length)),
        tempList.removeAt(rnd.nextInt(tempList.length)),
      ]..shuffle(Random()),
    );
    debugPrint("$tempList");
  }

  /// Генерація випадкових індексів елементів масиву
  (int, int, int) _rndIndex() {
    final lenghtPhrase = widget.listPhrase.length;
    final int firstIndex = rnd.nextInt(lenghtPhrase);
    int secondIndex = rnd.nextInt(lenghtPhrase);
    while (secondIndex == firstIndex) {
      secondIndex = rnd.nextInt(lenghtPhrase);
    }
    int thirdIndex = rnd.nextInt(lenghtPhrase);
    while (thirdIndex == firstIndex || thirdIndex == secondIndex) {
      thirdIndex = rnd.nextInt(lenghtPhrase);
    }
    return (firstIndex, secondIndex, thirdIndex);
  }

  /// Перевірка на вірність вибраних слів
  bool checkWord() => _firstWord?.selectedWord == _firstWord?.goodWord &&
          _secondWord?.selectedWord == _secondWord?.goodWord &&
          _thirdWord?.selectedWord == _thirdWord?.goodWord
      ? true
      : false;
}

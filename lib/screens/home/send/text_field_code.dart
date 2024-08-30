import 'package:elrond/settings/st.dart';
import 'package:elrond/widgets/btn_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:super_clipboard/super_clipboard.dart';

class TextFieldCode extends StatelessWidget {
  const TextFieldCode({
    super.key,
    this.title,
    this.hintText,
    required this.controller,
  });
  final String? title;
  final String? hintText;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null)
          Text(title ?? "", style: ST.my(15, 500, height: 1.6)),
        const SizedBox(height: 3),
        TextField(
          controller: controller,
          style: ST.my(15, 500, height: 1),
          cursorColor: Colors.white,
          maxLines: 1,
          decoration: InputDecoration(
            isDense: true,
            hintText: hintText,
            hintStyle: ST.my(15, 500, height: 1, color: const Color(0xFF958A8A)),
            border: BD_ENABLED,
            focusedBorder: BD_FOCUS,
            enabledBorder: BD_ENABLED,
            errorBorder: BD_ENABLED,
            disabledBorder: BD_ENABLED,
            contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 18.h),
            suffixIconConstraints: BoxConstraints(maxHeight: 15.h),
            // suffixIcon: Padding(
            //   padding: EdgeInsets.symmetric(horizontal: 15.w),
            //   child: BtnText(
            //     onPressed: () async {
            //       final clipboard = SystemClipboard.instance;
            //       if (clipboard != null) {
            //         final reader = await clipboard.read();
            //         if (reader.canProvide(Formats.plainText)) {
            //           final text = await reader.readValue(Formats.plainText);
            //           controller.text = text!;
            //         }
            //       }
            //     },
            //     style: ST.my(12, 400, height: 1),
            //     text: "Paste",
            //   ),
            // ),
          ),
        ),
      ],
    );
  }

  final BD_ENABLED = const OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(10)),
    borderSide: BorderSide(color: Color(0xFF4A55C1), width: 2),
  );

  final BD_FOCUS = const OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(10)),
    borderSide: BorderSide(color: Color(0xFFDE652C), width: 2),
  );
}

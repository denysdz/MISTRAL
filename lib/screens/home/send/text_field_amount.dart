// ignore_for_file: non_constant_identifier_names

import 'package:elrond/settings/st.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextFieldAmount extends StatelessWidget {
  const TextFieldAmount({
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
          maxLength: 14,
          textAlign: TextAlign.end,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          onChanged: (val) => controller.text = val.replaceAll(',', '.'),
          decoration: InputDecoration(
            isDense: true,
            hintText: hintText,
            hintStyle:
                ST.my(15, 500, height: 1, color: const Color(0xFF958A8A)),
            border: BD_ENABLED,
            focusedBorder: BD_FOCUS,
            enabledBorder: BD_ENABLED,
            errorBorder: BD_ENABLED,
            disabledBorder: BD_ENABLED,
            constraints: BoxConstraints(maxHeight: 55.h),
            contentPadding:
                EdgeInsets.symmetric(vertical: 15.h, horizontal: 20.w),
            prefixIcon: Padding(
              padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 12.w),
              child: Image.asset('assets/images/logo_start_third.png',
                  width: 30.h, height: 30.h),
            ),
          ),
          buildCounter: (_,
                  {int? currentLength, int? maxLength, bool? isFocused}) =>
              null,
        )
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

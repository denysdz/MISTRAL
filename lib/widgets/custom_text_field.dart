// ignore_for_file: non_constant_identifier_names

import 'package:elrond/settings/st.dart';
import 'package:elrond/widgets/btn_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    super.key,
    this.title,
    this.hintText,
    required this.controller,
    this.onChanged,
  });
  final String? title;
  final String? hintText;
  final TextEditingController controller;
  final void Function(String)? onChanged;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool isVisabled = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.title != null)
          Text(widget.title ?? "", style: ST.my(15, 500, height: 1.6)),
        SizedBox(height: 3.h),
        TextField(
          controller: widget.controller,
          obscureText: !isVisabled,
          obscuringCharacter: "*",
          style: ST.my(18, 500, height: 1),
          cursorColor: Colors.white,
          onChanged: widget.onChanged,
          decoration: InputDecoration(
            isDense: true,
            hintText: widget.hintText,
            hintStyle: ST.my(15, 500, color: const Color(0xFF958A8A)),
            border: BD_ENABLED,
            focusedBorder: BD_FOCUS,
            enabledBorder: BD_ENABLED,
            errorBorder: BD_ENABLED,
            disabledBorder: BD_ENABLED,
            constraints: BoxConstraints(maxHeight: 55.h),
            contentPadding: EdgeInsets.symmetric(
                                  vertical: 15.h, horizontal: 20.w),
            suffixIconConstraints: BoxConstraints(maxHeight: 15.w),
            suffixIcon: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                BtnImage(
                  onPressed: () => setState(() => isVisabled = !isVisabled),
                  padding:  EdgeInsets.symmetric(horizontal: 15.w),
                  width: 18,
                  height: 18,
                  image: isVisabled
                      ? 'assets/images/eye_off.png'
                      : 'assets/images/eye_on.png',
                  imagePressed: isVisabled
                      ? 'assets/images/eye_off_act.png'
                      : 'assets/images/eye_on_act.png',
                ),
              ],
            ),
          ),
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

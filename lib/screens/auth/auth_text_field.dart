// ignore_for_file: non_constant_identifier_names

import 'package:clipboard/clipboard.dart';
import 'package:elrond/settings/st.dart';
import 'package:elrond/widgets/btn_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AuthTextField extends StatefulWidget {
  const AuthTextField({super.key, required this.controller, this.onChanged});
  final TextEditingController controller;
  final void Function(String)? onChanged;

  @override
  State<AuthTextField> createState() => _AuthTextFieldState();
}

class _AuthTextFieldState extends State<AuthTextField> {
  @override
  void initState() {
    widget.controller.addListener(() => setState(() {}));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        TextField(
          controller: widget.controller,
          style: ST.my(18, 500, height: 1.34),
          maxLines: null,
          minLines: 5,
          cursorColor: Colors.white,
          onChanged: widget.onChanged,
          decoration: InputDecoration(
            constraints: BoxConstraints(maxHeight: 170.h),
            contentPadding:
                EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
            border: BD_ENABLED,
            focusedBorder: BD_FOCUS,
            enabledBorder: BD_ENABLED,
            errorBorder: BD_ENABLED,
            disabledBorder: BD_ENABLED,
          ),
          textAlign: TextAlign.left, // Введений текст буде ліворуч
        ),
        if (widget.controller.text.isEmpty)
          Positioned.fill(
            child: Align(
              alignment: Alignment.center,
              child: IgnorePointer(
                child: Text(
                  "Secret phrase",
                  style: ST.my(15, 500,
                      height: 1.66, color: const Color(0xFF958A8A)),
                ),
              ),
            ),
          ),
        Positioned(
          right: 10,
          bottom: 10,
          child: BtnText(
            onPressed: () => FlutterClipboard.paste().then((val) {
              //TODO
              // final val = "veteran age boss pool romance boring play retreat betray carpet sibling hollow answer inch mammal scissors exchange asset rapid brain focus check awful vast";
              widget.controller.text = val;
              widget.onChanged!(val);
            }),
            text: "Paste",
            style: ST.my(13, 400),
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

import 'package:elrond/settings/st.dart';
import 'package:elrond/widgets/btn_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:super_clipboard/super_clipboard.dart';

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

  Future<void> pasteFromClipboard() async {
    final clipboard = SystemClipboard.instance;
    if (clipboard == null) {
      return; // Clipboard API is not supported on this platform.
    }

    final reader = await clipboard.read();

    String? text;
    if (reader.canProvide(Formats.plainText)) {
      text = await reader.readValue(Formats.plainText);
    }

    if (text != null) {
      setState(() {
        widget.controller.text = text!;
        widget.onChanged?.call(text);
      });
    }
  }

  final BD_ENABLED = const OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(10)),
    borderSide: BorderSide(color: Color(0xFF4A55C1), width: 2),
  );

  final BD_FOCUS = const OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(10)),
    borderSide: BorderSide(color: Color(0xFFDE652C), width: 2),
  );

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
            contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
            border: BD_ENABLED,
            focusedBorder: BD_FOCUS,
            enabledBorder: BD_ENABLED,
            errorBorder: BD_ENABLED,
            disabledBorder: BD_ENABLED,
          ),
          textAlign: TextAlign.left,
        ),
        if (widget.controller.text.isEmpty)
          Positioned.fill(
            child: Align(
              alignment: Alignment.center,
              child: IgnorePointer(
                child: Text(
                  "Secret phrase",
                  style: ST.my(15, 500, height: 1.66, color: const Color(0xFF958A8A)),
                ),
              ),
            ),
          ),
        // Positioned(
        //   right: 10,
        //   bottom: 10,
        //   child: BtnText(
        //     onPressed: () async {
        //       await pasteFromClipboard();
        //     },
        //     text: "Paste",
        //     style: ST.my(13, 400),
        //   ),
        // ),
      ],
    );
  }
}

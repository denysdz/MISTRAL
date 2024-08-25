import 'package:flutter/material.dart';

class BtnText extends StatefulWidget {
  const BtnText({
    super.key,
    required this.onPressed,
    this.text = "OK",
    this.style,
  });
  final VoidCallback? onPressed;
  final String text;
  final TextStyle? style;

  @override
  State<BtnText> createState() => _BtnGradientState();
}

class _BtnGradientState extends State<BtnText> {
  bool isTap = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapUp: (_) {
        isTap = false;
        setState(() {});
        if (widget.onPressed != null) widget.onPressed!();
      },
      onTapDown: (_) {
        isTap = true;
        setState(() {});
      },
      onLongPressUp: () {
        isTap = false;
        setState(() {});
        if (widget.onPressed != null) widget.onPressed!();
      },
      child: Text(
        widget.text,
        style: widget.style?.copyWith(
          color: isTap ? const Color(0xFFDC662F) : const Color(0xFF4A55C1),
        ),
      ),
    );
  }
}

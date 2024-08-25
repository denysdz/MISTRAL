import 'package:elrond/settings/st.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BtnGradient extends StatefulWidget {
  const BtnGradient({
    super.key,
    required this.onPressed,
    this.text = "OK",
    this.margin,
    this.padding,
    this.image,
    this.height,
    this.radius = 5,
  });
  final VoidCallback? onPressed;
  final String text;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final Widget? image;
  final double? height;
  final double radius;

  @override
  State<BtnGradient> createState() => _BtnGradientState();
}

class _BtnGradientState extends State<BtnGradient> {
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
      child: Container(
        alignment: Alignment.center,
        margin: widget.margin,
        padding: widget.padding,
        height: widget.height ?? 50.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(widget.radius),
          color: widget.onPressed == null
              ? const Color(0xFF373949)
              : isTap
                  ? const Color(0xFFDE652C)
                  : null,
          gradient: (!isTap && widget.onPressed != null)
              ? const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [0, 1],
                  colors: [Color(0xFF4A55C1), Color(0xFF23285B)],
                )
              : null,
        ),
        child: widget.image ??
            Text(
              widget.text,
              style: ST.my(20, 500,
                  color: widget.onPressed == null
                      ? const Color(0xFFAC9999)
                      : Colors.white),
            ),
      ),
    );
  }
}

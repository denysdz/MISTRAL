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
  bool isHover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        setState(() {
          isHover = true;
        });
      },
      onExit: (_) {
        setState(() {
          isHover = false;
        });
      },
      child: GestureDetector(
        onTapUp: (_) {
          setState(() {
            isTap = false;
          });
          if (widget.onPressed != null) widget.onPressed!();
        },
        onTapDown: (_) {
          setState(() {
            isTap = true;
          });
        },
        onLongPressUp: () {
          setState(() {
            isTap = false;
          });
          if (widget.onPressed != null) widget.onPressed!();
        },
        child: Container(
          alignment: Alignment.center,
          margin: widget.margin,
          padding: widget.padding,
          height: widget.height ?? 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(widget.radius),
            color: widget.onPressed == null
                ? const Color(0xFF373949)
                : (isTap || isHover)
                    ? const Color(0xFFDE652C)
                    : null,
            gradient: (!isTap && !isHover && widget.onPressed != null)
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
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: widget.onPressed == null
                      ? const Color(0xFFAC9999)
                      : Colors.white,
                ),
              ),
        ),
      ),
    );
  }
}


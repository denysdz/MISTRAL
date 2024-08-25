import 'package:flutter/material.dart';

class BtnImage extends StatefulWidget {
  const BtnImage({
    super.key,
    required this.onPressed,
    required this.image,
    required this.imagePressed,
    this.width,
    this.height,
    this.alignment = Alignment.centerRight,
    this.padding = const EdgeInsets.only(right: 28),
    this.fit,
  });
  final VoidCallback? onPressed;
  final String image;
  final String imagePressed;
  final double? width;
  final double? height;
  final AlignmentGeometry alignment;
  final EdgeInsetsGeometry padding;
  final BoxFit? fit;

  @override
  State<BtnImage> createState() => _BtnGradientState();
}

class _BtnGradientState extends State<BtnImage> {
  bool isTap = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding,
      child: Align(
        alignment: widget.alignment,
        child: GestureDetector(
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
          child: Image.asset(
            isTap ? widget.imagePressed : widget.image,
            width: widget.width,
            height: widget.height,
            fit: widget.fit,
          ),
        ),
      ),
    );
  }
}

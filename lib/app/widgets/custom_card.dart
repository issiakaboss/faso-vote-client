import 'package:flutter/material.dart';

class MainCard extends StatelessWidget {
  final Color cardColor;
  final double radius;
  final BoxBorder? border;
  final Color borderColor;
  final double borderWidth;
  final Color boxColor;
  final Offset offset;
  final double blurRadius;
  final double spreadRadius;
  final BlurStyle blurStyle;
  final double cardWidth;
  final double cardHeight;
  final BorderRadiusGeometry? borderRadius;
  final EdgeInsetsGeometry? padding;
  final Gradient? gradient;
  final Widget? child;

  const MainCard({
    super.key,
    this.cardColor = Colors.transparent,
    this.radius = 5,
    this.border,
    this.borderColor = const Color(0xFF000000),
    this.borderWidth = 1.0,
    this.boxColor = Colors.transparent,
    this.offset = Offset.zero,
    this.blurRadius = 0.0,
    this.spreadRadius = 0.0,
    this.blurStyle = BlurStyle.normal,
    this.cardWidth = 100,
    this.cardHeight = 50,
    this.borderRadius,
    this.padding,
    this.gradient,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      width: cardWidth,
      height: cardHeight,
      decoration: BoxDecoration(
        gradient: gradient,
        color: cardColor,
        borderRadius: borderRadius ?? BorderRadius.circular(radius),
        border: border ??
            Border.all(
              color: borderColor,
              width: borderWidth,
            ),
        boxShadow: [
          BoxShadow(
            color: boxColor,
            blurRadius: blurRadius,
            offset: offset,
            blurStyle: blurStyle,
            spreadRadius: spreadRadius,
          )
        ],
      ),
      child: child,
    );
  }
}

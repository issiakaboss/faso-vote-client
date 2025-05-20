import 'package:faso_vote_client/app/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class MainButton extends StatelessWidget {
  final double width;
  final double height;
  final Color? color;
  final Color? textcolor;
  final String text;
  final double? fontSize;
  final Color? iconColor;
  final double radius;
  final IconData? icon;
  final Image? image;
  final void Function()? onPressed;

  const MainButton({
    super.key,
    this.width = 200,
    this.height = 45,
    this.color,
    this.textcolor,
    this.text = '',
    this.fontSize,
    this.iconColor,
    this.radius = 10,
    this.icon,
    this.image,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        fixedSize: WidgetStatePropertyAll(Size(width, height)),
        backgroundColor: WidgetStatePropertyAll(color),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius),
          ),
        ),
      ),
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (icon != null)
            Icon(
              icon,
              color: iconColor,
            ),
          if (image != null) image!,
          if (icon != null || image != null) const SizedBox(width: 8),
          CustomText(
            text: text,
            color: textcolor,
          )
        ],
      ),
    );
  }
}

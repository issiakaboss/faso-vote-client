import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../themes/app_colors.dart';
import '../themes/app_text_styles.dart';

class CustomButton {
  static Widget primaryButton({
    required void Function() onPressed,
    void Function(bool)? onFocusChange,
    void Function()? onLongPress,
    Color? backgroundColor,
    EdgeInsetsGeometry? padding,
    MainAxisSize mainAxisSize = MainAxisSize.min,
    Widget? prefix,
    Widget? surfix,
    Widget? child,
    required String buttonTitle,
    TextStyle? textStyle,
    double? fontSize,
    FontWeight? textFontWeight,
    double? elevation,
    Color? textColor,
    double? borderRadius,
    bool isDisabled = false,
  }) {
    return ElevatedButton(
      onPressed: onPressed,
      onFocusChange: onFocusChange,
      onLongPress: onLongPress,
      style: ElevatedButton.styleFrom(
        overlayColor: Colors.black,
        backgroundColor: isDisabled
            ? (backgroundColor?.withOpacity(0.5) ??
                AppColors.primary.withOpacity(0.5))
            : (backgroundColor ?? AppColors.primary),
        padding: padding ??
            const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 12.0),
        ),
        elevation: elevation ?? 2.0,
      ),
      child: child ??
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: mainAxisSize,
            children: [
              if (prefix != null) ...[prefix],
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  buttonTitle,
                  style: textStyle ??
                      AppTextStyles.buttonTextStyle()
                          .copyWith(fontSize: fontSize),
                  textAlign: prefix != null ? null : TextAlign.center,
                ),
              ),
              if (surfix != null) ...[surfix],
            ],
          ),
    );
  }

  static Widget outlineButton({
    required void Function() onPressed,
    void Function(bool)? onFocusChange,
    void Function()? onLongPress,
    Color? backgroundColor,
    Color? forgroundColor,
    Color? borderColor,
    EdgeInsetsGeometry? padding,
    MainAxisSize mainAxisSize = MainAxisSize.min,
    Widget? prefix,
    Widget? surfix,
    Widget? child,
    required String buttonTitle,
    TextStyle? textStyle,
    double? fontSize,
    FontWeight? textFontWeight,
    double? elevation,
    double? borderRadius,
    bool isCenterText = false,
  }) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        side: BorderSide(color: borderColor ?? AppColors.primary),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 8.0)),
        padding: padding ??
            const EdgeInsets.symmetric(horizontal: 12.0, vertical: 0.0),
      ),
      child: child ??
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: mainAxisSize,
            children: [
              if (prefix != null) ...[prefix],
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  buttonTitle,
                  
                  style: textStyle ??
                      AppTextStyles.buttonTextStyle().copyWith(
                        fontSize: fontSize,
                        color: forgroundColor ?? Get.theme.primaryColor,
                        fontWeight: textFontWeight,
                        
                      ),
                  textAlign:
                      prefix != null && !isCenterText ? null : TextAlign.center,
                ),
              ),
              if (surfix != null) ...[surfix],
            ],
          ),
    );
  }

  static Widget secondaryButton({
    required void Function()? onPressed,
    required String buttonTitle,
    Color? textColor,
    Color? backgroundColor,
    EdgeInsetsGeometry? padding,
    MainAxisSize mainAxisSize = MainAxisSize.max,
    Widget? prefix,
    Widget? surfix,
    TextStyle? textStyle,
    double? fontSize,
    double? borderRadius,
    bool isDisabled = false,
  }) {
    return TextButton(
      onPressed: isDisabled ? null : onPressed,
      style: TextButton.styleFrom(
        foregroundColor: textColor ?? AppColors.primary,
        backgroundColor: backgroundColor,
        padding: padding ??
            const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 8.0),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: mainAxisSize,
        children: [
          if (prefix != null) ...[
            prefix,
            const SizedBox(width: 8.0),
          ],
          Text(
            buttonTitle,
            style: textStyle ?? AppTextStyles.secondaryButtonTextStyle(),
          ),
          if (surfix != null) ...[
            const SizedBox(width: 8.0),
            surfix,
          ],
        ],
      ),
    );
  }
}

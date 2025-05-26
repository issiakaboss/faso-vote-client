import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

class AppTextStyles {
  static Color getColor({BuildContext? context}) {
    context = context ?? Get.context;
    return context == null
        ? AppColors.title
        : Theme.of(context).textTheme.labelMedium!.color!;
  }

  static TextStyle setColor({required TextStyle style, BuildContext? context}) {
    return style.copyWith(color: getColor(context: context));
  }

  // Headings
  static TextStyle heading1({BuildContext? context}) {
    return GoogleFonts.figtree(
      height: 0.0,
      fontSize: 32,
      fontWeight: FontWeight.bold,
      color: context != null
          ? Theme.of(context).textTheme.headlineLarge?.color
          : Get.theme.textTheme.headlineLarge?.color,
    );
  }

  static TextStyle heading2({BuildContext? context}) {
    return GoogleFonts.figtree(
      fontSize: 28,
      fontWeight: FontWeight.bold,
      color: context != null
          ? Theme.of(context).textTheme.headlineMedium?.color
          : Get.theme.textTheme.headlineMedium?.color,
    );
  }

  static TextStyle heading3({BuildContext? context}) {
    return GoogleFonts.figtree(
      fontSize: 24,
      fontWeight: FontWeight.w600,
      color: context != null
          ? Theme.of(context).textTheme.headlineMedium?.color
          : Get.theme.textTheme.headlineMedium?.color,
    );
  }

  static TextStyle heading4({BuildContext? context}) {
    return GoogleFonts.figtree(
      fontSize: 22,
      fontWeight: FontWeight.bold,
      color: context != null
          ? Theme.of(context).textTheme.headlineMedium?.color
          : Get.theme.textTheme.headlineMedium?.color,
    );
  }

  static TextStyle heading5({BuildContext? context}) {
    return GoogleFonts.figtree(
      fontSize: 16,
      fontWeight: FontWeight.bold,
      color: context != null
          ? Theme.of(context).textTheme.headlineSmall?.color
          : Get.theme.textTheme.headlineSmall?.color,
    );
  }

   static TextStyle heading6({BuildContext? context}) {
    return GoogleFonts.figtree(
      fontSize: 19,
      fontWeight: FontWeight.bold,
      color: context != null
          ? Theme.of(context).textTheme.bodyMedium?.color
          : Get.theme.textTheme.bodyMedium?.color,
    );
  }

  static TextStyle appBarTitle({BuildContext? context}) {
    return GoogleFonts.figtree(
      fontSize: 20,
      fontWeight: FontWeight.w600,
      color: context != null
          ? Theme.of(context).textTheme.titleLarge?.color
          : Get.theme.textTheme.titleLarge?.color,
    );
  }

  static TextStyle bodyText1({BuildContext? context}) {
    return GoogleFonts.figtree(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      color: context != null
          ? Theme.of(context).textTheme.bodyLarge?.color
          : Get.theme.textTheme.bodyLarge?.color,
    );
  }

  static TextStyle bodyText1Bold({BuildContext? context}) {
    return GoogleFonts.figtree(
      fontSize: 17,
      fontWeight: FontWeight.bold,
      color: context != null
          ? Theme.of(context).textTheme.bodyLarge?.color
          : Get.theme.textTheme.bodyLarge?.color,
    );
  }

  static TextStyle bodyText1Primary({BuildContext? context}) {
    return GoogleFonts.figtree(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: context != null
          ? Theme.of(context).primaryColor
          : Get.theme.primaryColor,
    );
  }

  static TextStyle bodyText2({BuildContext? context}) {
    return GoogleFonts.figtree(
      fontSize: 14,
      fontWeight: FontWeight.normal,
      color: context != null
          ? Theme.of(context).textTheme.bodyMedium?.color
          : Get.theme.textTheme.bodyMedium?.color,
    );
  }

  static TextStyle bodyText2Bold({BuildContext? context}) {
    return GoogleFonts.figtree(
      fontSize: 14,
      fontWeight: FontWeight.bold,
      color: context != null
          ? Theme.of(context).textTheme.bodyMedium?.color
          : Get.theme.textTheme.bodyMedium?.color,
    );
  }

  static TextStyle bodyText3({BuildContext? context}) {
    return GoogleFonts.figtree(
      fontSize: 12,
      fontWeight: FontWeight.normal,
      color: context != null
          ? Theme.of(context).textTheme.bodySmall?.color
          : Get.theme.textTheme.bodySmall?.color,
    );
  }

  static TextStyle buttonText({BuildContext? context}) {
    return GoogleFonts.figtree(
      fontSize: 16,
      fontWeight: FontWeight.bold,
      color: context != null
          ? Theme.of(context).colorScheme.onPrimary
          : Get.theme.colorScheme.onPrimary,
    );
  }

  static TextStyle buttonTextStyle({BuildContext? context}) {
    return GoogleFonts.figtree(
      fontSize: 16.0,
      fontWeight: FontWeight.w700,
      color: context != null
          ? Theme.of(context).colorScheme.onPrimary
          : Get.theme.colorScheme.onPrimary,
    );
  }

  static TextStyle secondaryButtonTextStyle({BuildContext? context}) {
    return GoogleFonts.figtree(
      fontSize: 16.0,
      fontWeight: FontWeight.w600,
      color: context != null
          ? Theme.of(context).primaryColor
          : Get.theme.primaryColor,
    );
  }

  static TextStyle caption({BuildContext? context}) {
    return GoogleFonts.figtree(
      fontSize: 10,
      fontWeight: FontWeight.bold,
      color: context != null
          ? Theme.of(context).textTheme.labelSmall?.color
          : Get.theme.textTheme.labelSmall?.color,
    );
  }

  static TextStyle inputText({BuildContext? context}) {
    return GoogleFonts.figtree(
      fontSize: 16,
      fontWeight: FontWeight.normal,
      color: context != null
          ? Theme.of(context).textTheme.bodyMedium?.color
          : Get.theme.textTheme.bodyMedium?.color,
    );
  }

  static TextStyle inputLabel({BuildContext? context}) {
    return GoogleFonts.figtree(
      fontSize: 16,
      fontWeight: FontWeight.normal,
      color: context != null
          ? Theme.of(context).textTheme.labelLarge?.color
          : Get.theme.textTheme.labelLarge?.color,
    );
  }

  static TextStyle errorText({BuildContext? context}) {
    return GoogleFonts.figtree(
      fontSize: 14,
      fontWeight: FontWeight.normal,
      color: context != null
          ? Theme.of(context).colorScheme.error
          : Get.theme.colorScheme.error,
    );
  }
}

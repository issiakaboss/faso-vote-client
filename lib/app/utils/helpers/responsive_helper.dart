import 'package:flutter/material.dart';

class ResponsiveHelper {
  final BuildContext context;
  final double screenWidth;

  ResponsiveHelper(this.context) : screenWidth = MediaQuery.of(context).size.width;

  bool get isMobile => screenWidth < 600;

  bool get isTablet => screenWidth >= 600 && screenWidth < 1024;

  bool get isDesktop => screenWidth >= 1024;
}

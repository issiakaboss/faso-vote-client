import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThemeController extends GetxController {
    static ThemeController get to => Get.find();
  RxBool isDarkMode = false.obs;
  void toggleTheme() {
    isDarkMode.value = !isDarkMode.value;
    // Apply the selected theme
    Get.changeThemeMode(isDarkMode.value ? ThemeMode.dark : ThemeMode.light);
  }
}

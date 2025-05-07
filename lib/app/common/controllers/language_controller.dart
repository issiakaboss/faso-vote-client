import 'package:faso_vote_client/app/utils/services/localization_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LanguageController extends GetxController {
  final LocalizationService localizationService = LocalizationService.to;
  static LanguageController get to => Get.find();
  void changeLanguage() {
    var currentLocale = Get.locale;
    var franchLocal = const Locale('fr', 'FR');
    var englishLocal = const Locale('en', 'US');
    Locale locale = currentLocale == franchLocal ? englishLocal : franchLocal;
    localizationService.updateLocale(locale);
    Get.updateLocale(locale);
  }
}

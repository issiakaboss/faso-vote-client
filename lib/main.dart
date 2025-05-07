import 'package:faso_vote_client/app/common/controllers/theme_controller.dart';
import 'package:faso_vote_client/app/themes/app_theme.dart';
import 'package:faso_vote_client/generated/locales.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'app/common/initial_binding.dart';
import 'app/config/env.dart';
import 'app/routes/app_pages.dart';
import 'app/utils/services/localization_service.dart';

void main() {
 WidgetsFlutterBinding.ensureInitialized();
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  runApp(
    GetMaterialApp(
         debugShowCheckedModeBanner: false,
      title: Env.appName,
      initialRoute: AppPages.splashscreen,
        initialBinding: InitialBinding(),
      getPages: AppPages.routes,
       locale: LocalizationService.to.getCurrentLocale(),
          fallbackLocale: const Locale('en', 'US'),
           translationsKeys: AppTranslation.translations,

            theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: Get.find<ThemeController>().isDarkMode.value
          ? ThemeMode.dark
          : ThemeMode.light,
    ),
  );
}

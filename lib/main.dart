import 'package:faso_vote_client/app/common/controllers/language_controller.dart';
import 'package:faso_vote_client/app/common/controllers/socket_controller.dart';
import 'package:faso_vote_client/app/common/controllers/theme_controller.dart';
import 'package:faso_vote_client/app/themes/app_theme.dart';
import 'package:faso_vote_client/generated/locales.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'app/common/initial_binding.dart';
import 'app/config/env.dart';
import 'app/routes/app_pages.dart';
import 'app/utils/services/localization_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);
  await dotenv.load(fileName: Env.isLocal ? Env.developement : Env.production);
  await GetStorage.init();
  Get.put(LocalizationService());
  Get.put(LanguageController());
  Get.put(ThemeController());
  Get.put(SocketController());
  await Get.putAsync(() => LocalizationService().init());

  runApp(
    GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: Env.appName,
        initialRoute: AppPages.DASHBOARD,
        initialBinding: InitialBinding(),
        getPages: AppPages.routes,
        locale: LocalizationService.to.getCurrentLocale(),
        fallbackLocale: const Locale('en', 'US'),
        translationsKeys: AppTranslation.translations,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: Get.find<ThemeController>().isDarkMode.value
            ? ThemeMode.dark
            : ThemeMode.light),
  );
}

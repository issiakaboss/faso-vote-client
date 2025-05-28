import 'package:faso_vote_client/app/routes/app_pages.dart';
import 'package:get/get.dart';

class SplashScreenController extends GetxController {
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    Future.delayed(
        const Duration(seconds: 2), () => Get.offNamed(AppPages.AUTH));
  }

  @override
  void onClose() {
    super.onClose();
  }
}

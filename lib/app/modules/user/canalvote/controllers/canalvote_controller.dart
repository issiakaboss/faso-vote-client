import 'package:get/get.dart';

import '../../../../utils/helpers/form_helper.dart';

class CanalvoteController extends GetxController {
  RxString errormessage = "".obs;
  RxString? phoneNumber = "+226 675435655".obs;
    final otpController = FormHelper.getController();
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}

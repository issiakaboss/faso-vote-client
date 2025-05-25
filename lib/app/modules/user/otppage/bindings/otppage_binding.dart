import 'package:get/get.dart';

import '../controllers/otppage_controller.dart';

class OtppageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OtppageController>(
      () => OtppageController(),
    );
  }
}

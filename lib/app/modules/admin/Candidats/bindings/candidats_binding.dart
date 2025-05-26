import 'package:get/get.dart';

import '../controllers/candidats_controller.dart';

class CandidatsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CandidatsController>(
      () => CandidatsController(),
    );
  }
}

import 'package:get/get.dart';

import '../controllers/canalvote_controller.dart';

class CanalvoteBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CanalvoteController>(
      () => CanalvoteController(),
    );
  }
}

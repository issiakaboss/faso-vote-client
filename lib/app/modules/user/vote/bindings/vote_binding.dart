import 'package:get/get.dart';

import '../controllers/vote_controller.dart';

class VoteBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VoteController>(
      () => VoteController(),
    );
  }
}

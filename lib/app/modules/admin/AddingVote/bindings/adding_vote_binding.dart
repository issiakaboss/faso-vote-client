import 'package:get/get.dart';

import '../controllers/adding_vote_controller.dart';

class AddingVoteBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddingVoteController>(
      () => AddingVoteController(),
    );
  }
}

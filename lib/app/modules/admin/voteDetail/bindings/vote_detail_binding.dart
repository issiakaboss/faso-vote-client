import 'package:faso_vote_client/app/modules/admin/Candidats/controllers/candidats_controller.dart';
import 'package:faso_vote_client/app/modules/admin/results/controllers/results_controller.dart';
import 'package:get/get.dart';

import '../controllers/vote_detail_controller.dart';

class VoteDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VoteDetailController>(
      () => VoteDetailController(),
    );
    Get.lazyPut<CandidatsController>(
      () => CandidatsController(),
    );
    Get.lazyPut<ResultsController>(
      () => ResultsController(),
    );
  }
}

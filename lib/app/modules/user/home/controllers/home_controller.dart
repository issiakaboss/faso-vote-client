import 'package:faso_vote_client/app/common/controllers/socket_controller.dart';
import 'package:faso_vote_client/app/data/models/candidate.dart';
import 'package:faso_vote_client/app/data/models/vote_candidats.dart';
import 'package:get/get.dart';

import '../../../../data/providers/vote_provider.dart';

class HomeController extends GetxController {
  SocketController socketController = Get.find<SocketController>();
  var selectedTab = 0.obs;
Rxn<VoteCandidats> voteCandidats=Rxn<VoteCandidats>();
 
  @override
  void onInit() {
    super.onInit();
    socketController.connectToSocket(voteId: 1);
    loadVoteCandidats();
  }


   void loadVoteCandidats() async {
    final vote_candidats = await VoteProvider().fetchVoteCandidats(
      voteId: 1,
      onError: (error) => Get.snackbar('Erreur', error),
    );
    if (vote_candidats != null) {
      voteCandidats.value = vote_candidats;
    }
  }
}

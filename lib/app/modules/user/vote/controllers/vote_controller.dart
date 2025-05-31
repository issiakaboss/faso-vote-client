import 'package:faso_vote_client/app/common/controllers/socket_controller.dart';
import 'package:faso_vote_client/app/data/models/statistic.dart';
import 'package:faso_vote_client/app/data/models/vote_candidats.dart';
import 'package:get/get.dart';

import '../../../../data/providers/vote_provider.dart';

class VoteController extends GetxController {
  SocketController socketController = Get.find<SocketController>();
  var selectedTab = 0.obs;
  Rxn<VoteCandidats> voteCandidats = Rxn<VoteCandidats>();

  @override
  void onInit() {
    super.onInit();
    var voteId = Get.parameters['id'];
    if (voteId != null) {
      socketController.connectToSocket(
        voteId: voteId,
        onVoteUpdated: (int candidatId, int voix, StatisticModel newStatistic) {
          // Met à jour localement le candidat correspondant
          final candidats = voteCandidats.value?.candidats;

          if (candidats != null) {
            final index = candidats.indexWhere((c) => c.id == candidatId);
            if (index != -1) {
              candidats[index] = candidats[index].copyWith(voix: voix);
              voteCandidats.refresh();
            }

            voteCandidats.value = voteCandidats.value!.copyWith(
              statistic: newStatistic,
            );
            voteCandidats.refresh();
          }
        },
      );
      loadVoteCandidats(voteId: voteId);
    } else {
      Get.snackbar("Erreur", "Aucun identifiant de vote trouvé dans l'URL.");
    }
  }

  void loadVoteCandidats({required String voteId}) async {
    final _voteCandidats = await VoteProvider().fetchGuestVoteCandidats(
      voteId: voteId,
      onError: (error) => Get.snackbar('Erreur', error),
    );
    if (_voteCandidats != null) {
      voteCandidats.value = _voteCandidats;
    }
  }
}

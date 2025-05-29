import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/controllers/socket_controller.dart';
import '../../../../data/models/statistic.dart';
import '../../../../data/models/vote_candidats.dart';
import '../../../../data/providers/vote_provider.dart';
import '../../Candidats/views/adding_candidat_view.dart';

class VoteDetailController extends GetxController {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  Rx<Widget> currentEndDrawer = Rx(Container());
  SocketController socketController = Get.find<SocketController>();
  Rxn<VoteCandidats> voteCandidats = Rxn<VoteCandidats>();
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

  void loadVoteCandidats({required String voteId}) async {
    final _voteCandidats = await VoteProvider().fetchVoteCandidats(
      voteId: voteId,
      onError: (error) => Get.snackbar('Erreur', error),
    );
    if (_voteCandidats != null) {
      voteCandidats.value = _voteCandidats;

      if (voteCandidats.value?.vote.uuid != null) {
        socketController.connectToSocket(
          voteId: voteCandidats.value!.vote.uuid,
          onVoteUpdated:
              (int candidatId, int voix, StatisticModel newStatistic) {
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
      }
    }
  }

  Future<void> updateEnddraw(Widget newEndDrawer) async {
    currentEndDrawer.value = newEndDrawer;
  }

  void displayAddCandidatView({required int voteId}) {
    updateEnddraw(AddingCandidatView(voteId: voteId));
    scaffoldKey.currentState!.openEndDrawer();
  }

  void closeAddCandidatView() {
    scaffoldKey.currentState!.closeEndDrawer();
  }
}

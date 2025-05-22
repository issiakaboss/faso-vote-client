import 'package:get/get.dart';

import '../../../../data/models/vote.dart';
import '../../../../data/providers/vote_provider.dart';

class DashboardController extends GetxController {
  final votes = <VoteModel>[].obs;
  final selectedToggleIndex = 0.obs;
  @override
  void onInit() {
    super.onInit();
    _loadVotes();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void _loadVotes() async {
    //    final voteList = await VoteProvider().fetchVotes(
    //   onError: (error) => Get.snackbar('Erreur', error),
    // );
    // votes.value = voteList;
    votes.value = [
      VoteModel(
        title: "Ministère de l'éducation",
        location: "Ouagadougou",
        date: "02 Fev 2025",
        duration: "2h",
        status: "En cours",
      ),
      VoteModel(
        title: "President de CIB",
        location: "Koudougou",
        date: "02 Fev 2025",
        duration: "24h",
        status: "Bloqué",
      ),
      VoteModel(
        title: "Chef de Police",
        location: "Ouagadougou",
        date: "02 Fev 2025",
        duration: "1 jour",
        status: "Terminé",
      ),
      VoteModel(
        title: "Directeur général",
        location: "Ouagadougou",
        date: "02 Fev 2025",
        duration: "3h",
        status: "En cours",
      ),
    ];
  }
}

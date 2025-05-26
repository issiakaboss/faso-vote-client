import 'package:get/get.dart';
import '../../../../data/models/vote.dart';
import '../../../../data/providers/vote_provider.dart';
import '../../../../utils/helpers/dialog_helper.dart';

class DashboardController extends GetxController {
  VoteProvider _voteProvider = VoteProvider();
  RxList<VoteModel> votes = RxList<VoteModel>([]);
  final selectedToggleIndex = 0.obs;
  @override
  void onInit() {
    super.onInit();
    loadVotes();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void loadVotes() async {
    final voteList = await VoteProvider().fetchVotes(
      onError: (error) => Get.snackbar('Erreur', error),
    );
    if (voteList != null) {
      votes.value = voteList;
    }
  }

  void deleteVote({required int voteId}) async {
    DialogHelper.showConfirmationDialog(
      title: "Suppression",
      message: "Voullez-vous vraiment supprimer cette donnée?",
      onConfirm: () async {
        final success =
            await _voteProvider.deleteVote(voteId: voteId.toString());
        if (success) {
          votes.removeWhere((vote) => vote.id == voteId);

          loadVotes();
          DialogHelper.showSuccessSnackbar(
              message: 'Candidat deleted successfully');
        } else {
          throw Exception('Failed to delete candidat');
        }
      },
    );
  }
}

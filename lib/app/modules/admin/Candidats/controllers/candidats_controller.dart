import 'package:faso_vote_client/app/data/providers/candidat_provider.dart';
import 'package:faso_vote_client/app/modules/admin/voteDetail/controllers/vote_detail_controller.dart';
import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';

import '../../../../data/models/candidat.dart';
import '../../../../utils/helpers/candidat_form_data.dart';
import '../../../../utils/helpers/dialog_helper.dart';
import '../views/adding_candidat_view.dart';

class CandidatsController extends GetxController {
  VoteDetailController _voteDetailController = Get.find<VoteDetailController>();
  CandidatProvider _candidatProvider = CandidatProvider();
  final RxBool isEditMode = false.obs;
  final RxnInt candidatId = RxnInt(null);
  final RxnInt voteId = RxnInt(null);

  final form = CandidateFormData();

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

  void initForEdit(Candidat candidat) async {
    isEditMode.value = true;
    candidatId.value = candidat.id;
    Candidat? editingCandidat =
        await loadCandidatsEditData(candidatId: candidat.id);
    form.fullNameController.text = editingCandidat?.fullName ?? '';
    form.etablissementController.text = editingCandidat?.etablissement ?? '';
    form.themeController.text = editingCandidat?.theme ?? '';
    form.existingCandidatPhoto.value =
        _convertUrlToFile(editingCandidat?.photoUrl ?? '');
  }

  Future<Candidat?> loadCandidatsEditData({required int candidatId}) async {
    final editingCandidate = await _candidatProvider.fetchEditCandidatData(
      candidatId: candidatId,
      onError: (error) => Get.snackbar('Erreur', error),
    );
    if (editingCandidate != null) {
      return editingCandidate;
    }
    return null;
  }

  PlatformFile _convertUrlToFile(String url) {
    return PlatformFile(
      name: url.split('/').last,
      path: url,
      size: 0,
      bytes: null,
    );
  }

  void resetCandidateForm() {
    form.fullNameController.clear();
    form.etablissementController.clear();
    form.themeController.clear();
    form.candidatPhoto.value = null;
    form.existingCandidatPhoto.value = null;
    form.fullNameError.value = null;
    form.etablissementError.value = null;
    form.themeError.value = null;
    form.formKey.currentState?.reset();
  }

  void saveCandidatsData({required int voteId}) async {
    if (!form.formKey.currentState!.validate()) return;

    final data = {
      'vote_id': voteId.toString(),
      'full_name': form.fullNameController.text.trim(),
      'university': form.etablissementController.text.trim(),
      'theme': form.themeController.text.trim(),
    };
    final photo = form.candidatPhoto.value;
    dynamic response;

    if (isEditMode.value) {
      response = await _candidatProvider.editCandidate(
        candidatId: candidatId.value.toString(),
        candidat: data,
        photo: photo,
        onError: (error) => DialogHelper.showErrorSnackbar(message: error),
      );
    } else {
      response = await _candidatProvider.storeCandidate(
        candidat: data,
        photo: photo,
        onError: (error) => DialogHelper.showErrorSnackbar(message: error),
      );
    }

    if (response != null) {
      _voteDetailController.loadVoteCandidats(voteId: voteId.toString());
      _voteDetailController.closeAddCandidatView();
      resetCandidateForm();
      DialogHelper.showSuccessSnackbar(
          message: "Candidat enregistré avec succès !");
    }
  }

  void deleteCandidat({required int candidatId}) async {
    if (Get.isSnackbarOpen) {
      await Get.closeCurrentSnackbar();
    }
    DialogHelper.showConfirmationDialog(
      title: "Suppression",
      message: "Voullez-vous vraiment supprimer cette donnée?",
      onConfirm: () async {
        final success = await _candidatProvider.deleteCandidat(
          candidatId: candidatId.toString(),
        );
        if (success) {
          _voteDetailController.voteCandidats.value?.candidats
              .removeWhere((candidat) => candidat.id == candidatId);
          _voteDetailController.voteCandidats.refresh();
          DialogHelper.showSuccessSnackbar(
              message: 'Candidat deleted successfully');
        } else {
          throw Exception('Failed to delete candidat');
        }
      },
    );
  }

  void displayEditCandidatView(
      {required int voteId, required Candidat candidat}) {
    _voteDetailController
        .updateEnddraw(AddingCandidatView(voteId: voteId, candidat: candidat));
    _voteDetailController.scaffoldKey.currentState!.openEndDrawer();
  }

  void closeAndDrawer() {
    _voteDetailController.closeAddCandidatView();
  }
}

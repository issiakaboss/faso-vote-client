import 'package:faso_vote_client/app/data/models/edit_vote.dart';
import 'package:faso_vote_client/app/data/models/vote.dart';
import 'package:faso_vote_client/app/data/providers/vote_provider.dart';
import 'package:faso_vote_client/app/modules/admin/dashboard/controllers/dashboard_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:file_picker/file_picker.dart';
import '../../../../utils/helpers/dialog_helper.dart';
import '../../../../utils/helpers/form_helper.dart';

class AddingVoteController extends GetxController {
  DashboardController dashboardController = DashboardController();
  VoteProvider _voteProvider = VoteProvider();
  GlobalKey<FormState> voteDataFormkey = GlobalKey<FormState>();
  Rx<PlatformFile?> voteLogo = Rx<PlatformFile?>(null);
  Rx<PlatformFile?> existingVoteLogo = Rx<PlatformFile?>(null);
  final RxBool isEditMode = false.obs;
  final RxnInt voteId = RxnInt(null);

  var eventNameController = FormHelper.getController();
  var descriptionController = FormHelper.getController();

  // Error messages
  RxnString eventNameError = RxnString(null);
  RxnString descriptionError = RxnString(null);
  Rxn<DateTime> selectedStartDateTime = Rxn<DateTime>();
  Rxn<DateTime> selectedEndDateTime = Rxn<DateTime>();

  void selectStartDateTime(DateTime dateTime) {
    selectedStartDateTime.value = dateTime;
  }

  void selectEndDateTime(DateTime dateTime) {
    selectedEndDateTime.value = dateTime;
  }

  @override
  void onInit() {
    super.onInit();
    // initdata();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void initdata() {
    eventNameController.text = "Mt-180 seconde";
    descriptionController.text =
        "I am writing regarding the cancellation of my TOEFL exam on March,";
  }

  void initForEdit(VoteModel vote) async {
    isEditMode.value = true;
    voteId.value = vote.id;
    EditVote? editingVote = await loadVoteEditData(voteId: vote.id);
    eventNameController.text = editingVote?.title ?? '';
    descriptionController.text = editingVote?.description ?? '';
    selectedStartDateTime.value = editingVote?.startDate;
    selectedEndDateTime.value = editingVote?.endDate;
    existingVoteLogo.value = _convertUrlToFile(editingVote?.logo ?? '');
  }

  Future<EditVote?> loadVoteEditData({required int voteId}) async {
    final editingVote = await _voteProvider.fetchEditVoteData(
        voteId: voteId, onError: (error) => Get.snackbar('Erreur', error));
    if (editingVote != null) {
      return editingVote;
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

  void setVoteLogo(PlatformFile? file) {
    voteLogo.value = file;
    existingVoteLogo.value = null;
    update();
  }

  void saveVoteData() async {
    // Get.toNamed(AppPages.CANDIDATS);
    if (!voteDataFormkey.currentState!.validate()) return;
    final start = selectedStartDateTime.value;
    final end = selectedEndDateTime.value;
    final voteData = {
      'event_name': eventNameController.text,
      'description': descriptionController.text,
      'start_datetime': start?.toIso8601String(),
      'end_datetime': end?.toIso8601String(),
    };

    dynamic response;

    if (isEditMode.value) {
      response = await _voteProvider.updateVote(
        voteId: voteId.value.toString(),
        voteData: voteData,
        logo: voteLogo.value,
        onError: (error) => DialogHelper.showErrorSnackbar(message: error),
      );
    } else {
      response = await _voteProvider.storeVote(
        voteData: voteData,
        logo: voteLogo.value,
        onError: (error) => DialogHelper.showErrorSnackbar(message: error),
      );
    }

    if (response != null) {
      _clearVoteFormData();
      Get.back(result: true); 
      DialogHelper.showSuccessSnackbar(
        message: isEditMode.value
            ? "Événement de vote mis à jour avec succès!"
            : "Événement de vote créé avec succès!",
      );
    }
  }

  void _clearVoteFormData() {
    eventNameController.clear();
    descriptionController.clear();
    selectedStartDateTime.value = null;
    selectedEndDateTime.value = null;
    voteLogo.value = null;
    voteDataFormkey.currentState?.reset();
    update();
  }
}

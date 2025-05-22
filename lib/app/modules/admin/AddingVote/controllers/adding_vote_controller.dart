import 'package:faso_vote_client/app/data/providers/vote_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:file_picker/file_picker.dart';
import '../../../../utils/helpers/dialog_helper.dart';
import '../../../../utils/helpers/form_helper.dart';

class AddingVoteController extends GetxController {
  VoteProvider _voteProvider = VoteProvider();
  GlobalKey<FormState> voteDataFormkey = GlobalKey<FormState>();
  final Rx<PlatformFile?> existingLogoFiles = Rx<PlatformFile?>(null);
  Rx<PlatformFile?> voteLogo = Rx<PlatformFile?>(null);
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
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void setVoteLogo(PlatformFile? file) {
    voteLogo.value = file;
    existingLogoFiles.value = null;
    update();
  }

  void saveVoteData() async {
    if (!voteDataFormkey.currentState!.validate()) return;
    final start = selectedStartDateTime.value;
    final end = selectedEndDateTime.value;

    String formattedDuration = '';
    if (start != null && end != null) {
      final duration = end.difference(start);
      if (duration.inDays >= 1) {
        formattedDuration =
            '${duration.inDays} jour${duration.inDays > 1 ? 's' : ''}';
      } else {
        formattedDuration = '${duration.inHours}h';
      }
    }
    final voteData = {
      'event_name': eventNameController.text,
      'description': descriptionController.text,
      'duration': formattedDuration,
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
      DialogHelper.showSuccessSnackbar(
        message: isEditMode.value
            ? "Événement de vote mis à jour avec succès!"
            : "Événement de vote créé avec succès!",
      );
      _clearVoteFormData();
      Get.back();
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

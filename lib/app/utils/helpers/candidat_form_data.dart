import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'form_helper.dart';

class CandidateFormData {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final fullNameController = FormHelper.getController();
  final etablissementController = FormHelper.getController();
  final themeController = FormHelper.getController();
  Rx<PlatformFile?> candidatPhoto = Rx<PlatformFile?>(null);
   final Rx<PlatformFile?> existingCandidatPhoto = Rx<PlatformFile?>(null);

  // Error messages
  RxnString fullNameError = RxnString(null);
  RxnString etablissementError = RxnString(null);
  RxnString themeError = RxnString(null);
  CandidateFormData();

   void setHotelLogo(PlatformFile? file) {
    candidatPhoto.value = file;
    existingCandidatPhoto.value = null;
  }
}

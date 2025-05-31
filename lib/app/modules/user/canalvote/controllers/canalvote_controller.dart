import 'package:faso_vote_client/app/data/providers/auth_provider.dart';
import 'package:faso_vote_client/app/data/providers/vote_provider.dart';
import 'package:faso_vote_client/app/utils/helpers/dialog_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/phone_number.dart';
import '../../../../../generated/locales.g.dart';
import '../../../../core/network/auth_service.dart';
import '../../../../data/models/votant.dart';
import '../../../../routes/app_pages.dart';
import '../../../../utils/helpers/form_helper.dart';

class CanalvoteController extends GetxController {
  AuthProvider _authProvider = AuthProvider();
  VoteProvider _voteProvider = VoteProvider();
  RxnString errorMessage = RxnString();
  final otpController = FormHelper.getController();
  final phoneFormKey = GlobalKey<FormState>();
  RxBool isLoding = RxBool(false);
  RxString loadingMessage = RxString("");

  Rx<PhoneNumber> currentPhoneNumber = Rx<PhoneNumber>(
      PhoneNumber(countryCode: '', countryISOCode: '', number: ''));
  GlobalKey<FormState> otpFormkey = GlobalKey<FormState>();

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

  void setLoading({String loadMessage = "Loading..."}) {
    isLoding.value = true;
    loadingMessage.value = loadMessage;
  }

  void stopLoading() {
    isLoding.value = false;
    loadingMessage.value = "Loading...";
  }

  void sendOtpRequest(Map<String, dynamic>? voteCandidatData) async {
    errorMessage.value = null;
    if (currentPhoneNumber.value.number.isEmpty) {
      errorMessage.value = "Veillez saisir votre numero de telephone";
      return;
    }
    if (phoneFormKey.currentState?.validate() != true) {
      return;
    }
    if (voteCandidatData == null) {
      errorMessage.value =
          "Probleme de donnée! fermer l'application et reesayer.";
      return;
    }
    Map<String, String> phoneData = {
      'country_iso_code': currentPhoneNumber.value.countryISOCode,
      'country_code': currentPhoneNumber.value.countryCode,
      'phone': currentPhoneNumber.value.countryCode +
          currentPhoneNumber.value.number,
      'vote_uuid': voteCandidatData?['voteUuid'],
    };

    setLoading(loadMessage: LocaleKeys.login_loading.tr);
    dynamic response = await _authProvider.sendOtp(phoneData: phoneData);
    stopLoading();
    if (response != null) {
      bool isSuccess = response['success'];
      if (isSuccess) {
        Votant votant = Votant.fromJson(response['data']);
        voteCandidatData['votant'] = votant;
        if (votant.isVerified) {
          Get.toNamed(AppPages.FINAL_VOTE, arguments: voteCandidatData);
        } else {
          Get.toNamed(AppPages.OTP, arguments: voteCandidatData);
        }
      } else {
        errorMessage.value = response['message'];
      }
    }
  }

  Future<void> verifyOtp(
      {Map<String, dynamic>? voteCandidatData, required Votant? votant}) async {
    errorMessage.value = null;
    if (!otpFormkey.currentState!.validate()) return;
    var otpData = {
      "otp": otpController.text,
      'identity': votant?.identity,
      'vote_id': votant?.voteId,
    };

    setLoading();
    dynamic response = await _authProvider.verifyOtp(otpData: otpData);
    stopLoading();
    if (response != null) {
      bool isSuccess = response['success'];
      if (isSuccess) {
        Votant votant = Votant.fromJson(response['data']);
        voteCandidatData?['votant'] = votant;
        Get.toNamed(AppPages.FINAL_VOTE, arguments: voteCandidatData);
      } else {
        errorMessage.value = response['message'];
      }
    }
  }

  void handelGoogleAuth({Map<String, dynamic>? voteCandidatData}) async {
    errorMessage.value = null;
    setLoading(loadMessage: LocaleKeys.login_loading.tr);
    final response = await AuthService.signInWithGoogle(
        voteUuid: voteCandidatData?['voteUuid']);
    stopLoading();
    if (response != null) {
      bool isSuccess = response['success'];
      if (isSuccess) {
        Votant votant = Votant.fromJson(response['data']);
        voteCandidatData?['votant'] = votant;
        Get.toNamed(AppPages.FINAL_VOTE, arguments: voteCandidatData);
      } else {
        errorMessage.value = response['message'];
      }
    }
  }

  Future<void> validateVote(
      {Map<String, dynamic>? validateData,
      required String candidatId,
      required String voteUuid}) async {
    setLoading();
    var response = await _voteProvider.validateVote(
        validateData: validateData!, candidatId: candidatId);
    stopLoading();
    if (response != null && response['data'] != null) {
      DialogHelper.displaySuccessDialog(
        message: "Votre vote a été pris en compte avec succes. ",
        onConfirmBtnTap: () {
          Get.offAllNamed('${Routes.vote}/$voteUuid');
        },
      );
    }
  }
}

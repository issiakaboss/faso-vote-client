import 'package:faso_vote_client/app/data/models/phone.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:faso_vote_client/app/data/providers/auth_provider.dart';

class OtpController extends GetxController {

  AuthProvider authProvider = AuthProvider();
  GlobalKey<FormState> otpFormkey = GlobalKey<FormState>();
  final otpController = TextEditingController();
  var isLoading = false.obs;
   RxString loadingMessage = RxString("En cours de verification......");
void setLoading({String loadMessage = "Loading..."}) {
    isLoading.value = true;
    loadingMessage.value = loadMessage;
  }

  void stopLoading() {
    isLoading.value = false;
    loadingMessage.value = "Loading...";
  }
 Future<bool> verifyOtp(
      {required Phone phone,
      required bool isPhone}) async {
    if (!otpFormkey.currentState!.validate()) return false;
    setLoading();
    bool isVerified = await authProvider.verifyOtp(
        phoneId: phone.id!, otp: otpController.text, isPhone: isPhone);
    stopLoading();

    return isVerified;
  }

  Future<void> resendOtp({required Phone phone, required bool isPhone}) async {
    setLoading();
    await authProvider
        .resendOtp(phoneId: phone.id!, isPhone: isPhone)
        .then((response) {
      stopLoading();
    });
  }
}

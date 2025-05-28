import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../generated/locales.g.dart';
import '../../../../data/providers/auth_provider.dart';
import '../../../../routes/app_pages.dart';
import '../../../../utils/helpers/form_helper.dart';

class AuthController extends GetxController {
  AuthProvider authProvider = AuthProvider();
  GlobalKey<FormState> loginFormkey = GlobalKey<FormState>();
  var emailController = FormHelper.getController();
  var passwordController = FormHelper.getController();
  RxnString emailError = RxnString(null);
  RxnString passwordError = RxnString(null);

  RxnString errorMessage = RxnString(null);

  RxBool isLoding = RxBool(false);
  RxString loadingMessage = RxString("");
  @override
  void onInit() {
    super.onInit();
    emailController.text = "test@example.com";
    passwordController.text = "password";
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

  void login() {
    if (!loginFormkey.currentState!.validate()) return;
    setLoading(loadMessage: LocaleKeys.login_loading.tr);
    var data = {
      "email": emailController.text,
      "password": passwordController.text,
    };
    authProvider
        .login(
      data: data,
      onError: (value) {
        errorMessage.value = value.toString();
      },
    )
        .then((user) async {
      stopLoading();
      if (user != null) {
        Get.offAllNamed(AppPages.DASHBOARD);
      }
    });
  }
}

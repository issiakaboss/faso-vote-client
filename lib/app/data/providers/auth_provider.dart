import 'package:faso_vote_client/app/data/providers/base_provider.dart';
import 'package:flutter/material.dart';
import 'package:faso_vote_client/app/data/models/phone.dart';
import 'package:faso_vote_client/app/data/models/token.dart';
import 'package:faso_vote_client/app/data/models/user.dart';
import 'package:faso_vote_client/app/data/providers/api_provider.dart';
import 'package:faso_vote_client/app/utils/enums/api_routes.dart';
import 'package:faso_vote_client/app/utils/helpers/dialog_helper.dart';
import 'package:get/get.dart';
import '../../core/api/exception.dart';
import '../../routes/app_pages.dart';

class AuthProvider with BaseProvider {
  Future<User?> login({
    required Map<String, String> data,
    ValueSetter? onError,
  }) async {
    try {
      return await ApiProvider.post(
        auth: false,
        apiURL: ApiRoutes.login.path,
        data: data,
      ).catchError((error) {
       
        if (onError != null) {
          onError((error as ApiException).message);
        }
      }).then((response) {
        if (response != null) {
          Token.saveAuthToken(response['token']);
          User user = User.fromJson(response['data']);
          User.saveUser(user);
          return user;
        }
        return null;
      });
    } catch (e) {
      if (onError != null) {
        onError(e);
      }
      return null;
    }
  }

  Future<bool> logout({
    ValueSetter? onError,
  }) async {
    showLoading();
    return await ApiProvider.post(
      auth: true,
      apiURL: ApiRoutes.logout.path,
      data: {},
    ).catchError((error) {
      hideLoading();
      if (onError != null) {
        onError((error as ApiException).message);
      }
    }).then((value) {
      hideLoading();
      if (value != null) {
        Token.clearAuthToken();
        User.clearUser();
        Get.offAllNamed(AppPages.AUTH);
        return true;
      }
      return false;
    });
  }

  Future<Phone?> signUp({
    required String phone,
    required String password,
    required String confirmPassword,
    ValueSetter? error,
  }) async {
    try {
      return await ApiProvider.post(
        auth: false,
        apiURL: ApiRoutes.register.path,
        data: {
          'phone': phone,
          'password': password,
          'password_confirmation': confirmPassword
        },
      ).catchError(handleError).then((response) {
        if (response != null) {
          Token.savePhoneToken(response['token']);
          Phone phone = Phone.fromJson(response['data']);
          Phone.savePhone(phone);
          return phone;
        }
        return null;
      });
    } catch (e) {
      DialogHelper.showErrorSnackbar(message: "Sign-up error: $e");
      return null;
    }
  }

  Future<bool> verifyOtp(
      {required int phoneId,
      required String otp,
      required bool isPhone}) async {
    try {
      return await ApiProvider.get(
        auth: true,
        isPhone: isPhone,
        apiURL: ApiRoutes.verifyOtp
            .format({'phone_id': phoneId.toString(), 'code': otp}),
      ).catchError(handleError).then((response) {
        if (response != null) {
          return true;
        }
        return false;
      });
    } catch (e) {
      DialogHelper.showErrorSnackbar(message: "Verify otp error: $e");
      return false;
    }
  }

  Future<bool> resendOtp({required int phoneId, required bool isPhone}) async {
    try {
      return await ApiProvider.get(
        auth: true,
        isPhone: isPhone,
        apiURL: ApiRoutes.resendOtp.format({'phone_id': phoneId.toString()}),
      ).catchError(handleError).then((response) {
        if (response != null) {
          return true;
        }
        return false;
      });
    } catch (e) {
      DialogHelper.showErrorSnackbar(message: "Resend otp error: $e");
      return false;
    }
  }
}

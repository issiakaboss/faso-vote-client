import 'package:faso_vote_client/app/common/controllers/base_controller.dart';
import 'package:flutter/material.dart';
import 'package:faso_vote_client/app/data/models/phone.dart';
import 'package:faso_vote_client/app/data/models/token.dart';
import 'package:faso_vote_client/app/data/models/user.dart';
import 'package:faso_vote_client/app/data/providers/api_provider.dart';
import 'package:faso_vote_client/app/utils/enums/api_routes.dart';
import 'package:faso_vote_client/app/utils/helpers/dialog_helper.dart';

class AuthProvider with BaseController {
  Future<User?> login({
    required String phone,
    required String password,
    ValueSetter? error,
  }) async {
    try {
      return await ApiProvider.post(
        auth: false,
        apiURL: ApiRoutes.login.path,
        data: {'phone': phone, 'password': password},
      ).catchError(handleError).then((response) {
        if (response != null) {
          Token.saveAuthToken(response['token']);
          User user = User.fromJson(response['data']);
          User.saveUser(user);
          return user;
        }
        return null;
      });
    } catch (e) {
      DialogHelper.showErrorSnackbar(message: "Login error: $e");
      return null;
    }
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

  Future<bool> storeSecret({
    required String secret,
    ValueSetter? error,
  }) async {
    try {
      return await ApiProvider.post(
        auth: true,
        apiURL: ApiRoutes.storeSecret.path,
        data: {'secret': secret},
      ).catchError(handleError).then((response) {
        if (response != null) {
          return true;
        }
        return false;
      });
    } catch (e) {
      DialogHelper.showErrorSnackbar(message: "Store secret error: $e");
      return false;
    }
  }

  Future<Phone?> storeNewPhone({required String phoneNumber}) async {
    try {
      return await ApiProvider.post(
        auth: true,
        apiURL: ApiRoutes.storePhone.path,
        data: {"number": phoneNumber},
      ).catchError(handleError).then((response) {
        if (response != null) {
          return Phone.fromJson(response['data']);
        }
        return null;
      });
    } catch (e) {
      DialogHelper.showErrorSnackbar(message: "Store phone error: $e");
      return null;
    }
  }

  Future<bool> removePhone({required int phoneId}) async {
    try {
      return await ApiProvider.delete(
        auth: true,
        apiURL: ApiRoutes.removePhone.format({'phone': phoneId.toString()}),
      ).catchError(handleError).then((response) {
        if (response != null) {
          return true;
        }
        return false;
      });
    } catch (e) {
      DialogHelper.showErrorSnackbar(message: "remove phone error: $e");
      return false;
    }
  }

  Future<void> refreshWithSecret({
    required String secret,
    ValueSetter? error,
  }) async {
    try {
      return await ApiProvider.post(
        auth: true,
        apiURL: ApiRoutes.refreshWithSecret.path,
        data: {'secret': secret},
      ).catchError(handleError).then((response) {
        if (response != null) {}
      });
    } catch (e) {
      DialogHelper.showErrorSnackbar(message: "Refresh secret error: $e");
    }
  }

  Future<bool> logout() async {
    try {
      return await ApiProvider.post(
        auth: true,
        apiURL: ApiRoutes.logout.path,
        data: {},
      ).catchError(handleError).then((response) {
        if (response != null) {
          return true;
        }
        return false;
      });
    } catch (e) {
      DialogHelper.showErrorSnackbar(message: "Logout error: $e");
      return false;
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

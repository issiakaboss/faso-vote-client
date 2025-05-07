import 'package:faso_vote_client/generated/locales.g.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constants/app_constant.dart';

class FormValidator {
  // Email validator
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return LocaleKeys.email_required.tr;
    }
    if (!RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$')
        .hasMatch(value)) {
      return LocaleKeys.invalid_email.tr;
    }
    return null;
  }

  // Password validator
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return LocaleKeys.password_required.tr;
    }
    if (value.length < AppConstant.passWordMinLength) {
      return LocaleKeys.password_length
          .trParams({'pwlength': AppConstant.passWordMinLength.toString()}).tr;
    }
    return null;
  }

  // Simple test validator
  static String? validateSimpleText(String? value) {
    if (value == null || value.isEmpty) {
      return LocaleKeys.field_required.tr;
    }

    return null;
  }

  // Phone number validator
  static String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return LocaleKeys.phone_required.tr;
    }
    if (value.length != AppConstant.phoneMaxLength) {
      return LocaleKeys.phone_length
          .trParams({'phonelength': AppConstant.phoneMaxLength.toString()});
    }
    // if (!RegExp(r'^\+?[1-9]\d{1,14}$').hasMatch(value)) {
    //   return LocaleKeys.invalid_phone.tr;
    // }
    return null;
  }

  // Amount validator
  static String? validateAmount(String? value) {
    if (value == null || value.isEmpty) {
      return LocaleKeys.amount_required.tr;
    }

    // Check if the input is a valid number
    final amount = double.tryParse(value);
    if (amount == null || amount <= 0) {
      return LocaleKeys.invalid_amount.tr;
    }

    return null; // No error
  }

  // OTP validator
  static String? validateOTP(String? value) {
    if (value == null || value.isEmpty) {
      return LocaleKeys.otp_required.tr;
    }
    if (value.length != AppConstant.otpLength) {
      return LocaleKeys.otp_length.tr;
    }
    return null;
  }

  static String? validateConfirmPassword(
      {String? value, required TextEditingController passwordController}) {
    if (value == null || value.isEmpty) {
      return LocaleKeys.password_required.tr;
    }
    if (value.length < AppConstant.passWordMinLength) {
      return LocaleKeys.password_length
          .trParams({'pwlength': AppConstant.passWordMinLength.toString()}).tr;
    }
    if (value != passwordController.text.toString()) {
      return LocaleKeys.identique_password_error.tr;
    }
    return null;
  }
}

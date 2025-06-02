import 'package:faso_vote_client/generated/locales.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:quickalert/quickalert.dart';
import '../../themes/app_colors.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

class DialogHelper {
  static void showLoading({String? message, bool isWeb = true}) {
    Get.dialog(
      barrierDismissible: false,
      barrierColor: Colors.black54,
      Dialog(
        backgroundColor: Colors.transparent,
        elevation: 0,
        child: Center(
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  blurRadius: 10,
                  color: Colors.black.withOpacity(0.1),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (isWeb)
                  const SizedBox(
                    width: 50,
                    height: 50,
                    child: CircularProgressIndicator(
                      strokeWidth: 4,
                      valueColor: AlwaysStoppedAnimation(Colors.white),
                    ),
                  )
                else
                  const CircularProgressIndicator(),
                if (message != null) ...[
                  const SizedBox(height: 16),
                  Text(
                    message,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  //hide loading
  static void hideLoading() {
    if (Get.isDialogOpen!) Get.back();
  }

  // Show an error snackbar
  static void showErrorSnackbar(
      {String title = 'Error', required String message}) {
    Get.snackbar(
      title.tr,
      message.tr,
      backgroundColor: AppColors.error,
      colorText: Colors.white,
      snackPosition: SnackPosition.TOP,
      isDismissible: false,
      icon: IconButton(
        onPressed: () => Get.closeCurrentSnackbar(),
        icon: const Icon(Icons.cancel_rounded, color: Colors.white),
      ),
      duration: const Duration(seconds: 30),
    );
  }

  // Show a success snackbar
  static void showSuccessSnackbar(
      {String title = 'Success', required String message}) {
    Get.snackbar(
      title.tr,
      message.tr,
      backgroundColor: AppColors.success,
      colorText: Colors.white,
      snackPosition: SnackPosition.TOP,
      duration: const Duration(seconds: 20),
    );
  }

  // Show an info snackbar
  static void showInfoSnackbar(
      {String title = 'Info', required String message}) {
    Get.snackbar(
      title.tr,
      message.tr,
      backgroundColor: AppColors.info,
      colorText: Colors.white,
      snackPosition: SnackPosition.TOP,
      duration: const Duration(seconds: 20),
    );
  }

  // Show a confirmation dialog
  static Future<bool?> showConfirmationDialog({
    required String title,
    required String message,
    required Function() onConfirm,
  }) {
    return Get.defaultDialog(
      title: title.tr,
      middleText: message.tr,
      textConfirm: 'Yes'.tr,
      textCancel: 'No'.tr,
      confirmTextColor: Colors.white,
      onConfirm: () {
        Get.back(result: true);
        onConfirm();
      },
      onCancel: () => Get.back(result: false),
    );
  }

  static Future<dynamic> confirmationDialog(
      {required String title,
      required String message,
      required Function() onConfirm,
      required Function() onCancel}) {
    return Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        titlePadding: const EdgeInsets.symmetric(vertical: 5.0),
        actionsPadding: const EdgeInsets.symmetric(vertical: 0.0),
        title: Text(title, textAlign: TextAlign.center),
        content: Text(message),
        actions: [
          TextButton(
            child: Text(LocaleKeys.buttons_no.tr),
            onPressed: () => Get.back(),
          ),
          TextButton(
            onPressed: onConfirm,
            child: Text(
              LocaleKeys.buttons_yes.tr,
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: Get.theme.primaryColor),
            ),
          ),
        ],
      ),
    );
  }

  static void displaySuccessDialog(
      {required String message,
      void Function()? onConfirmBtnTap,
      String? tiltle,
      bool barrierDismissible = false}) {
    QuickAlert.show(
        context: Get.context!,
        barrierDismissible: barrierDismissible,
        type: QuickAlertType.success,
        titleColor: AppColors.info,
        confirmBtnColor: AppColors.primary,
        title: tiltle?.tr,
        text: message.tr,
        cancelBtnText: "OK",
        onConfirmBtnTap: onConfirmBtnTap);
  }
}

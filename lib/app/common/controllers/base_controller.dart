import 'package:get/get.dart';

import '../../core/api/exception.dart';
import '../../utils/helpers/dialog_helper.dart';

mixin BaseController {
  void handleError(error) {
    if (error is ApiException) {
      var message = error.message;
      displayErrorMessage(message: message!);
    } else {
      displayErrorMessage(message: 'Erreur inconnu!');
    }
  }

  displayErrorMessage({required String message}) {
    DialogHelper.showErrorSnackbar(message: message);
  }

  displaySuccesMessage(
      {required String message,
      void Function()? onConfirmBtnTap,
      bool? barrierDismissible}) {
    DialogHelper.showSuccessSnackbar(message: message.tr);
  }

  displayConfirmationDialog(
      {required String title,
      required String message,
      required Function() onConfirm,
      required Function() onCancel}) {
    DialogHelper.confirmationDialog(
        title: title,
        message: message,
        onConfirm: onConfirm,
        onCancel: onCancel);
  }
}

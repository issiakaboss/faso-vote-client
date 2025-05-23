
import '../../core/api/exception.dart';
import '../../utils/helpers/dialog_helper.dart';

mixin BaseProvider {
  void handleError(error) {
    hideLoading();
    if (error is ApiException) {
      var message = error.message;
      DialogHelper.showErrorSnackbar(message: message ?? '');
    } else {
      DialogHelper.showErrorSnackbar(message: 'Erreur inconnu!');
    }
  }

  void showLoading({String? message}) {
    DialogHelper.showLoading(message: message);
  }

  void hideLoading() {
    DialogHelper.hideLoading();
  }
}

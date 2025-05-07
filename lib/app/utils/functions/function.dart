import 'package:clipboard/clipboard.dart';
import 'package:faso_vote_client/generated/locales.g.dart';
import 'package:get/get.dart';
class Functions {
  static String currencyToEmoji(String countyCode) {
    countyCode = countyCode.toUpperCase();
    final int firstLetter = countyCode.codeUnitAt(0) - 0x41 + 0x1F1E6;
    final int secondLetter = countyCode.codeUnitAt(1) - 0x41 + 0x1F1E6;
    return String.fromCharCode(firstLetter) + String.fromCharCode(secondLetter);
  }
 static void copyText({required String text,String? message}) {
    FlutterClipboard.copy(text).then(
      (value) => Get.snackbar(
        LocaleKeys.copy.tr,
       message?? LocaleKeys.otp_copied.tr,
        colorText: Get.theme.cardColor,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Get.theme.primaryColor.withOpacity(0.5),
      ),
    );
  }

}

import 'package:faso_vote_client/app/core/network/google_process.dart';
import 'package:faso_vote_client/app/data/providers/auth_provider.dart';
import 'package:get/get.dart';

import '../../../../../generated/locales.g.dart';
import '../../../../routes/app_pages.dart';
import '../../../../utils/helpers/form_helper.dart';

class CanalvoteController extends GetxController {
  AuthProvider _authProvider = AuthProvider();
  RxString errormessage = "".obs;
  RxString? phoneNumber = "+226 675435655".obs;
  final otpController = FormHelper.getController();

  RxBool isLoding = RxBool(false);
  RxString loadingMessage = RxString("");

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

  void handelGoogleAuth({Map<String, dynamic>? voteCandidatData}) async {
    setLoading(loadMessage: LocaleKeys.login_loading.tr);

    // await GoogleProcess().signInWithGoogle();
    // var isVerified = await _authProvider.googleAuth().then((value) {
    //   print("arrive ici");
    //   stopLoading();
    // });
    // if (isVerified) {
    //   print("It's verify");
    //   if (voteCandidatData != null) {
    //     Get.toNamed(AppPages.FINAL_VOTE, arguments: voteCandidatData);
    //   }
    // }
  }
}

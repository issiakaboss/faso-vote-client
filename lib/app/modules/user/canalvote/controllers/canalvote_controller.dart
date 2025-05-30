import 'package:faso_vote_client/app/data/models/votant.dart';
import 'package:faso_vote_client/app/data/providers/auth_provider.dart';
import 'package:faso_vote_client/app/data/providers/vote_provider.dart';
import 'package:faso_vote_client/app/routes/app_pages.dart';
import 'package:get/get.dart';
import '../../../../../generated/locales.g.dart';
import '../../../../core/network/auth_service.dart';
import '../../../../utils/helpers/form_helper.dart';

class CanalvoteController extends GetxController {
  AuthProvider _authProvider = AuthProvider();
  VoteProvider _voteProvider = VoteProvider();
  RxnString errorMessage = RxnString();
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
    errorMessage.value = null;
    setLoading(loadMessage: LocaleKeys.login_loading.tr);
    final response = await AuthService.signInWithGoogle(
        voteUuid: voteCandidatData?['voteUuid']);
    stopLoading();
    if (response != null) {
      bool isSuccess = response['success'];
      if (isSuccess) {
        Votant votant = Votant.fromJson(response['data']);
        voteCandidatData?['votant'] = votant;
        Get.toNamed(AppPages.FINAL_VOTE, arguments: voteCandidatData);
      } else {
        errorMessage.value = response['message'];
      }
    }
  }

  Future<void> validateVote(
      {Map<String, dynamic>? validateData, required String candidatId}) async {
    var isValidated = _voteProvider.validateVote(
        validateData: validateData!, candidatId: candidatId);
    //     .whenComplete(() {
    //   Get.back();
    // });
  }
}

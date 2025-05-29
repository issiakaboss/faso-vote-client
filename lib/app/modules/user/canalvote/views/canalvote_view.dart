import 'package:faso_vote_client/app/modules/user/canalvote/views/finalyse_vote_view.dart';
import 'package:faso_vote_client/app/modules/user/canalvote/views/otp_view.dart';
import 'package:faso_vote_client/app/routes/app_pages.dart';
import 'package:faso_vote_client/generated/locales.g.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:faso_vote_client/app/widgets/phone_textfield.dart';
import 'package:faso_vote_client/app/themes/app_colors.dart';
import 'package:faso_vote_client/app/widgets/custom_button.dart';
import 'package:faso_vote_client/app/widgets/custom_text.dart';
import '../../../../widgets/loding_indicator.dart';
import '../controllers/canalvote_controller.dart';

class CanalvoteView extends GetView<CanalvoteController> {
  CanalvoteView({super.key});
  Map<String, dynamic>? voteCandidatData = Get.arguments;
  @override
  Widget build(BuildContext context) {
    print("Vote data 1 $voteCandidatData");
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isMobile = constraints.maxWidth < 600;
          final isTablet =
              constraints.maxWidth >= 600 && constraints.maxWidth < 1024;
          double contentWidth = isMobile
              ? Get.width * 0.85
              : isTablet
                  ? Get.width * 0.6
                  : Get.width * 0.3;

          return Center(
            child: Obx(
              () => SingleChildScrollView(
                child: Container(
                  width: contentWidth,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CustomText(
                        text: LocaleKeys.canal_vote_title.tr,
                        style: TextStyle(
                          fontSize: isMobile ? 22 : 25,
                          fontWeight: FontWeight.bold,
                          color: AppColors.title,
                        ),
                      ),
                      const SizedBox(height: 30),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: CustomText(
                          text: LocaleKeys.sous_title_canal_vote.tr,
                          style: TextStyle(
                            fontSize: isMobile ? 14 : 16,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      PhoneTextfield.mainPhoneField(
                        width: contentWidth,
                        hintText: LocaleKeys.phonenumber.tr,
                        height: 45,
                        borderColor: AppColors.textSecondary,
                        fillColor: AppColors.secondary,
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: contentWidth,
                        height: 45,
                        child: CustomButton.primaryButton(
                            onPressed: () {
                              if (voteCandidatData != null) {
                                Get.toNamed(AppPages.OTP,
                                    arguments: voteCandidatData);
                              }
                            },
                            buttonTitle: LocaleKeys.continue_title.tr),
                      ),
                      const SizedBox(height: 15),
                      CustomText(
                        text: LocaleKeys.ou.tr,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: AppColors.title,
                        ),
                      ),
                      const SizedBox(height: 15),
                      SizedBox(
                        width: contentWidth,
                        height: 45,
                        child:
                         CustomButton.primaryButton(
                          onPressed: () {
                            if (controller.isLoding.value) return;
                            if (voteCandidatData != null) {
                              controller.handelGoogleAuth(
                                  voteCandidatData: voteCandidatData);
                            }
                          },
                          buttonTitle: controller.isLoding.value
                              ? controller.loadingMessage.value
                              : LocaleKeys.continue_google.tr,
                          mainAxisSize: MainAxisSize.max,
                          isDisabled: controller.isLoding.value,
                          prefix: controller.isLoding.value
                              ? const LoadingIndicator()
                              : Image.asset(
                                  "images/google.png",
                                  width: 20,
                                ),
                          backgroundColor: Colors.white,
                          textStyle: const TextStyle(
                            color: AppColors.title,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      const SizedBox(height: 35),
                      CustomButton.secondaryButton(
                        mainAxisSize: MainAxisSize.min,
                        onPressed: () {
                          // if (voteCandidatData != null) {
                          // }
                          Get.offNamed(
                              '${Routes.vote}/${voteCandidatData!['voteUuid']}');
                        },
                        buttonTitle: LocaleKeys.buttons_quit.tr,
                        prefix: const Icon(Icons.close),
                        textStyle: const TextStyle(
                          color: AppColors.title,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

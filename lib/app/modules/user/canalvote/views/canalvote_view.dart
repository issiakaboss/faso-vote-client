import 'package:faso_vote_client/app/routes/app_pages.dart';
import 'package:faso_vote_client/app/utils/helpers/responsive_helper.dart';
import 'package:faso_vote_client/generated/locales.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:faso_vote_client/app/widgets/phone_textfield.dart';
import 'package:faso_vote_client/app/themes/app_colors.dart';
import 'package:faso_vote_client/app/widgets/custom_button.dart';
import 'package:faso_vote_client/app/widgets/custom_text.dart';
import '../controllers/canalvote_controller.dart';

class CanalvoteView extends GetView<CanalvoteController> {
  CanalvoteView({super.key});
  Map<String, dynamic>? voteCandidatData = Get.arguments;

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveHelper(context);

    return Scaffold(
      body: Obx(() => Stack(children: [
            Center(
              child: Obx(() => SingleChildScrollView(
                    child: Container(
                      width: responsive.contentWidth,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          if (controller.errorMessage.value != null)
                            Container(
                              margin: EdgeInsets.symmetric(
                                  vertical: responsive.verticalPadding),
                              width: context.width,
                              alignment: Alignment.center,
                              padding: const EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                color: AppColors.error.withOpacity(0.2),
                              ),
                              child: CustomText(
                                text: controller.errorMessage.value!,
                                overflow: TextOverflow.visible,
                                color: AppColors.error,
                              ),
                            ),
                          CustomText(
                            text: LocaleKeys.canal_vote_title.tr,
                            style: TextStyle(
                              fontSize: responsive.isMobile ? 22 : 25,
                              fontWeight: FontWeight.bold,
                              color: AppColors.title,
                            ),
                          ),
                          SizedBox(height: responsive.blockSpacing + 10),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: CustomText(
                              text: LocaleKeys.sous_title_canal_vote.tr,
                              style: TextStyle(
                                fontSize: responsive.baseFontSize,
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Form(
                            key: controller.phoneFormKey,
                            child: PhoneTextfield.mainPhoneField(
                              width: responsive.contentWidth,
                              hintText: LocaleKeys.phonenumber.tr,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              borderColor: AppColors.textSecondary,
                              fillColor: AppColors.secondary,
                              onChanged: (p0) {
                                controller.errorMessage.value = null;
                                controller.currentPhoneNumber.value = p0;
                              },
                              validator: (phone) {
                                if (phone == null || phone.number.isEmpty) {
                                  return "Numéro de téléphone invalide.";
                                }
                                return null;
                              },
                            ),
                          ),
                          SizedBox(height: responsive.blockSpacing),
                          SizedBox(
                            width: responsive.contentWidth,
                            height: responsive.fieldHeight,
                            child: CustomButton.primaryButton(
                              onPressed: () {
                                controller.sendOtpRequest(voteCandidatData);
                              },
                              buttonTitle: LocaleKeys.continue_title.tr,
                            ),
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
                            width: responsive.contentWidth,
                            height: responsive.fieldHeight,
                            child: CustomButton.primaryButton(
                              onPressed: () {
                                if (voteCandidatData != null) {
                                  controller.handelGoogleAuth(
                                      voteCandidatData: voteCandidatData);
                                } else {
                                  controller.errorMessage.value =
                                      "Probleme de donnée! fermer l'application et reesayer.";
                                }
                              },
                              buttonTitle: controller.isLoding.value
                                  ? controller.loadingMessage.value
                                  : LocaleKeys.continue_google.tr,
                              mainAxisSize: MainAxisSize.max,
                              isDisabled: controller.isLoding.value,
                              prefix:
                                  Image.asset("images/google.png", width: 20),
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
                              if (voteCandidatData != null &&
                                  voteCandidatData?['voteUuid'] != null) {
                                Get.offNamed(
                                    '${Routes.vote}/${voteCandidatData?['voteUuid']}');
                              }
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
                  )),
            ),
            if (controller.isLoding.value)
              Positioned.fill(
                child: Container(
                  color: Colors.black.withOpacity(0.4),
                  child: const Center(
                    child: CircularProgressIndicator(
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ),
          ])),
    );
  }
}

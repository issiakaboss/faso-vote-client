import 'package:faso_vote_client/app/modules/user/canalvote/controllers/canalvote_controller.dart';
import 'package:faso_vote_client/app/themes/app_colors.dart';
import 'package:faso_vote_client/app/widgets/custom_button.dart';
import 'package:faso_vote_client/app/widgets/custom_text.dart';
import 'package:faso_vote_client/app/widgets/otp_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../../data/models/candidat.dart';
import '../../../../data/models/votant.dart';
import '../../../../utils/helpers/responsive_helper.dart';
import '../../../../utils/validators/form_validator.dart';

class OtpView extends GetView<CanalvoteController> {
  Map<String, dynamic>? voteCandidatData = Get.arguments;

  OtpView({super.key});

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveHelper(context);

    Candidat? candidat = voteCandidatData?['candidat'];
    Votant? votant = voteCandidatData?['votant'];

    return Scaffold(
      body: Obx(() => Stack(children: [
            Center(
              child: SingleChildScrollView(
                child: SizedBox(
                  width: responsive.contentWidth,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (controller.errorMessage.value != null)
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: responsive.verticalPadding),
                          child: Container(
                            width: context.width / 3,
                            height: 50,
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
                        ),
                      CustomText(
                        text: 'OTP vérification',
                        style: TextStyle(
                          fontSize: responsive.titleFontSize,
                          fontWeight: FontWeight.bold,
                          color: AppColors.title,
                        ),
                      ),
                      const SizedBox(height: 10),
                      RichText(
                        text: TextSpan(
                          style: TextStyle(
                            fontSize: responsive.baseFontSize,
                            color: AppColors.textSecondary,
                          ),
                          children: [
                            const TextSpan(
                              text:
                                  "Afin de vérifier l'authenticité de ce numéro, nous enverrons un code à 6 chiffres au ",
                            ),
                            TextSpan(
                              text: votant?.identity,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: AppColors.title,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: responsive.blockSpacing),
                      Form(
                        key: controller.otpFormkey,
                        child: OTPFieldWidget(
                          otpController: controller.otpController,
                          onCompleted: (value) {},
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          length: 6,
                          validator: (p0) {
                            return FormValidator.validateOTP(p0);
                          },
                        ),
                      ),
                      const SizedBox(height: 10),
                      CustomText(
                        text: "Vous n'avez pas réçu l'OTP ?",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: responsive.smallFontSize,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      SizedBox(height: responsive.blockSpacing),
                      SizedBox(
                        width: double.infinity,
                        height: responsive.fieldHeight,
                        child: CustomButton.primaryButton(
                          onPressed: () {
                            controller.verifyOtp(
                              votant: votant,
                              voteCandidatData: voteCandidatData,
                            );
                          },
                          buttonTitle: "Verifier",
                        ),
                      ),
                    ],
                  ),
                ),
              ),
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

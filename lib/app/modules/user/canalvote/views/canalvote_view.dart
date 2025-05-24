import 'package:faso_vote_client/generated/locales.g.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:faso_vote_client/app/modules/user/canalvote/views/phone_textfield.dart';
import 'package:faso_vote_client/app/routes/app_pages.dart';
import 'package:faso_vote_client/app/themes/app_colors.dart';
import 'package:faso_vote_client/app/widgets/custom_button.dart';
import 'package:faso_vote_client/app/widgets/custom_text.dart';
import '../controllers/canalvote_controller.dart';

class CanalvoteView extends GetView<CanalvoteController> {
  const CanalvoteView({super.key});

  @override
  Widget build(BuildContext context) {
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
            child: SingleChildScrollView(
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
                            Get.toNamed(Routes.OTPPAGE);
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
                      child: CustomButton.primaryButton(
                        onPressed: () {
                          // Implémente l'auth Google ici
                        },
                        buttonTitle: LocaleKeys.continue_google.tr,
                        prefix: Image.asset(
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
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

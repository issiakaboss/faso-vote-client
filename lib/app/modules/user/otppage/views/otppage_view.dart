import 'package:faso_vote_client/app/themes/app_colors.dart';
import 'package:faso_vote_client/app/widgets/custom_button.dart';
import 'package:faso_vote_client/app/widgets/custom_text.dart';
import 'package:faso_vote_client/app/widgets/otp_field_widget.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/otppage_controller.dart';

class OtppageView extends GetView<OtppageController> {
  const OtppageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          // Déterminer la largeur en fonction de l'écran
          double screenWidth = constraints.maxWidth;
          double contentWidth;

          if (screenWidth >= 1200) {
            // Desktop
            contentWidth = screenWidth * 0.35;
          } else if (screenWidth >= 800) {
            // Tablette
            contentWidth = screenWidth * 0.5;
          } else {
            // Mobile
            contentWidth = screenWidth * 0.9;
          }

          return Center(
            child: SingleChildScrollView(
              child: SizedBox(
                width: contentWidth,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CustomText(
                      text: 'OTP vérification',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: AppColors.title,
                      ),
                    ),
                    const SizedBox(height: 10),
                    RichText(
                      text: TextSpan(
                        style: const TextStyle(
                          fontSize: 14,
                          color: AppColors.textSecondary,
                        ),
                        children: [
                          const TextSpan(
                            text:
                                "Afin de vérifier l'authenticité de ce numéro, nous enverrons un code à 6 chiffres au ",
                          ),
                          TextSpan(
                            text: controller.phoneNumber?.value ?? '',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: AppColors.title),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30),
                    OTPFieldWidget(
                      otpController: TextEditingController(),
                      length: 6,
                      onCompleted: (p0) {},
                    ),
                    const SizedBox(height: 10),
                    const Row(
                      children: [
                        CustomText(
                          text: "Vous n'avez pas réçu l'OTP ?",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                            color: AppColors.textSecondary,
                          ),
                        ),
                        SizedBox(width: 5),
                        CustomText(
                          text: 'Renvoyer OTP',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    SizedBox(
                      width: double.infinity,
                      height: 45,
                      child: CustomButton.primaryButton(
                        onPressed: () {},
                        buttonTitle: "Confirmer mon vote",
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

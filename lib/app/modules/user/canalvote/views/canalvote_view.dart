import 'package:faso_vote_client/app/modules/user/canalvote/views/phone_textfield.dart';
import 'package:faso_vote_client/app/themes/app_colors.dart';
import 'package:faso_vote_client/app/widgets/custom_button.dart';
import 'package:faso_vote_client/app/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/canalvote_controller.dart';

class CanalvoteView extends GetView<CanalvoteController> {
  const CanalvoteView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.only(right: 18.0),
              child: CustomText(
                text: 'Choisissez votre canal de vote',
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: AppColors.title),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: .0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CustomText(
                    text: 'Avec un numéro de téléphone',
                    style:
                        TextStyle(fontSize: 15, color: AppColors.textSecondary),
                  ),
                  const SizedBox(height: 10),
                  PhoneTextfield.mainPhoneField(
                    width: Get.width / 3.5,
                    height: 40,
                    borderColor: AppColors.textSecondary,
                    fillColor: AppColors.secondary,
                  )
                ],
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: Get.width / 3.5,
              height: 40,
              child: CustomButton.primaryButton(
                onPressed: () {},
                buttonTitle: "Continuer",
              ),
            ),
            const SizedBox(height: 10),
            const CustomText(
              text: 'OU',
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: AppColors.title),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: Get.width / 3.5,
              height: 40,
              child: CustomButton.primaryButton(
                  onPressed: () {},
                  buttonTitle: "Continuer avec Google",
                  prefix: Image.asset(
                    "images/google.png",
                    width: 20,
                  ),
                  backgroundColor: Colors.white,
                  textStyle: const TextStyle(
                    color: AppColors.title,
                    fontWeight: FontWeight.w500,
                  )),
            ),
          ],
        ),
      ),
    );
  }
}

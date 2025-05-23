import 'package:faso_vote_client/app/themes/app_colors.dart';
import 'package:faso_vote_client/app/widgets/custom_button.dart';
import 'package:faso_vote_client/app/widgets/custom_card.dart';
import 'package:faso_vote_client/app/widgets/custom_text.dart';
import 'package:faso_vote_client/app/widgets/custom_text_form_field.dart';
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
            const CustomText(
              text: 'Choisissez votre canal de vote',
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: AppColors.title),
            ),
            const SizedBox(height: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CustomText(
                  text: 'Avec un numéro de téléphone',
                  style:
                      TextStyle(fontSize: 15, color: AppColors.textSecondary),
                ),
                const SizedBox(height: 10),
                MainCard(
                  cardWidth: Get.width / 3.5,
                  child: CustomTextFormField(
                    errorMessage: RxnString(),
                    showCountries: true,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            MainButton(
              width: Get.width / 3.5,
              onPressed: () {},
              text: "Continuer",
              height: 40,
              textcolor: Colors.white,
              color: AppColors.primary,
            ),
            const SizedBox(height: 10),
            const CustomText(
              text: 'OU',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.title,
              ),
            ),
            MainButton(
              width: Get.width / 3.5,
              onPressed: () {},
              text: "Continuer avec Google",
              height: 40,
              textcolor: AppColors.title,
              color: AppColors.secondary,
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:faso_vote_client/app/routes/app_pages.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../themes/app_colors.dart';
import '../../../../widgets/custom_button.dart';
import '../../../../widgets/custom_card.dart';
import '../../../../widgets/custom_popup.dart';
import '../../../../widgets/custom_text.dart';

class FinalyseVoteView extends GetView {
  Map<String, dynamic>? voteCandidatData = Get.arguments;
  FinalyseVoteView({super.key});
  @override
  Widget build(BuildContext context) {
    print("Vote data 3 final vote $voteCandidatData");
    return Scaffold(
        body: SingleChildScrollView(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 60),
            const CustomText(
              text: "Confirmer le vote",
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: AppColors.title),
            ),
            const SizedBox(height: 12),
            const CustomText(
              text:
                  "Êtes-vous sûr(e) de votre choix ? Si oui cliquez sur \nle bouton"
                  "'Confirmer mon vote' sinon 'Changer \nde candidat'.",
              style: TextStyle(fontSize: 12, color: AppColors.title),
            ),
            const SizedBox(height: 22),
            MainCard(
              cardWidth: Get.width / 4.5,
              cardHeight: Get.height / 1.6,
              borderWidth: 0.4,
              borderColor: AppColors.textSecondary.withOpacity(0.4),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      'https://randomuser.me/api/portraits/men/75.jpg',
                      height: 120,
                      width: 120,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 12),
                  const CustomText(
                    text: 'Dr Madou KAKOU',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: AppColors.title,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const CustomText(
                    text: 'Université Felix Houphouêt Boigy',
                    style: TextStyle(color: AppColors.primary),
                  ),
                  const SizedBox(height: 8),
                  const CustomText(
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.visible,
                    text:
                        'Modélisation numérique des propriétés thermiques des matériaux composites',
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 16),
                  CustomButton.primaryButton(
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 50),
                    buttonTitle: "Confirmé mon vote",
                    borderRadius: 5,
                    onPressed: () {
                      showDialog(
                        context: Get.context!,
                        builder: (context) {
                          return ConfirmationPopup(
                            onCancel: () {
                              Get.back();
                            },
                            onConfirm: () {},
                          );
                        },
                      );
                    },
                  ),
                  const SizedBox(height: 8),
                  CustomButton.primaryButton(
                    padding: const EdgeInsets.symmetric(
                      vertical: 15,
                      horizontal: 55,
                    ),
                    backgroundColor: const Color.fromARGB(255, 217, 242, 247),
                    buttonTitle: "Changer de candidat",
                    textStyle: const TextStyle(
                        color: AppColors.title, fontWeight: FontWeight.bold),
                    borderRadius: 5,
                    onPressed: () {
                      Get.offAllNamed(
                          '${Routes.vote}/${voteCandidatData?['voteUuid']}');
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }
}

import 'package:faso_vote_client/app/data/models/candidat.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../generated/locales.g.dart';
import '../../../routes/app_pages.dart';
import '../../../themes/app_colors.dart';
import '../../../themes/app_text_styles.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_card.dart';
import '../../../widgets/custom_text.dart';

class CandidateCard extends StatelessWidget {
  final Candidat candidate;
  final double cardWidth;
  final bool isResultTab;
  final String voteUuid;
  final bool isTopCandidate;

  const CandidateCard({
    Key? key,
    required this.candidate,
    required this.cardWidth,
    required this.isResultTab,
    required this.voteUuid,
    this.isTopCandidate = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainCard(
      padding: const EdgeInsets.all(12),
      cardWidth: cardWidth,
      cardHeight: null,
      cardColor: Colors.white,
      borderWidth: 0.5,
      borderColor: Colors.grey.shade200,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Photo du candidat
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(60),
              border: Border.all(
                color: Colors.grey.shade300,
                width: 1.0,
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(60),
              child: candidate.photoUrl != null
                  ? Image.network(
                      candidate.photoUrl!,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => const Icon(
                          Icons.person,
                          size: 90,
                          color: Colors.grey),
                    )
                  : const Icon(Icons.person, size: 80),
            ),
          ),
          const SizedBox(height: 12),

          // Nom du candidat
          CustomText(
            text: candidate.fullName,
            overflow: TextOverflow.visible,
            style: AppTextStyles.heading3(),
          ),
          const SizedBox(height: 10),

          // Etablissement
          CustomText(
            text: candidate.etablissement,
            textAlign: TextAlign.center,
            overflow: TextOverflow.visible,
            style: AppTextStyles.heading4().copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 8),

          // Thème (wrap et multiple lignes si nécessaire)
          if (!isResultTab)
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: "Thème",
                    overflow: TextOverflow.visible,
                    style: AppTextStyles.bodyText2().copyWith(
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade200),
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.grey.shade50,
                    ),
                    child: CustomText(
                      text: candidate.theme ?? "Thème inconnu",
                      overflow: TextOverflow.visible,
                      textAlign: TextAlign.justify,
                      style: AppTextStyles.bodyText2().copyWith(
                        fontStyle: FontStyle.italic,
                        fontSize: 15,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                ],
              ),
            ),

          const SizedBox(height: 12),

          // Résultat ou bouton voter
          isResultTab
              ? MainCard(
                  cardWidth: double.infinity,
                  cardColor: isTopCandidate
                      ? Colors.green.withOpacity(0.1)
                      : Colors.grey.withOpacity(0.1),
                  cardHeight: 35,
                  borderColor: Colors.transparent,
                  child: Center(
                    child: Text(
                      "${candidate.voix} voix",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: isTopCandidate ? Colors.green : Colors.black,
                      ),
                    ),
                  ),
                )
              : CustomButton.primaryButton(
                  buttonTitle: LocaleKeys.voter.tr,
                  mainAxisSize: MainAxisSize.max,
                  elevation: 0.0,
                  padding: const EdgeInsets.symmetric(horizontal: 40.0),
                  onPressed: () {
                    Get.toNamed(
                      AppPages.CANAL_VOTE,
                      arguments: {
                        'candidat': candidate,
                        'voteUuid': voteUuid,
                      },
                    );
                  },
                ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../data/models/candidat.dart';
import '../../../../themes/app_colors.dart';
import '../../../../themes/app_text_styles.dart';
import '../../../../utils/helpers/responsive_helper.dart';
import '../../../../widgets/custom_card.dart';
import '../../../../widgets/custom_text.dart';
import '../../../../widgets/loding_indicator.dart';
import '../controllers/results_controller.dart';

class ResultsView extends GetView<ResultsController> {
  ResultsView({super.key, this.candidats});
  final List<Candidat>? candidats;

  @override
  Widget build(BuildContext context) {
    return candidats != null
        ? Container(
            padding: const EdgeInsets.all(8.0).copyWith(top: 20),
            width: context.width,
            child: SingleChildScrollView(
              controller: ScrollController(),
              physics: const AlwaysScrollableScrollPhysics(),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final responsive = ResponsiveHelper(context);
                  int columnCount = responsive.isDesktop
                      ? 3
                      : responsive.isTablet
                          ? 2
                          : 1;
                  double spacing = 30;
                  double cardWidth =
                      (constraints.maxWidth - ((columnCount - 1) * spacing)) /
                          columnCount;
                  final sortedCandidats = List<Candidat>.from(candidats!)
                    ..sort((a, b) => b.voix.compareTo(a.voix));
                  final maxVoix = sortedCandidats.first.voix;
                  return candidats!.isNotEmpty
                      ? Wrap(
                          spacing: spacing,
                          runSpacing: spacing,
                          children:
                              sortedCandidats.asMap().entries.map((entry) {
                            final index = entry.key;
                            final candidat = entry.value;
                            return CandidateCard(
                              candidate: candidat,
                              cardWidth: cardWidth,
                              isTopCandidate:
                                  candidat.voix == maxVoix && maxVoix > 0,
                            );
                          }).toList(),
                        )
                      : const Center(child: CustomText(text: "No result"));
                },
              ),
            ),
          )
        : const Center(child: LoadingIndicator());
  }
}

class CandidateCard extends StatelessWidget {
  final Candidat candidate;
  final double cardWidth;
  final bool isTopCandidate;

  const CandidateCard({
    super.key,
    required this.candidate,
    required this.cardWidth,
    this.isTopCandidate = false,
  });

  @override
  Widget build(BuildContext context) {
    return MainCard(
      padding: const EdgeInsets.all(12),
      cardWidth: cardWidth,
      cardColor: Colors.white,
      borderWidth: 0.5,
      borderColor: Colors.grey.shade200,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Colors.grey.shade300,
                        width: 1.0,
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: candidate.photoUrl != null
                          ? Image.network(
                              candidate.photoUrl!,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  const Icon(Icons.person,
                                      size: 90, color: Colors.grey),
                            )
                          : const Icon(Icons.person, size: 80),
                    ),
                  ),
                  if (isTopCandidate)
                    Positioned(
                      top: 4,
                      right: 4,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.orange,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Text(
                          '🥇 1er',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: candidate.fullName,
                      overflow: TextOverflow.visible,
                      style: AppTextStyles.heading3(),
                    ),
                    const SizedBox(height: 10),
                    CustomText(
                      text: candidate.etablissement,
                      overflow: TextOverflow.visible,
                      style: AppTextStyles.heading4().copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          MainCard(
            cardWidth: Get.width,
            cardColor: isTopCandidate
                ? Colors.green.withOpacity(0.1)
                : Colors.grey.withOpacity(0.1),
            cardHeight: 35,
            borderColor: Colors.transparent,
            child: Center(
              child: Text(
                "${candidate.voix} voix",
                style: TextStyle(
                  color: isTopCandidate ? Colors.green : Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

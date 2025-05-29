import 'package:faso_vote_client/app/data/models/candidat.dart';
import 'package:faso_vote_client/app/widgets/loding_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../themes/app_colors.dart';
import '../../../../widgets/custom_card.dart';
import '../../../../widgets/custom_text.dart';
import '../controllers/results_controller.dart';

class ResultsView extends GetView<ResultsController> {
  ResultsView({super.key, this.candidats});
  List<Candidat>? candidats;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: candidats != null
            ? LayoutBuilder(
                builder: (context, constraints) {
                  double maxWidth = constraints.maxWidth;
                  int columnCount = 1;
                  if (maxWidth >= 1000) {
                    columnCount = 3;
                  } else if (maxWidth >= 600) {
                    columnCount = 2;
                  }

                  double spacing = 16;
                  double cardWidth =
                      (maxWidth - ((columnCount - 1) * spacing)) / columnCount;
                  return candidats!.isNotEmpty
                      ? Wrap(
                          spacing: spacing,
                          runSpacing: spacing,
                          children: candidats!.map((candidate) {
                            return MainCard(
                              padding: const EdgeInsets.all(12),
                              cardWidth: cardWidth,
                              cardHeight: 280,
                              cardColor: Colors.white,
                              borderWidth: 0.5,
                              borderColor: Colors.grey.shade200,
                              child: Column(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(40),
                                    child: Image.network(
                                      candidate.photoUrl.toString(),
                                      height: 80,
                                      width: 80,
                                      fit: BoxFit.cover,
                                      errorBuilder:
                                          (context, error, stackTrace) =>
                                              const Icon(Icons.person,
                                                  size: 80, color: Colors.grey),
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  CustomText(
                                    text: candidate.fullName,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  CustomText(
                                    text: candidate.etablissement,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: AppColors.primary,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  CustomText(
                                    overflow: TextOverflow.visible,
                                    text: candidate.theme ?? "",
                                    color: Colors.grey,
                                    style: const TextStyle(
                                      fontSize: 12,
                                    ),
                                  ),
                                  const Spacer(),
                                  MainCard(
                                    cardWidth: Get.width,
                                    cardColor: Colors.green.withOpacity(0.1),
                                    cardHeight: 35,
                                    borderColor: Colors.transparent,
                                    child: Center(
                                      child: Text(
                                        "${candidate.voix.toString()} voix",
                                        style: const TextStyle(
                                            color: Colors.green,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            );
                          }).toList(),
                        )
                      : const Center(
                          child: CustomText(text: "No result"),
                        );
                },
              )
            : const Center(
                child: LoadingIndicator(),
              ));
  }
}

// home_view.dart
import 'package:faso_vote_client/app/data/models/vote_candidats.dart';
import 'package:faso_vote_client/generated/locales.g.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../themes/app_colors.dart';
import '../controllers/home_controller.dart';
import 'package:faso_vote_client/app/widgets/custom_button.dart';
import 'package:faso_vote_client/app/widgets/custom_card.dart';
import 'package:faso_vote_client/app/widgets/custom_popup.dart';
import 'package:faso_vote_client/app/widgets/custom_text.dart';
import 'package:faso_vote_client/app/routes/app_pages.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    const maxContentWidth = 1100.0;
    return Scaffold(
        backgroundColor: AppColors.background,
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: maxContentWidth),
              child: Obx(
                () => Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(80),
                      child: Image.network(
                        width: 100,
                        height: 100,
                        controller.voteCandidats.value?.vote.logo ?? "",
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Center(
                            child: Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(80),
                              ),
                              child: const Icon(Icons.broken_image, size: 25),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 16),
                    CustomText(
                      text: controller.voteCandidats.value?.vote.title ?? "",
                      overflow: TextOverflow.visible,
                      style: const TextStyle(
                        fontSize: 22,
                        color: AppColors.title,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    CustomText(
                      text: controller.voteCandidats.value?.vote.description ??
                          "",
                      overflow: TextOverflow.visible,
                      style:
                          const TextStyle(fontSize: 14, color: Colors.black54),
                      textAlign: TextAlign.justify,
                    ),
                    const SizedBox(height: 20),
                    _buildTabBar(),
                    const SizedBox(height: 24),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: _buildCandidatesSection(
                        title: controller.selectedTab.value == 0
                            ? LocaleKeys.list_des_candidats.tr
                            : LocaleKeys.resultat_des_votes.tr,
                        selectedTabIndex: controller.selectedTab.value,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  Widget _buildTabBar() {
    return LayoutBuilder(
      builder: (context, constraints) {
        double width = constraints.maxWidth;
        return Center(
          child: MainCard(
            padding: const EdgeInsets.all(4),
            cardColor: Colors.white,
            cardWidth: width < 500 ? width * 0.8 : 300,
            radius: 30,
            borderColor: Colors.grey.shade200,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _tabButton(LocaleKeys.candidats.tr, 0),
                _tabButton(LocaleKeys.resultat.tr, 1),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _tabButton(String text, int index) {
    final isSelected = controller.selectedTab.value == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => controller.selectedTab.value = index,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            color: isSelected
                ? AppColors.primary.withOpacity(0.1)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                color: isSelected ? AppColors.primary : Colors.grey,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCandidatesSection(
      {required String title, required int selectedTabIndex}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.title)),
        const SizedBox(height: 9),
        if (controller.selectedTab.value == 1)
          LayoutBuilder(builder: (context, constraints) {
            int columnCount = 1;
            if (constraints.maxWidth >= 900) {
              columnCount = 3;
            } else if (constraints.maxWidth >= 600) {
              columnCount = 2;
            }

            const spacing = 10.0;
            final cardWidth =
                (constraints.maxWidth - (columnCount - 1) * spacing) /
                    columnCount;

            return Wrap(
              spacing: spacing,
              runSpacing: spacing,
              children: [
                resultCard("8000", LocaleKeys.votes_total.tr, Colors.black,
                    width: cardWidth),
                resultCard("4000", LocaleKeys.ayant_vote.tr, Colors.green,
                    width: cardWidth),
                resultCard("4000", LocaleKeys.non_vote.tr, Colors.red,
                    width: cardWidth),
              ],
            );
          }),
        const SizedBox(height: 16),
        LayoutBuilder(
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
            return Obx(() {
              final voteCandidats = controller.voteCandidats.value;
              return voteCandidats != null
                  ? Wrap(
                      spacing: spacing,
                      runSpacing: spacing,
                      children: voteCandidats.candidats.map((candidate) {
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
                                  errorBuilder: (context, error, stackTrace) =>
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
                              selectedTabIndex == 1
                                  ? MainCard(
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
                                  : CustomButton.primaryButton(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 15, horizontal: 0),
                                      mainAxisSize: MainAxisSize.max,
                                      onPressed: () {
                                        Get.toNamed(Routes.CANAL_VOTE,
                                            arguments: {
                                              'voteId': voteCandidats.vote.id,
                                              'candidateId': candidate.id
                                            });
                                      },
                                      buttonTitle: LocaleKeys.voter.tr,
                                    ),
                            ],
                          ),
                        );
                      }).toList(),
                    )
                  : const SizedBox.shrink();
            });
          },
        )
      ],
    );
  }

  Widget resultCard(String title, String value, Color color,
      {required double width}) {
    return MainCard(
      padding: const EdgeInsets.all(12),
      cardWidth: width,
      cardHeight: 80,
      cardColor: AppColors.secondary,
      borderColor: Colors.transparent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: const TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                  fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text(value, style: TextStyle(fontSize: 14, color: color)),
        ],
      ),
    );
  }
}

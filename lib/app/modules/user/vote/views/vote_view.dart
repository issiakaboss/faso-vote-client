// home_view.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:faso_vote_client/app/data/models/statistic.dart';
import 'package:faso_vote_client/generated/locales.g.dart';
import '../../../../data/models/candidat.dart';
import '../../../../data/models/vote_candidats.dart';
import '../../../../themes/app_colors.dart';
import '../../../../utils/helpers/responsive_helper.dart';
import '../controllers/vote_controller.dart';
import 'package:faso_vote_client/app/widgets/custom_card.dart';
import 'package:faso_vote_client/app/widgets/custom_text.dart';

import '../../widgets/candidat_card.dart';

class VoteView extends GetView<VoteController> {
  const VoteView({super.key});

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveHelper(context);
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
                  _buildLogo(),
                  const SizedBox(height: 16),
                  _buildTitle(),
                  const SizedBox(height: 8),
                  _buildDescription(),
                  const SizedBox(height: 20),
                  _buildTabBar(responsive),
                  const SizedBox(height: 24),
                  _buildCandidatesSection(responsive),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLogo() {
    final logoUrl = controller.voteCandidats.value?.vote.logo ?? '';
    return ClipRRect(
      borderRadius: BorderRadius.circular(80),
      child: Image.network(
        logoUrl,
        width: 100,
        height: 100,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(80),
              color: Colors.grey.shade200,
            ),
            child: const Icon(Icons.broken_image, size: 40),
          );
        },
      ),
    );
  }

  Widget _buildTitle() {
    final title = controller.voteCandidats.value?.vote.title ?? '';
    return CustomText(
      text: title,
      overflow: TextOverflow.visible,
      style: const TextStyle(
        fontSize: 22,
        color: AppColors.title,
        fontWeight: FontWeight.bold,
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildDescription() {
    final description = controller.voteCandidats.value?.vote.description ?? '';
    return CustomText(
      text: description,
      overflow: TextOverflow.visible,
      style: const TextStyle(fontSize: 14, color: Colors.black54),
      textAlign: TextAlign.justify,
    );
  }

  Widget _buildTabBar(ResponsiveHelper responsive) {
    return Center(
      child: MainCard(
        padding: const EdgeInsets.all(4),
        cardColor: Colors.white,
        cardWidth: responsive.isMobile ? double.infinity : 300,
        radius: 30,
        borderColor: Colors.grey.shade200,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            _tabButton(LocaleKeys.candidats.tr, 0),
            _tabButton(LocaleKeys.resultat.tr, 1),
          ],
        ),
      ),
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

  Widget _buildCandidatesSection(ResponsiveHelper responsive) {
    final selectedTabIndex = controller.selectedTab.value;
    final voteCandidats = controller.voteCandidats.value;
    final statistic = voteCandidats?.statistic;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          selectedTabIndex == 0
              ? LocaleKeys.list_des_candidats.tr
              : LocaleKeys.resultat_des_votes.tr,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.title,
          ),
        ),
        const SizedBox(height: 9),
        if (selectedTabIndex == 1 && statistic != null)
          _buildStatistics(responsive, statistic),
        const SizedBox(height: 16),
        _buildCandidateCards(responsive, voteCandidats, selectedTabIndex),
      ],
    );
  }

  Widget _buildStatistics(
      ResponsiveHelper responsive, StatisticModel statistic) {
    return LayoutBuilder(
      builder: (context, constraints) {
        int columnCount = responsive.isDesktop
            ? 3
            : responsive.isTablet
                ? 2
                : 1;
        const spacing = 10.0;
        final cardWidth =
            (constraints.maxWidth - (columnCount - 1) * spacing) / columnCount;

        return Wrap(
          spacing: spacing,
          runSpacing: spacing,
          children: [
            _statisticCard(
              title: LocaleKeys.votes_total.tr,
              value: statistic.total.toString(),
              color: Colors.black,
              width: cardWidth,
            ),
            _statisticCard(
              title: LocaleKeys.ayant_vote.tr,
              value: statistic.voted.toString(),
              color: Colors.green,
              width: cardWidth,
            ),
            _statisticCard(
              title: LocaleKeys.non_vote.tr,
              value: statistic.invalid.toString(),
              color: Colors.red,
              width: cardWidth,
            ),
          ],
        );
      },
    );
  }

  Widget _buildCandidateCards(ResponsiveHelper responsive,
      VoteCandidats? voteCandidats, int selectedTabIndex) {
    if (voteCandidats == null) return const SizedBox.shrink();

    return LayoutBuilder(
      builder: (context, constraints) {
        int columnCount = responsive.isDesktop
            ? 3
            : responsive.isTablet
                ? 2
                : 1;
        const spacing = 16.0;
        final cardWidth =
            (constraints.maxWidth - (columnCount - 1) * spacing) / columnCount;
        final sortedCandidats = List<Candidat>.from(voteCandidats.candidats)
          ..sort((a, b) => b.voix.compareTo(a.voix));
        final maxVoix = sortedCandidats.first.voix;
        return Wrap(
          spacing: spacing,
          runSpacing: spacing,
          children: sortedCandidats.asMap().entries.map((entry) {
            final index = entry.key;
            final candidat = entry.value;
            return CandidateCard(
              candidate: candidat,
              cardWidth: cardWidth,
              isResultTab: selectedTabIndex == 1,
              voteUuid: voteCandidats.vote.uuid,
              isTopCandidate: candidat.voix == maxVoix && maxVoix > 0,
            );
          }).toList(),
        );
      },
    );
  }

  Widget _statisticCard(
      {required String title,
      required String value,
      required Color color,
      required double width}) {
    return MainCard(
      padding: const EdgeInsets.all(12),
      cardWidth: width,
      cardColor: AppColors.secondary,
      borderColor: Colors.transparent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.w400)),
          const SizedBox(height: 8),
          Text(value,
              style: TextStyle(
                  fontSize: 20, color: color, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}

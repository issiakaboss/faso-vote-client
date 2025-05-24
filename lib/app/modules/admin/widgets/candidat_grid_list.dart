import 'package:faso_vote_client/app/data/models/candidat.dart';
import 'package:faso_vote_client/app/themes/app_colors.dart';
import 'package:faso_vote_client/app/themes/app_text_styles.dart';
import 'package:faso_vote_client/app/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/helpers/responsive_helper.dart';
import '../../../widgets/custom_button.dart';

class CandidatGridList extends StatelessWidget {
  final List<Candidat> candidats;
  ResponsiveHelper responsive;
  final void Function(Candidat candidat)? onEditTap;
  final void Function(Candidat candidat)? onDeleteTap;

  CandidatGridList({
    super.key,
    required this.candidats,
    required this.responsive,
    this.onEditTap,
    this.onDeleteTap,
  });

  @override
  Widget build(BuildContext context) {
    if (candidats.isEmpty) {
      return Center(
        child: CustomText(
          text: 'Aucun candidat trouvé',
          style: AppTextStyles.heading6(),
        ),
      );
    }

    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: responsive.isMobile
            ? 1
            : responsive.isTablet
                ? 2
                : 3,
        mainAxisSpacing: 10.0,
        crossAxisSpacing: 10.0,
        mainAxisExtent: responsive.isMobile
            ? 300
            : responsive.isTablet
                ? 280
                : 290,
      ),
      shrinkWrap: true,
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.only(right: 12.0),
      itemCount: candidats.length,
      itemBuilder: (context, index) {
        final candidat = candidats[index];
        return Card(
          elevation: 1,
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: candidat.photoUrl != null
                          ? Image.network(
                              width: 120,
                              height: 100,
                              candidat.photoUrl!,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Center(
                                  child: Container(
                                    color: const Color.fromARGB(
                                        255, 210, 210, 210),
                                    width: 120,
                                    height: 100,
                                    child: const Icon(Icons.broken_image,
                                        size: 25),
                                  ),
                                );
                              },
                            )
                          : const Icon(Icons.person, size: 80),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomText(
                            text: candidat.fullName,
                            overflow: TextOverflow.visible,
                            style: AppTextStyles.heading3(),
                          ),
                          const SizedBox(height: 10),
                          CustomText(
                            text: candidat.etablissement,
                            overflow: TextOverflow.visible,
                            style: AppTextStyles.heading4().copyWith(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: AppColors.primary),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: "Theme",
                        overflow: TextOverflow.visible,
                        style: AppTextStyles.heading6(),
                      ),
                      CustomText(
                        text: candidat.theme ?? "Thème inconnu",
                        overflow: TextOverflow.visible,
                        style: AppTextStyles.bodyText2(),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CustomButton.outlineButton(
                      onPressed: () => onEditTap?.call(candidat),
                      buttonTitle: 'Éditer',
                      surfix: const Icon(Icons.edit, size: 13),
                      borderColor: Colors.grey,
                      textStyle: const TextStyle(color: Colors.black),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 0),
                    ),
                    CustomButton.outlineButton(
                      onPressed: () => onDeleteTap?.call(candidat),
                      buttonTitle: 'Supprimer',
                      borderColor: Colors.red,
                      textStyle: const TextStyle(color: Colors.red),
                      surfix:
                          const Icon(Icons.delete, size: 13, color: Colors.red),
                      padding: const EdgeInsets.symmetric(
                          vertical: 0, horizontal: 6),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

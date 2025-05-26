import 'package:faso_vote_client/app/modules/admin/Candidats/controllers/candidats_controller.dart';
import 'package:faso_vote_client/app/modules/admin/widgets/candidat_grid_list.dart';
import 'package:faso_vote_client/app/themes/app_colors.dart';
import 'package:faso_vote_client/app/widgets/custom_text_form_field.dart';
import 'package:faso_vote_client/generated/locales.g.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:faso_vote_client/app/widgets/custom_button.dart';
import 'package:faso_vote_client/app/themes/app_text_styles.dart';
import 'package:faso_vote_client/app/widgets/custom_text.dart';

import '../../../../utils/helpers/responsive_helper.dart';

class CandidatsView extends GetView<CandidatsController> {
  int? voteId;
  final void Function()? onAddTap;
  CandidatsView({super.key, this.onAddTap, this.voteId}) {
    controller.voteId.value = voteId;
    controller.loadCandidatesData();
  }

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveHelper(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                text: "Liste des candidats",
                style: AppTextStyles.heading4(),
              ),
              responsive.isMobile
                  ? IconButton.outlined(
                      padding: const EdgeInsets.all(0.0),
                      style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(
                            AppColors.primary.withOpacity(0.1)),
                        side: const WidgetStatePropertyAll(BorderSide.none),
                      ),
                      onPressed: () {
                        onAddTap?.call();
                      },
                      icon: const Icon(Icons.add, color: AppColors.primary))
                  : CustomButton.primaryButton(
                      onPressed: () {
                        onAddTap?.call();
                      },
                      buttonTitle: LocaleKeys.buttons_new_candidat.tr,
                      prefix: const Icon(Icons.add, color: Colors.white),
                      fontSize: 14,
                      mainAxisSize: MainAxisSize.min,
                      elevation: 0.0,
                      borderRadius: 6.0,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5.0, vertical: 8.0),
                    ),
            ],
          ),
          const SizedBox(height: 16),
          Expanded(
            child: Obx(() {
              return CandidatGridList(
                candidats: controller.candidates.value,
                responsive: responsive,
                onEditTap: (candidat) {
                  controller.displayEditCandidatView(
                      voteId: voteId ?? 0, candidat: candidat);
                },
                onDeleteTap: (candidat) =>
                    controller.deleteCandidat(candidatId: candidat.id),
              );
            }),
          ),
        ],
      ),
    );
  }
}

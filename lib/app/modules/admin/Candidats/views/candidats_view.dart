import 'package:faso_vote_client/app/modules/admin/Candidats/controllers/candidats_controller.dart';
import 'package:faso_vote_client/app/modules/admin/widgets/candidat_grid_list.dart';
import 'package:faso_vote_client/app/widgets/custom_text_form_field.dart';
import 'package:faso_vote_client/generated/locales.g.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:faso_vote_client/app/widgets/custom_button.dart';
import 'package:faso_vote_client/app/themes/app_text_styles.dart';
import 'package:faso_vote_client/app/widgets/custom_text.dart';

import '../../../../utils/helpers/responsive_helper.dart';

class CandidatsView extends GetView<CandidatsController> {
  const CandidatsView({super.key});

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
                style: AppTextStyles.heading3(),
              ),
              CustomButton.primaryButton(
                onPressed: () {
                  // controller.displayAddHotelView();
                },
                buttonTitle: LocaleKeys.buttons_new_candidat.tr,
                prefix: const Icon(Icons.add, color: Colors.white),
                fontSize: 14,
                mainAxisSize: MainAxisSize.min,
                elevation: 0.0,
                borderRadius: 6.0,
                padding:
                    const EdgeInsets.symmetric(horizontal: 5.0, vertical: 12.0),
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
                  print("candidat $candidat");
                },
                onDeleteTap: (candidat) {},
              );
            }),
          ),
        ],
      ),
    );
  }
}

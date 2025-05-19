import 'package:faso_vote_client/app/modules/admin/widgets/toggle_vote.dart';
import 'package:faso_vote_client/app/themes/app_text_styles.dart';
import 'package:faso_vote_client/app/utils/constants/app_constant.dart';
import 'package:faso_vote_client/app/widgets/custom_button.dart';
import 'package:faso_vote_client/app/widgets/custom_text.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../widgets/vote_card.dart';
import '../controllers/dashboard_controller.dart';

class DashboardView extends GetView<DashboardController> {
  const DashboardView({super.key});
  @override
  Widget build(BuildContext context) {
    final screenWidth = context.width;

    // Define breakpoints (you can adjust)
    final bool isMobile = screenWidth < 600;
    final bool isTablet = screenWidth >= 600 && screenWidth < 1024;
    final bool isDesktop = screenWidth >= 1024;
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: isDesktop
              ? AppConstant.desktopHaurizontalPadding
              : isTablet
                  ? AppConstant.tabletHaurizontalPadding
                  : 10.0),
      color: Get.theme.scaffoldBackgroundColor,
      child: Scaffold(
        body: LayoutBuilder(
          builder: (context, constraints) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: context.height / 8,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(Icons.logo_dev),
                        ),
                        !isMobile ? ToggleVotes() : const SizedBox.shrink(),
                        Row(
                          children: [
                            IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.language)),
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.account_circle),
                              iconSize: 50,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                        text: "Toutes les votes",
                        style: AppTextStyles.heading4(),
                      ),
                      CustomButton.primaryButton(
                          onPressed: () {}, buttonTitle: "Nouveau Vote"),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: isMobile
                            ? 1
                            : (constraints.maxWidth > 1000 ? 4 : 2),
                        crossAxisSpacing: 20,
                        mainAxisSpacing: 20,
                        childAspectRatio: isMobile
                            ? 0.95
                            : isTablet
                                ? 0.9
                                : 1,
                        // mainAxisExtent: 330,
                      ),
                      itemCount: 4,
                      itemBuilder: (context, index) {
                        return VoteCard(
                          title: index == 0
                              ? "Ministère de l'éducation"
                              : index == 1
                                  ? "President de CIB"
                                  : "Chef de Police",
                          location: index == 1 ? "Koudougou" : "Ouagadougou",
                          date: "02 Fev 2025",
                          duration: index == 0
                              ? "2h"
                              : index == 1
                                  ? "24h"
                                  : "1 jour",
                          status: index == 0
                              ? "En cours"
                              : index == 1
                                  ? "Bloqué"
                                  : "Terminé",
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

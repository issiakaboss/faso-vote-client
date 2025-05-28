import 'package:faso_vote_client/app/modules/admin/widgets/toggle_vote.dart';
import 'package:faso_vote_client/app/routes/app_pages.dart';
import 'package:faso_vote_client/app/themes/app_text_styles.dart';
import 'package:faso_vote_client/app/utils/constants/app_constant.dart';
import 'package:faso_vote_client/app/utils/functions/function.dart';
import 'package:faso_vote_client/app/widgets/custom_button.dart';
import 'package:faso_vote_client/app/widgets/custom_text.dart';
import 'package:faso_vote_client/generated/locales.g.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../utils/helpers/responsive_helper.dart';
import '../../widgets/vote_card.dart';
import '../controllers/dashboard_controller.dart';

class DashboardView extends GetView<DashboardController> {
  const DashboardView({super.key});
  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveHelper(context);
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: responsive.isDesktop
              ? AppConstant.desktopHaurizontalPadding
              : responsive.isTablet
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
                  Column(
                    children: [
                      // Top bar with logo, toggle, and profile/language
                      SizedBox(
                        height: responsive.isMobile
                            ? context.height / 6
                            : context.height / 8,
                        child: responsive.isMobile
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Icon(Icons.logo_dev),
                                  ),
                                  ToggleVotes(
                                    onChanged: (index) {
                                      controller.selectedToggleIndex.value =
                                          index;
                                    },
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      IconButton(
                                          onPressed: () {},
                                          icon: const Icon(Icons.language)),
                                      IconButton(
                                        onPressed: () {},
                                        icon: const Icon(Icons.account_circle),
                                        iconSize: 40,
                                      ),
                                    ],
                                  ),
                                ],
                              )
                            : Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Icon(Icons.logo_dev),
                                  ),
                                  ToggleVotes(
                                    onChanged: (index) {
                                      controller.selectedToggleIndex.value =
                                          index;
                                    },
                                  ),
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

                      const SizedBox(height: 10),

                      // Title and new vote button
                      responsive.isMobile
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                CustomText(
                                  text: LocaleKeys.all_votes.tr,
                                  style: AppTextStyles.heading4(),
                                ),
                                const SizedBox(height: 10),
                                CustomButton.primaryButton(
                                  elevation: 0.0,
                                  onPressed: () {
                                    Get.toNamed(AppPages.ADDING_VOTE);
                                  },
                                  prefix: const Icon(Icons.add,
                                      color: Colors.white),
                                  buttonTitle: LocaleKeys.buttons_new_vote.tr,
                                  borderRadius: 3.0,
                                ),
                              ],
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomText(
                                  text: LocaleKeys.all_votes.tr,
                                  style: AppTextStyles.heading5(),
                                ),
                                CustomButton.primaryButton(
                                  elevation: 0.0,
                                  onPressed: () async {
                                    final result =
                                        await Get.toNamed(AppPages.ADDING_VOTE);
                                    if (result == true) {
                                      controller.loadVotes();
                                    }
                                  },
                                  prefix: const Icon(Icons.add,
                                      color: Colors.white),
                                  buttonTitle: LocaleKeys.buttons_new_vote.tr,
                                  borderRadius: 3.0,
                                ),
                              ],
                            ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: Obx(() {
                      final votes = controller.votes;
                      return GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: responsive.isMobile
                                ? 1
                                : (constraints.maxWidth > 1000 ? 4 : 2),
                            crossAxisSpacing: 20,
                            mainAxisSpacing: 20,
                            childAspectRatio: responsive.isMobile
                                ? 0.95
                                : responsive.isTablet
                                    ? 0.9
                                    : 0.7),
                        itemCount: votes.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          final vote = votes[index];
                          return GestureDetector(
                            onTap: () {
                              Get.toNamed(AppPages.VOTE_DETAIL,
                                  arguments: vote);
                            },
                            child: VoteCard(
                              vote: vote,
                              onEditTap: (vote) async {
                                final result = await Get.toNamed(
                                    AppPages.ADDING_VOTE,
                                    arguments: vote);
                                if (result == true) {
                                  controller.loadVotes();
                                }
                              },
                              onBlockTap: (vote) {},
                              onDeleteTap: (vote) {
                                controller.deleteVote(voteId: vote.id);
                              },
                              onShareTap: (vote) {
                                Get.toNamed('${Routes.vote}/${vote.id}');
                              },
                              onCopyTap: (vote) {
                                Functions.copyText(text: vote.url);
                                print("url ${vote.url}");
                                // Get.toNamed('${Routes.vote}/${vote.uuid}');
                              },
                              onResutlTap: (vote) {
                                Get.toNamed(AppPages.VOTE_DETAIL,
                                    arguments: vote);
                              },
                              onUnBlockTap: (vote) {},
                            ),
                          );
                        },
                      );
                    }),
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

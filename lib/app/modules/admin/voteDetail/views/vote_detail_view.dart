import 'package:faso_vote_client/app/data/models/vote.dart';
import 'package:faso_vote_client/app/modules/admin/Candidats/views/candidats_view.dart';
import 'package:faso_vote_client/app/modules/admin/results/views/results_view.dart';
import 'package:faso_vote_client/app/routes/app_pages.dart';
import 'package:faso_vote_client/app/themes/app_colors.dart';
import 'package:faso_vote_client/app/themes/app_text_styles.dart';
import 'package:faso_vote_client/app/widgets/custom_text.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import '../../../../utils/helpers/responsive_helper.dart';
import '../controllers/vote_detail_controller.dart';

class VoteDetailView extends GetView<VoteDetailController> {
  final VoteModel? selectedVote = Get.arguments;
  final List<String> tabs = ['Candidats', 'Résultats'];
  VoteDetailView({super.key}) {
    if (selectedVote != null) {
      controller.loadVoteCandidats(voteId: selectedVote!.id.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveHelper(context);
    return DefaultTabController(
      length: tabs.length,
      child: Obx(() {
        var voteCandidats = controller.voteCandidats.value;
        return Scaffold(
          key: controller.scaffoldKey,
          endDrawer: Obx(() => controller.currentEndDrawer.value),
          appBar: AppBar(
            leading: BackButton(
              onPressed: () => Get.offNamed(AppPages.DASHBOARD),
            ),
            centerTitle: false,
            title: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              controller: ScrollController(),
              physics: const BouncingScrollPhysics(),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                    child: buildHotelLogo(voteCandidats?.vote.logo),
                  ),
                  const SizedBox(width: 20),
                  CustomText(
                    text: voteCandidats?.vote.title ?? '',
                    style: AppTextStyles.heading3()
                        .copyWith(fontSize: responsive.isMobile ? 18 : null),
                  ),
                ],
              ),
            ),
            actions: [Container()],
            bottom: TabBar(
              tabs: tabs.map((tab) => Tab(text: tab)).toList(),
              indicatorColor: AppColors.primary.withOpacity(0.6),
              labelColor: AppColors.primary,
              unselectedLabelColor: Colors.grey,
              indicatorSize: TabBarIndicatorSize.label,
              labelStyle:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 21),
            ),
          ),
          body: TabBarView(
            children: [
              CandidatsView(
                voteId: selectedVote?.id,
                candidats: voteCandidats?.candidats ?? [],
                onAddTap: () {
                  controller.displayAddCandidatView(
                      voteId: selectedVote?.id ?? 0);
                },
              ),
              ResultsView(
                candidats: voteCandidats?.candidats,
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget buildHotelLogo(String? imageUrl) {
    if (imageUrl == null) {
      return Image.network(
        "",
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return const Center(
            child: Icon(Icons.broken_image, size: 25),
          );
        },
      );
    }

    return Image.network(
      imageUrl,
      alignment: Alignment.center,
      fit: BoxFit.cover,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return Center(
          child: CircularProgressIndicator(
            value: loadingProgress.expectedTotalBytes != null
                ? loadingProgress.cumulativeBytesLoaded /
                    loadingProgress.expectedTotalBytes!
                : null,
          ),
        );
      },
      errorBuilder: (context, error, stackTrace) {
        return const Center(
          child: Icon(Icons.broken_image, size: 25),
        );
      },
      headers: const {
        "Accept": "image/*",
      },
    );
  }
}

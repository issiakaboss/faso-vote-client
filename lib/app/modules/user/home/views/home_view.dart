import 'package:faso_vote_client/app/widgets/custom_button.dart';
import 'package:faso_vote_client/app/widgets/custom_card.dart';
import 'package:faso_vote_client/app/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../themes/app_colors.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Obx(
        () => SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                const SizedBox(height: 20), // remplace le Padding global ici
                const CircleAvatar(
                  radius: 32,
                  backgroundImage: AssetImage('assets/images/logo.png'),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Vote pour le ministre de commerce',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                const Text(
                  'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum',
                  style: TextStyle(fontSize: 14, color: Colors.black54),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                _buildTabBar(),
                const SizedBox(height: 24),

                controller.selectedTab.value == 0
                    ? Padding(
                        padding: const EdgeInsets.only(
                            left: 60.0, right: 60, bottom: 20),
                        child: _buildCandidatesSection(
                            title: "Liste des candidats"),
                      )
                    : Padding(
                        padding: const EdgeInsets.only(
                            left: 60.0, right: 60, bottom: 20),
                        child: _buildCandidatesSection(
                            title: "Résultats des votes",
                            bouton: MainCard(
                              cardWidth: Get.width / 2,
                              cardColor: Colors.green.withOpacity(0.1),
                              cardHeight: 35,
                              borderColor: Colors.transparent,
                              child: const Center(
                                child: Text(
                                  '288 Votes',
                                  style: TextStyle(
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            )),
                      )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTabBar() {
    return Obx(() => MainCard(
          padding: const EdgeInsets.all(4),
          cardColor: Colors.white,
          cardWidth: Get.width / 5.5,
          radius: 30,
          borderColor: Colors.grey.shade200,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _tabButton("Candidates", 0),
              _tabButton("Resultats", 1),
            ],
          ),
        ));
  }

  Widget _tabButton(String text, int index) {
    final isSelected = controller.selectedTab.value == index;
    return GestureDetector(
      onTap: () => controller.selectedTab.value = index,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primary.withOpacity(0.1)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isSelected ? AppColors.primary : Colors.grey,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _buildCandidatesSection({required String title, Widget? bouton}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.title,
          ),
        ),
        const SizedBox(
          height: 9,
        ),
        controller.selectedTab.value == 0
            ? Container()
            : Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  resultCard("8000", "Votes total", Colors.black),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: resultCard("4000", "Ayant voté", Colors.green),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: resultCard("4000", "Non voté", Colors.red),
                  ),
                ],
              ),
        const SizedBox(height: 16),
        Obx(() => Wrap(
              spacing: 16,
              runSpacing: 16,
              children: controller.candidates.map((candidate) {
                return MainCard(
                  padding: const EdgeInsets.all(12),
                  cardWidth: Get.width / 4.9,
                  cardHeight: Get.height / 2.5,
                  cardColor: Colors.white,
                  borderWidth: 0.5,
                  borderColor: Colors.grey.shade200,
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(40),
                        child: Image.network(
                          candidate['image'].toString(),
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
                        text: candidate['name'] ?? '',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 12),
                      CustomText(
                        text: candidate['title'] ?? '',
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 20),
                      bouton ??
                          MainButton(
                            onPressed: () {},
                            text: "Voter",
                            height: 35,
                            textcolor: Colors.white,
                            color: AppColors.primary,
                          )
                    ],
                  ),
                );
              }).toList(),
            )),
      ],
    );
  }

  Widget resultCard(String title, String value, Color color) {
    return MainCard(
      padding: const EdgeInsets.all(10),
      cardWidth: 350,
      cardHeight: 80,
      cardColor: AppColors.secondary,
      borderColor: Colors.transparent,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}

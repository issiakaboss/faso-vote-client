import 'package:faso_vote_client/app/themes/app_colors.dart';
import 'package:faso_vote_client/app/widgets/custom_button.dart';
import 'package:faso_vote_client/app/widgets/custom_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ConfirmationPopup extends StatelessWidget {
  final VoidCallback onCancel;
  final VoidCallback onConfirm;

  const ConfirmationPopup({
    super.key,
    required this.onCancel,
    required this.onConfirm,
  });

  @override
  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: MainCard(
        cardWidth: Get.width / (isMobile ? 1.1 : 2),
        cardHeight: Get.height / (isMobile ? 2 : 2),
        borderColor: Colors.transparent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundColor: Colors.red.shade100,
              radius: 40,
              child: const Icon(
                Icons.warning_amber_rounded,
                color: Colors.red,
                size: 40,
              ),
            ),
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                "Êtes-vous sûr(e) de votre choix ? Il est important de savoir que cette opération, une fois votée, ne pourra pas être annulée.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.black),
              ),
            ),
            const SizedBox(height: 24),
            isMobile
                ? Column(
                    children: [
                      CustomButton.primaryButton(
                        padding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 40),
                        onPressed: onConfirm,
                        buttonTitle: "Continuer",
                      ),
                      const SizedBox(height: 12),
                      CustomButton.primaryButton(
                        padding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 40),
                        onPressed: onCancel,
                        buttonTitle: "Annuler",
                        textStyle: const TextStyle(
                            color: AppColors.title,
                            fontWeight: FontWeight.bold),
                        borderRadius: 10,
                        backgroundColor:
                            const Color.fromARGB(255, 227, 235, 246),
                      ),
                    ],
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomButton.primaryButton(
                        padding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 40),
                        onPressed: onCancel,
                        buttonTitle: "Annuler",
                        textStyle: const TextStyle(
                            color: AppColors.title,
                            fontWeight: FontWeight.bold),
                        borderRadius: 10,
                        backgroundColor:
                            const Color.fromARGB(255, 227, 235, 246),
                      ),
                      const SizedBox(width: 12),
                      CustomButton.primaryButton(
                        padding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 40),
                        onPressed: onConfirm,
                        buttonTitle: "Continuer",
                      ),
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}

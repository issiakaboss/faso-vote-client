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
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: MainCard(
        cardWidth: Get.width / 2,
        cardHeight: Get.height / 2,
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
              padding: EdgeInsets.only(left: 12.0, right: 12),
              child: Text(
                "Êtes-vous sûr(e) de votre choix ? Il est important de savoir que cette opération, une fois votée, ne pourra pas être annulée.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.black),
              ),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MainButton(
                  onPressed: onCancel,
                  color: const Color.fromARGB(255, 220, 236, 248),
                  text: "Annuler",
                  textcolor: AppColors.title,
                ),
                const SizedBox(width: 12),
                MainButton(
                  onPressed: onConfirm,
                  color: AppColors.primary,
                  text: "Continuer",
                  textcolor: AppColors.secondary,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

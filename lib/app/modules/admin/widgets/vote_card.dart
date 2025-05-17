import 'package:faso_vote_client/app/themes/app_colors.dart';
import 'package:faso_vote_client/app/themes/app_text_styles.dart';
import 'package:faso_vote_client/app/widgets/custom_button.dart';
import 'package:faso_vote_client/app/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VoteCard extends StatelessWidget {
  final String title;
  final String location;
  final String date;
  final String duration;
  final String status;

  const VoteCard({
    required this.title,
    required this.location,
    required this.date,
    required this.duration,
    required this.status,
    Key? key,
  }) : super(key: key);

  Color get statusColor {
    switch (status) {
      case "En cours":
        return Colors.orange;
      case "Bloqué":
        return Colors.red;
      case "Terminé":
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: Get.theme.cardColor,
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(title,
                  style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.location_on,
                    size: 18,
                  ),
                  Text(location),
                ],
              ),
              leading: CircleAvatar(
                backgroundColor: AppColors.background,
                child: Image.network(
                  "",
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return const Center(
                      child: Icon(Icons.broken_image, size: 25),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    text: "Date:",
                    style: AppTextStyles.heading5(),
                  ),
                  CustomText(
                    text: date,
                    style: AppTextStyles.bodyText2Bold(),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    text: "Durée:",
                    style: AppTextStyles.heading5(),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: AppColors.textSecondary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(6)),
                    padding: const EdgeInsets.symmetric(
                        vertical: 2.0, horizontal: 8.0),
                    child: CustomText(
                      text: duration,
                      style: AppTextStyles.bodyText2Bold(),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    text: "Status:",
                    style: AppTextStyles.heading5(),
                  ),
                  Chip(
                    label: Text(status),
                    backgroundColor: statusColor.withOpacity(0.1),
                    labelStyle: TextStyle(color: statusColor),
                    side: const BorderSide(width: 0.0, color: Colors.white),
                    padding: const EdgeInsets.symmetric(vertical: 0.0),
                  ),
                ],
              ),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.only(top: 2.0),
              child: Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  if (status == "Bloqué")
                    ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 140),
                      child: CustomButton.outlineButton(
                          onPressed: () {},
                          buttonTitle: "Débloquer",
                          fontSize: 12,
                          borderRadius: 50.0,
                          borderColor: Colors.grey,
                          forgroundColor: Colors.black,
                          prefix: const Icon(
                            Icons.lock_open,
                            size: 12.0,
                            color: Colors.black,
                          )),
                    ),
                  if (status == "En cours")
                    ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 140),
                      child: CustomButton.outlineButton(
                          onPressed: () {},
                          buttonTitle: "Bloquer",
                          fontSize: 12,
                          borderRadius: 50.0,
                          borderColor: Colors.grey,
                          forgroundColor: Colors.black,
                          prefix: const Icon(
                            Icons.lock_open,
                            size: 12.0,
                            color: Colors.black,
                          )),
                    ),
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 140),
                    child: CustomButton.outlineButton(
                        onPressed: () {},
                        buttonTitle: "Éditer",
                        fontSize: 12,
                        borderRadius: 50.0,
                        borderColor: Colors.purple,
                        forgroundColor: Colors.purple,
                        prefix: const Icon(
                          Icons.edit,
                          size: 12.0,
                          color: Colors.purple,
                        )),
                  ),
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 140),
                    child: CustomButton.outlineButton(
                        onPressed: () {},
                        buttonTitle: "Supprimer",
                        fontSize: 12,
                        borderRadius: 50.0,
                        borderColor: Colors.red,
                        forgroundColor: Colors.red,
                        prefix: const Icon(
                          Icons.delete_forever,
                          size: 12.0,
                          color: Colors.red,
                        )),
                  ),
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 140),
                    child: CustomButton.outlineButton(
                        onPressed: () {},
                        buttonTitle: "Résultats",
                        fontSize: 12,
                        borderRadius: 50.0,
                        borderColor: Colors.grey,
                        forgroundColor: Colors.black,
                        prefix: const Icon(
                          Icons.visibility,
                          size: 12.0,
                          color: Colors.black,
                        )),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

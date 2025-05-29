import 'package:faso_vote_client/app/data/models/vote.dart';
import 'package:faso_vote_client/app/themes/app_colors.dart';
import 'package:faso_vote_client/app/themes/app_text_styles.dart';
import 'package:faso_vote_client/app/widgets/custom_button.dart';
import 'package:faso_vote_client/app/widgets/custom_text.dart';
import 'package:faso_vote_client/generated/locales.g.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VoteCard extends StatelessWidget {
  final VoteModel vote;
  final void Function(VoteModel vote)? onEditTap;
  final void Function(VoteModel vote)? onDeleteTap;
  final void Function(VoteModel vote)? onBlockTap;
  final void Function(VoteModel vote)? onUnBlockTap;
  final void Function(VoteModel vote)? onShareTap;
  final void Function(VoteModel vote)? onCopyTap;
  final void Function(VoteModel vote)? onResutlTap;
  const VoteCard({
    required this.vote,
    this.onDeleteTap,
    this.onEditTap,
    this.onBlockTap,
    this.onUnBlockTap,
    this.onCopyTap,
    this.onShareTap,
    this.onResutlTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: Get.theme.cardColor,
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(vote.title ?? '',
                  style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.location_on,
                    size: 18,
                  ),
                  Text(vote.location ?? ''),
                ],
              ),
              leading: CircleAvatar(
                backgroundColor: AppColors.background,
                child: Image.network(
                  width: 50,
                  height: 50,
                  vote.logo ?? '',
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return const Center(
                      child: Icon(Icons.broken_image, size: 25),
                    );
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                children: [
                  Tooltip(
                    padding: const EdgeInsets.all(10.0),
                    richMessage: TextSpan(
                      text: LocaleKeys.description.tr,
                      children: [
                        TextSpan(
                            text: vote.description,
                            style: AppTextStyles.bodyText3().copyWith(
                              overflow: TextOverflow.visible,
                              color: Colors.white,
                            )),
                      ],
                    ),
                    child: CustomText(
                      text: vote.description!.length > 30
                          ? vote.description
                                  ?.substring(0, 30)
                                  .padRight(33, '.') ??
                              ''
                          : vote.description ?? "",
                      style: AppTextStyles.bodyText2(),
                    ),
                  ),
                ],
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
                    text: vote.date ?? '',
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
                      text: vote.duration ?? '',
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
                    label: Text(vote.status ?? ''),
                    backgroundColor: vote.statusDisplayColor.withOpacity(0.1),
                    labelStyle: TextStyle(color: vote.statusDisplayColor),
                    side: const BorderSide(width: 0.0, color: Colors.white),
                    padding: const EdgeInsets.symmetric(vertical: 0.0),
                  ),
                ],
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(top: 2.0),
              child: Wrap(
                alignment: WrapAlignment.spaceBetween,
                spacing: 10,
                runSpacing: 10,
                children: [
                  if (vote.status == "Inactive")
                    ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 140),
                      child: CustomButton.outlineButton(
                          onPressed: () => onUnBlockTap?.call(vote),
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
                  if (vote.status == "Active")
                    ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 140),
                      child: CustomButton.outlineButton(
                          onPressed: () => onBlockTap?.call(vote),
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
                        onPressed: () => onEditTap?.call(vote),
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
                        onPressed: () => onDeleteTap?.call(vote),
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
                        onPressed: () => onResutlTap?.call(vote),
                        buttonTitle: "Détails",
                        fontSize: 12,
                        borderRadius: 50.0,
                        borderColor: Colors.blueAccent,
                        forgroundColor: Colors.blueAccent,
                        prefix: const Icon(
                          Icons.visibility,
                          size: 12.0,
                          color: Colors.blueAccent,
                        )),
                  ),
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 130),
                    child: CustomButton.outlineButton(
                        onPressed: () => onShareTap?.call(vote),
                        buttonTitle: "Partager lien",
                        fontSize: 12,
                        borderRadius: 50.0,
                        borderColor: Colors.grey,
                        forgroundColor: Colors.blue,
                        prefix: const Icon(
                          Icons.share,
                          size: 12.0,
                          color: Colors.blue,
                        )),
                  ),
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 120),
                    child: CustomButton.outlineButton(
                        onPressed: () => onCopyTap?.call(vote),
                        buttonTitle: "Copier lien",
                        fontSize: 12,
                        borderRadius: 50.0,
                        borderColor: Colors.grey,
                        forgroundColor: Colors.grey,
                        prefix: const Icon(
                          Icons.copy,
                          size: 12.0,
                          color: Colors.grey,
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

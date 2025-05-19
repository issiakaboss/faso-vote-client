import 'package:faso_vote_client/app/themes/app_colors.dart';
import 'package:faso_vote_client/app/themes/app_text_styles.dart';
import 'package:faso_vote_client/app/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ToggleVotes extends StatefulWidget {
  @override
  _ToggleVotesState createState() => _ToggleVotesState();
}

class _ToggleVotesState extends State<ToggleVotes> {
  int selectedIndex = 0;

  final List<String> labels = ["Toutes les votes", "Votes en cours"];
  final List<IconData> icons = [Icons.check_box, Icons.podcasts];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width / 4.2,
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 14.0),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: Colors.grey.shade200)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(labels.length, (index) {
          final bool isSelected = selectedIndex == index;
          return GestureDetector(
            onTap: () {
              setState(() {
                selectedIndex = index;
              });
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColors.primary.withOpacity(0.2)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(30),
                border: Border.all(
                    color: isSelected
                        ? AppColors.primary.withOpacity(0.5)
                        : Colors.grey.shade200),
              ),
              child: Row(
                children: [
                  Icon(
                    icons[index],
                    size: 18,
                    color: isSelected ? AppColors.primary : Colors.grey[600],
                  ),
                  const SizedBox(width: 6),
                  CustomText(
                    text: labels[index],
                    style: AppTextStyles.bodyText1().copyWith(
                        fontSize: 14.0,
                        color:
                            isSelected ? AppColors.primary : Colors.grey[700]),
                  )
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}

import 'package:faso_vote_client/app/themes/app_colors.dart';
import 'package:faso_vote_client/app/themes/app_text_styles.dart';
import 'package:faso_vote_client/app/widgets/custom_text.dart';
import 'package:faso_vote_client/generated/locales.g.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/helpers/responsive_helper.dart';

class ToggleVotes extends StatefulWidget {
  final Function(int index) onChanged;

  const ToggleVotes({Key? key, required this.onChanged}) : super(key: key);

  @override
  _ToggleVotesState createState() => _ToggleVotesState();
}

class _ToggleVotesState extends State<ToggleVotes> {
  int selectedIndex = 0;

  final List<String> labels = [
    LocaleKeys.all_votes.tr,
    LocaleKeys.pending_votes.tr
  ];
  final List<IconData> icons = [Icons.check_box, Icons.podcasts];

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveHelper(context).isMobile;
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: isMobile ? 2.0 : 4.0,
        horizontal: isMobile ? 8.0 : 14.0,
      ),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: Colors.grey.shade200)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(labels.length, (index) {
          final bool isSelected = selectedIndex == index;
          return Padding(
            padding: index == 1
                ? EdgeInsets.only(left: isMobile ? 4.0 : 8.0)
                : const EdgeInsets.all(0.0),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  selectedIndex = index;
                });
                widget.onChanged(index);
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                padding: EdgeInsets.symmetric(
                  horizontal: isMobile ? 10 : 14,
                  vertical: isMobile ? 6 : 10,
                ),
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
                      size: isMobile ? 16 : 18,
                      color: isSelected ? AppColors.primary : Colors.grey[600],
                    ),
                    const SizedBox(width: 6),
                    CustomText(
                      text: labels[index],
                      style: AppTextStyles.bodyText1().copyWith(
                          fontSize: isMobile ? 12.0 : 14.0,
                          color: isSelected
                              ? AppColors.primary
                              : Colors.grey[700]),
                    )
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class CustomBottomSheet {
  static Future<Widget?> displayBottomSheet({
    required List<Widget> items,
    double minHeight = 200.0,
    double? maxHeight,
    MainAxisAlignment mainAxisAlignment = MainAxisAlignment.start,
    CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.start,
    void Function()? onBottomSheetClose,
  }) {
    return Get.bottomSheet(
      backgroundColor: Get.theme.cardColor,
      GestureDetector(
        behavior: HitTestBehavior.deferToChild,
        onTap: () => FocusScope.of(Get.context!).unfocus(),
        child: ConstrainedBox(
          constraints: BoxConstraints(
              minHeight: minHeight,
              minWidth: Get.width,
              maxHeight: maxHeight ?? Get.height / 2),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 24.0, vertical: 10.0),
            child: SingleChildScrollView(
              controller: ScrollController(),
              child: Column(
                mainAxisAlignment: mainAxisAlignment,
                crossAxisAlignment: crossAxisAlignment,
                children: items,
              ),
            ),
          ),
        ),
      ),
    ).then((value) {
      if (onBottomSheetClose != null) {
        onBottomSheetClose();
      }
      return null;
    });
  }
}

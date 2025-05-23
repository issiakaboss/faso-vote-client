import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../themes/app_text_styles.dart';
import '../tiers/countryCodeBox/lib/country_code_picker.dart';

CountryCodePicker contryCodeBox({RxString? selectedCode}) {
  return CountryCodePicker(
    onChanged: (countryCode) {
      selectedCode!.value = countryCode.dialCode!;
    },
    initialSelection: "Burkina Faso",
    favorite: const ["Burkina Faso"],
    enabled: true,
    closeIcon: Icon(
      Icons.close,
      color: Theme.of(Get.context!).primaryColor,
    ),
    textStyle: AppTextStyles.setColor(style: AppTextStyles.bodyText1Bold()),
    margin: const EdgeInsets.only(right: 5.0),
    padding: const EdgeInsets.only(bottom: 2.0),
    flagWidth: 25,
  );
}

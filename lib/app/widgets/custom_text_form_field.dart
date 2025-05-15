import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../themes/app_colors.dart';
import '../themes/app_text_styles.dart';
import 'country_code_box.dart';
import 'custom_text.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController? controller;
  final AutovalidateMode autovalidateMode;
  final String? labelText;
  final String? hintText;
  final RxnString? errorMessage;
  final TextInputType? keyboardType;
  final bool obscureText;
  final String? Function(String?)? validator;
  final TextInputAction? textInputAction;
  final Function(String)? onFieldSubmitted;
  final Widget? prefix;
  final Widget? suffix;
  final Function()? onTap;
  final void Function(String)? onChanged;
  final bool isReadOnly;
  final bool showCountries;
  final List<TextInputFormatter>? inputFormatters;
  final RxString? selectedCountryCode;

  const CustomTextFormField({
    super.key,
    this.controller,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
    this.labelText,
    this.hintText,
    required this.errorMessage,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.validator,
    this.textInputAction,
    this.onFieldSubmitted,
    this.prefix,
    this.suffix,
    this.onTap,
    this.onChanged,
    this.isReadOnly = false,
    this.inputFormatters,
    this.showCountries = false,
    this.selectedCountryCode,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: labelText ?? '',
          style: AppTextStyles.inputLabel(),
          overflow: TextOverflow.visible,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            if (showCountries) ...[
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: contryCodeBox(selectedCode: selectedCountryCode),
              )
            ],
            Expanded(
              child: TextFormField(
                controller: controller,
                keyboardType: keyboardType,
                obscureText: obscureText,
                validator: validator,
                textInputAction: textInputAction,
                onFieldSubmitted: onFieldSubmitted,
                readOnly: isReadOnly,
                onTap: onTap,
                onChanged: onChanged,
                autovalidateMode: autovalidateMode,
                decoration: InputDecoration(
                  hintText: hintText,
                  prefixIcon: prefix,
                  suffixIcon: suffix,
                  contentPadding: const EdgeInsets.only(top: 25.0),
                  border: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 1.0),
                  ),
                  enabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 1.0),
                  ),
                  focusedBorder: const UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: AppColors.primary, width: 2.0),
                  ),
                  errorStyle: const TextStyle(
                    fontSize: 0,
                    height: 0,
                    color: Colors.transparent,
                  ),
                  filled: false,
                  fillColor: AppColors.primary,
                ),
                inputFormatters: inputFormatters,
              ),
            ),
          ],
        ),
        Obx(() {
          if (errorMessage?.value != null && errorMessage!.value!.isNotEmpty) {
            return Padding(
              padding:
                  EdgeInsets.only(top: 4.0, left: showCountries ? 70 : 0.0),
              child: CustomText(
                text: errorMessage!.value!,
                color: Colors.red,
                fontSize: 12,
              ),
            );
          }
          return const SizedBox.shrink();
        }),
      ],
    );
  }
}

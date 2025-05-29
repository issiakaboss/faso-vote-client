import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../../generated/locales.g.dart';
import '../../../../themes/app_colors.dart';
import '../../../../themes/app_text_styles.dart';
import '../../../../utils/validators/form_validator.dart';
import '../../../../widgets/custom_button.dart';
import '../../../../widgets/custom_text.dart';
import '../../../../widgets/custom_text_form_field.dart';
import '../../../../widgets/loding_indicator.dart';
import '../controllers/auth_controller.dart';

class AuthView extends GetView<AuthController> {
  const AuthView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => SizedBox(
          width: context.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 30.0),
                child: controller.errorMessage.value != null
                    ? Container(
                        width: context.width / 3,
                        height: 50,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: AppColors.error.withOpacity(0.2)),
                        child: CustomText(
                          text: controller.errorMessage.value!,
                          overflow: TextOverflow.visible,
                          color: AppColors.error,
                        ),
                      )
                    : null,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: CustomText(
                  text: LocaleKeys.login_title.tr,
                  style: AppTextStyles.heading2(),
                ),
              ),
              Container(
                width: context.width / 3,
                padding: const EdgeInsets.symmetric(
                    horizontal: 10.0, vertical: 35.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: const Color(0xFFFFFFFF),
                ),
                child: Form(
                  key: controller.loginFormkey,
                  child: Column(
                    children: [
                      CustomTextFormField(
                        controller: controller.emailController,
                        errorMessage: controller.emailError,
                        labelText: LocaleKeys.enter_email_address.tr,
                        hintText: "Ex: tof@gmail.com",
                        validator: (p0) {
                          final error = FormValidator.validateSimpleText(p0);
                          Future.microtask(
                              () => controller.emailError.value = error);
                          return error;
                        },
                        onChanged: (value) {
                          Future.microtask(() {
                            controller.errorMessage.value = null;
                            controller.emailError.value =
                                FormValidator.validateSimpleText(value);
                          });
                        },
                      ),
                      const SizedBox(height: 30),
                      CustomTextFormField(
                        controller: controller.passwordController,
                        errorMessage: controller.passwordError,
                        labelText: LocaleKeys.password.tr,
                        hintText: "Ex: rt^&5fdhw",
                        validator: (p0) {
                          final error = FormValidator.validatePassword(p0);
                          Future.microtask(
                              () => controller.passwordError.value = error);
                          return error;
                        },
                        onChanged: (value) {
                          Future.microtask(() {
                            controller.errorMessage.value = null;
                            controller.passwordError.value =
                                FormValidator.validatePassword(value);
                          });
                        },
                      ),
                      const SizedBox(height: 26.0),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12.0),
                        child: CustomButton.primaryButton(
                            padding: const EdgeInsets.symmetric(vertical: 16.0),
                            buttonTitle: controller.isLoding.value
                                ? controller.loadingMessage.value
                                : LocaleKeys.login.tr,
                            mainAxisSize: MainAxisSize.max,
                            prefix: controller.isLoding.value
                                ? const LoadingIndicator()
                                : null,
                            onPressed: () {
                              if (controller.isLoding.value) return;
                              controller.login();
                            },
                            isDisabled: controller.isLoding.value),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

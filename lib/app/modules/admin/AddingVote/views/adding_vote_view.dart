import 'package:faso_vote_client/app/routes/app_pages.dart';
import 'package:faso_vote_client/app/themes/app_colors.dart';
import 'package:faso_vote_client/app/themes/app_text_styles.dart';
import 'package:faso_vote_client/app/widgets/custom_text.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../../generated/locales.g.dart';
import '../../../../utils/helpers/responsive_helper.dart';
import '../../../../utils/validators/form_validator.dart';
import '../../../../widgets/custom_button.dart';
import '../../../../widgets/custom_text_form_field.dart';
import '../../../../widgets/dropdown_date_picker.dart';
import '../../../../widgets/image_picker_box.dart';
import '../controllers/adding_vote_controller.dart';

class AddingVoteView extends GetView<AddingVoteController> {
  const AddingVoteView({super.key});
  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveHelper(context);
    return Scaffold(
      body: SizedBox(
        width: context.width,
        height: context.height,
        child: Center(
          child: SizedBox(
            width: !responsive.isMobile ? context.width / 2 : null,
            height: context.height,
            child: SingleChildScrollView(
              controller: ScrollController(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: CustomText(
                      text: LocaleKeys.create_vote_title.tr,
                      style: AppTextStyles.heading2(),
                    ),
                  ),
                  const SizedBox(height: 30),
                  LayoutBuilder(
                    builder: (context, constraints) {
                      return Form(
                        key: controller.voteDataFormkey,
                        child: Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          alignment: WrapAlignment.center,
                          runSpacing: 16,
                          spacing: 16,
                          children: [
                            // Event Name
                            SizedBox(
                              width: (constraints.maxWidth - 64),
                              child: CustomTextFormField(
                                controller: controller.eventNameController,
                                labelText: LocaleKeys.user_name.tr,
                                hintText: LocaleKeys.enter_event_name.tr,
                                errorMessage: controller.eventNameError,
                                validator: (p0) {
                                  final error =
                                      FormValidator.validateSimpleText(p0);
                                  Future.microtask(() =>
                                      controller.eventNameError.value = error);
                                  return error;
                                },
                                onChanged: (value) {
                                  controller.eventNameError.value =
                                      FormValidator.validateSimpleText(value);
                                },
                              ),
                            ),

                            SizedBox(
                                width: responsive.isMobile
                                    ? (constraints.maxWidth - 64)
                                    : (constraints.maxWidth - 64) / 2,
                                child: DropdownDateTimePicker(
                                  labelText: 'Date de début',
                                  onDateTimeChanged: (selectedDate) {
                                    Future.microtask(() => controller
                                        .selectStartDateTime(selectedDate));
                                  },
                                )),
                            SizedBox(
                                width: responsive.isMobile
                                    ? (constraints.maxWidth - 64)
                                    : (constraints.maxWidth - 64) / 2,
                                child: DropdownDateTimePicker(
                                  labelText: 'Date de fin',
                                  onDateTimeChanged: (selectedDate) {
                                    Future.microtask(() => controller
                                        .selectEndDateTime(selectedDate));
                                  },
                                )),
                            SizedBox(
                              width: (constraints.maxWidth - 64),
                              child: CustomTextFormField(
                                controller: controller.descriptionController,
                                labelText:
                                    "${LocaleKeys.description.tr} ( optionel )",
                                hintText: LocaleKeys.enter_description.tr,
                                maxLines: 4,
                                errorMessage: controller.descriptionError,
                                onChanged: (value) {},
                              ),
                            ),

                            SizedBox(
                              width: (constraints.maxWidth - 64),
                              child: Obx(
                                () => ImagePickerBox(
                                  title: LocaleKeys.add_logo.tr,
                                  selectedFiles:
                                      controller.voteLogo.value != null
                                          ? [controller.voteLogo.value!]
                                          : [],
                                  existingFiles: [
                                    if (controller.existingLogoFiles.value !=
                                        null)
                                      controller.existingLogoFiles.value!
                                  ],
                                  onFilesSelected: (files) =>
                                      controller.setVoteLogo(files.isNotEmpty
                                          ? files.first
                                          : null),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: (constraints.maxWidth - 64),
                              height: 15.0,
                            ),
                            SizedBox(
                              width: responsive.isMobile
                                  ? (constraints.maxWidth - 64)
                                  : (constraints.maxWidth - 64) / 2,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: CustomButton.outlineButton(
                                  onPressed: () {
                                    Get.offNamed(AppPages.DASHBOARD);
                                  },
                                  buttonTitle: LocaleKeys.buttons_cancel.tr,
                                  fontSize: 14,
                                  forgroundColor: AppColors.cancel,
                                  borderColor: AppColors.cancel,
                                  mainAxisSize: MainAxisSize.max,
                                  elevation: 0.0,
                                  borderRadius: 6.0,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 0.0, vertical: 14.0),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: responsive.isMobile
                                  ? (constraints.maxWidth - 64)
                                  : (constraints.maxWidth - 64) / 2,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: CustomButton.primaryButton(
                                  onPressed: () {
                                    controller.saveVoteData();
                                  },
                                  buttonTitle: controller.isEditMode.value
                                      ? LocaleKeys.buttons_update.tr
                                      : LocaleKeys.buttons_save.tr,
                                  fontSize: 14,
                                  mainAxisSize: MainAxisSize.max,
                                  elevation: 0.0,
                                  borderRadius: 6.0,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 0.0, vertical: 14.0),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

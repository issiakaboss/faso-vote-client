import 'package:faso_vote_client/app/data/models/candidat.dart';
import 'package:faso_vote_client/app/modules/admin/Candidats/controllers/candidats_controller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../../generated/locales.g.dart';
import '../../../../themes/app_text_styles.dart';
import '../../../../utils/helpers/responsive_helper.dart';
import '../../../../utils/validators/form_validator.dart';
import '../../../../widgets/custom_button.dart';
import '../../../../widgets/custom_text.dart';
import '../../../../widgets/custom_text_form_field.dart';
import '../../../../widgets/image_picker_box.dart';

class AddingCandidatView extends GetView<CandidatsController> {
  int voteId;
  Candidat? candidat;
  AddingCandidatView({super.key, required this.voteId, this.candidat}) {
    controller.voteId.value = voteId;
    if (candidat != null) {
      controller.initForEdit(candidat!);
    } else {
      controller.isEditMode.value = false;
      controller.resetCandidateForm();
    }
  }
  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveHelper(context);
    return Container(
      height: context.height,
      width: responsive.isMobile ? context.width : context.width / 1.5,
      decoration: BoxDecoration(color: Get.theme.scaffoldBackgroundColor),
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 28.0, horizontal: 14.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextButton.icon(
                  onPressed: () {
                    controller.closeAndDrawer();
                  },
                  icon: const Icon(Icons.close),
                  label: Text(LocaleKeys.buttons_close.tr),
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: CustomText(
                    text: controller.isEditMode.value
                        ? "Modification d'un candidat"
                        : "Ajouter un nouveau candidat",
                    style: AppTextStyles.heading3(),
                  ),
                ),
                CustomButton.primaryButton(
                  elevation: 0.0,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 14.0),
                  onPressed: () {
                    controller.saveCandidatsData(voteId: voteId);
                  },
                  buttonTitle:
                      controller.isEditMode.value ? "Modifier" : "Soumettre",
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: SingleChildScrollView(
              child: _buildAddCandidateForm(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddCandidateForm() {
    final formData = controller.form;
    final formKey = formData.formKey;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                LayoutBuilder(builder: (context, constraints) {
                  return Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    alignment: WrapAlignment.center,
                    runSpacing: 16,
                    spacing: 16,
                    children: [
                      SizedBox(
                        width: (constraints.maxWidth - 64) / 1.4,
                        child: Column(
                          children: [
                            CustomTextFormField(
                              controller: formData.fullNameController,
                              labelText: "Nom et Prenom",
                              hintText: "Ex: Jean Marc",
                              errorMessage: formData.fullNameError,
                              validator: (p0) {
                                final error =
                                    FormValidator.validateSimpleText(p0);
                                Future.microtask(
                                    () => formData.fullNameError.value = error);
                                return error;
                              },
                              onChanged: (value) {
                                Future.microtask(() => formData
                                        .fullNameError.value =
                                    FormValidator.validateSimpleText(value));
                              },
                            ),
                            const SizedBox(height: 16),
                            CustomTextFormField(
                              controller: formData.etablissementController,
                              labelText: "Université",
                              hintText: "Ex: Nober Zongo",
                              errorMessage: formData.etablissementError,
                              validator: (p0) {
                                final error =
                                    FormValidator.validateSimpleText(p0);
                                Future.microtask(() =>
                                    formData.etablissementError.value = error);
                                return error;
                              },
                              onChanged: (value) {
                                Future.microtask(() => formData
                                        .etablissementError.value =
                                    FormValidator.validateSimpleText(value));
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: (constraints.maxWidth - 64) / 3,
                        child: Obx(
                          () => ImagePickerBox(
                              title: "Photo de profile",
                              selectedFiles:
                                  formData.candidatPhoto.value != null
                                      ? [formData.candidatPhoto.value!]
                                      : [],
                              existingFiles: [
                                if (formData.existingCandidatPhoto.value !=
                                    null)
                                  formData.existingCandidatPhoto.value!
                              ],
                              onFilesSelected: (files) => formData.setHotelLogo(
                                  files.isNotEmpty ? files.first : null)),
                        ),
                      ),
                      SizedBox(
                        width: (constraints.maxWidth - 20),
                        child: CustomTextFormField(
                          controller: formData.themeController,
                          maxLines: 3,
                          labelText: "Theme",
                          hintText: "Ex: ......",
                          errorMessage: formData.themeError,
                          validator: (p0) {
                            final error = FormValidator.validateSimpleText(p0);
                            Future.microtask(
                                () => formData.themeError.value = error);
                            return error;
                          },
                          onChanged: (value) {
                            Future.microtask(() => formData.themeError.value =
                                FormValidator.validateSimpleText(value));
                          },
                        ),
                      ),
                    ],
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:faso_vote_client/app/modules/admin/Candidats/controllers/candidats_controller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../themes/app_text_styles.dart';
import '../../../../widgets/custom_button.dart';
import '../../../../widgets/custom_text.dart';
import '../../../../widgets/custom_text_form_field.dart';
import '../../../../widgets/image_picker_box.dart';

class AddingCandidatView extends GetView<CandidatsController> {
  const AddingCandidatView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AddingCandidatView'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          _buildAddCandidateForm(),
        ],
      ),
    );
  }

  Widget _buildAddCandidateForm() {
    return SizedBox(
      width: Get.width / 2,
      child: Card(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomText(
                    text: "Ajouter un nouveau candidat",
                    style: AppTextStyles.heading2(),
                  ),
                  CustomButton.primaryButton(
                    onPressed: () {},
                    mainAxisSize: MainAxisSize.max,
                    buttonTitle: "Ajouter",
                  ),
                ],
              ),
              const SizedBox(height: 20),
              LayoutBuilder(builder: (context, constraints) {
                return Form(
                  // key: controller.voteDataFormkey,
                  child: Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    alignment: WrapAlignment.center,
                    runSpacing: 16,
                    spacing: 16,
                    children: [
                      SizedBox(
                        width: (constraints.maxWidth - 64) / 1.4,
                        child: Column(
                          children: [
                            // Nom et Prénom
                            CustomTextFormField(
                              controller: controller.fullNameController,
                              labelText: "Nom et Prenom",
                              hintText: "Ex: Jean Marc",
                              errorMessage: RxnString(),
                            ),
                            const SizedBox(height: 16),

                            // etablissement
                            CustomTextFormField(
                              controller: controller.etablissementController,
                              labelText: "Etablissément",
                              hintText: "Ex: Nober Zongo",
                              errorMessage: RxnString(),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: (constraints.maxWidth - 64) / 3,
                        child: ImagePickerBox(
                          title: "Photo de profile",
                          selectedFiles: controller.candidatPhoto.value != null
                              ? [controller.candidatPhoto.value!]
                              : [],
                          onFilesSelected: (files) => controller
                              .setPhoto(files.isNotEmpty ? files.first : null),
                        ),
                      ),
                      SizedBox(
                        width: (constraints.maxWidth - 20),
                        child: CustomTextFormField(
                          controller: controller.etablissementController,
                          maxLines: 3,
                          labelText: "Theme",
                          hintText: "Ex: ......",
                          errorMessage: RxnString(),
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}

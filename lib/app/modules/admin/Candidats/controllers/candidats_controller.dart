import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';

import '../../../../data/models/candidat.dart';
import '../../../../utils/helpers/form_helper.dart';

class CandidatsController extends GetxController {
  RxList<Candidat> candidates = RxList([]);
  final fullNameController = FormHelper.getController();
  final etablissementController = FormHelper.getController();
  final themeController = FormHelper.getController();
  Rx<PlatformFile?> candidatPhoto = Rx<PlatformFile?>(null);
  final RxBool isEditMode = false.obs;
  final RxnInt candidatId = RxnInt(null);
  @override
  void onInit() {
    super.onInit();
    if (candidates.isEmpty) {
      loadFakeCandidates();
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void setPhoto(PlatformFile? file) {
    candidatPhoto.value = file;
  }

  void loadFakeCandidates() {
    candidates.value = [
      Candidat(
        id: 1,
        fullName: 'Issiaka Ouédraogo',
        etablissement: 'Université Joseph Ki-Zerbo',
        theme:
            'Conception et développement d’une application mobile multiplateforme de gestion logistique des livraisons express avec système de suivi en temps réel pour les PME de Ouagadougou',
        photoUrl: 'https://randomuser.me/api/portraits/men/1.jpg',
      ),
      Candidat(
        id: 2,
        fullName: 'Fatoumata Traoré',
        etablissement: 'ISIG',
        theme:
            'Analyse prédictive des rendements agricoles à l’aide du machine learning et des données satellitaires dans un contexte sahélien de changement climatique',
        photoUrl: 'https://randomuser.me/api/portraits/women/2.jpg',
      ),
      Candidat(
        id: 3,
        fullName: 'Souleymane Kaboré',
        etablissement: 'ESATIC',
        theme:
            'Mise en place d’un système de traçabilité des produits pharmaceutiques basé sur la technologie Blockchain pour lutter contre la contrefaçon au Burkina Faso',
        photoUrl: 'https://randomuser.me/api/portraits/men/3.jpg',
      ),
      Candidat(
        id: 4,
        fullName: 'Aïssata Konaté',
        etablissement: 'Université de Bobo',
        theme:
            'Développement d’un système d’alerte précoce basé sur les données météorologiques et hydrologiques pour prévenir les inondations dans les zones urbaines vulnérables du Burkina Faso',
        photoUrl: 'https://randomuser.me/api/portraits/women/4.jpg',
      ),
    ];
  }
}

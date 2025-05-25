import 'package:faso_vote_client/app/data/models/candidate.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  var selectedTab = 0.obs;

  final candidates = <Candidat>[
    Candidat(
      id: 1,
      fullName: 'Dr Madou KAKOU',
      etablissement: 'Université Félix Houphouët-Boigny d’Abidjan',
      theme:
          'Étude de la catalyse hétérogène dans la synthèse verte de composés organiques',
      photoUrl: 'https://randomuser.me/api/portraits/men/1.jpg',
    ),
    Candidat(
      id: 2,
      fullName: 'Mme Aïcha KONÉ',
      etablissement: 'Université Nangui Abrogoua',
      theme:
          'Impact des biofertilisants sur la croissance du maïs en zone tropicale',
      photoUrl: 'https://randomuser.me/api/portraits/women/2.jpg',
    ),
    Candidat(
      id: 3,
      fullName: 'Dr Issa TRAORÉ',
      etablissement: 'INP-HB (Institut National Polytechnique)',
      theme:
          'Modélisation numérique des propriétés thermiques des matériaux composites',
      photoUrl: 'https://randomuser.me/api/portraits/men/3.jpg',
    ),
  ].obs;
}

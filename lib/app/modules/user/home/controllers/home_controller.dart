import 'package:faso_vote_client/app/data/models/candidate.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  var selectedTab = 0.obs;

  final candidates = <Candidate>[
    Candidate(
      name: 'Dr Madou KAKOU',
      title: 'Docteur en chimie',
      image: 'https://randomuser.me/api/portraits/men/1.jpg',
    ),
    Candidate(
      name: 'Mme Aïcha KONÉ',
      title: 'Professeure en biologie',
      image: 'https://randomuser.me/api/portraits/women/2.jpg',
    ),
    Candidate(
      name: 'Dr Issa TRAORÉ',
      title: 'Chercheur en physique',
      image: 'https://randomuser.me/api/portraits/men/3.jpg',
    ),
  ].obs;
}

import 'package:get/get.dart';

class HomeController extends GetxController {
  var selectedTab = 0.obs;

  final candidates = [
    {
      'name': 'Dr Madou KAKOU',
      'title': 'Docteur en chimie',
      'image': 'https://randomuser.me/api/portraits/men/1.jpg',
    },
    {
      'name': 'Mme Aïcha KONÉ',
      'title': 'Professeure en biologie',
      'image': 'https://randomuser.me/api/portraits/women/2.jpg',
    },
    {
      'name': 'Dr Issa TRAORÉ',
      'title': 'Chercheur en physique',
      'image': 'https://randomuser.me/api/portraits/men/3.jpg',
    },
    {
      'name': 'Mme Mariam TOURE',
      'title': 'Spécialiste',
      'image': 'https://randomuser.me/api/portraits/women/4.jpg',
    },
  ].obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}

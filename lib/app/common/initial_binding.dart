
import 'package:faso_vote_client/app/modules/admin/dashboard/controllers/dashboard_controller.dart';
import 'package:faso_vote_client/app/modules/home/controllers/home_controller.dart';
import 'package:get/get.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController(), fenix: true);
    Get.lazyPut<DashboardController>(() => DashboardController(), fenix: true);
  }
}
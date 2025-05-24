import 'package:get/get.dart';

import '../modules/SplashScreen/bindings/splash_screen_binding.dart';
import '../modules/SplashScreen/views/splash_screen_view.dart';
import '../modules/admin/AddingVote/bindings/adding_vote_binding.dart';
import '../modules/admin/AddingVote/views/adding_vote_view.dart';
import '../modules/admin/dashboard/bindings/dashboard_binding.dart';
import '../modules/admin/dashboard/views/dashboard_view.dart';
import '../modules/user/otppage/bindings/otppage_binding.dart';
import '../modules/user/otppage/views/otppage_view.dart';
import '../modules/user/canalvote/bindings/canalvote_binding.dart';
import '../modules/user/canalvote/views/canalvote_view.dart';
import '../modules/user/home/bindings/home_binding.dart';
import '../modules/user/home/views/home_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.home;
  static const splashscreen = Routes.splashscreen;
  static const DASHBOARD = Routes.DASHBOARD;
  static const ADDING_VOTE = Routes.ADDING_VOTE;

  static final routes = [
    GetPage(
      name: _Paths.home,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.splashscreen,
      page: () => const SplashScreenView(),
      binding: SplashScreenBinding(),
    ),
    GetPage(
      name: _Paths.DASHBOARD,
      page: () => const DashboardView(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: _Paths.ADDING_VOTE,
      page: () => const AddingVoteView(),
      binding: AddingVoteBinding(),
    ),
    GetPage(
      name: _Paths.CANAL_VOTE,
      page: () => const CanalvoteView(),
      binding: CanalvoteBinding(),
    ),
    GetPage(
      name: _Paths.OTPPAGE,
      page: () => const OtppageView(),
      binding: OtppageBinding(),
    ),
  ];
}

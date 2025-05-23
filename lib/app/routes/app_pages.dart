import 'package:get/get.dart';

import '../modules/SplashScreen/bindings/splash_screen_binding.dart';
import '../modules/SplashScreen/views/splash_screen_view.dart';
import '../modules/admin/AddingVote/bindings/adding_vote_binding.dart';
import '../modules/admin/AddingVote/views/adding_vote_view.dart';
import '../modules/admin/Candidats/bindings/candidats_binding.dart';
import '../modules/admin/Candidats/views/candidats_view.dart';
import '../modules/admin/dashboard/bindings/dashboard_binding.dart';
import '../modules/admin/dashboard/views/dashboard_view.dart';
import '../modules/admin/results/bindings/results_binding.dart';
import '../modules/admin/results/views/results_view.dart';
import '../modules/admin/voteDetail/bindings/vote_detail_binding.dart';
import '../modules/admin/voteDetail/views/vote_detail_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.home;
  static const splashscreen = Routes.splashscreen;
  static const DASHBOARD = Routes.DASHBOARD;
  static const ADDING_VOTE = Routes.ADDING_VOTE;
  static const CANDIDATS = Routes.CANDIDATS;
  static const RESULTS = Routes.RESULTS;
  static const VOTE_DETAIL = Routes.VOTE_DETAIL;

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
      name: _Paths.CANDIDATS,
      page: () => CandidatsView(),
      binding: CandidatsBinding(),
    ),
    GetPage(
      name: _Paths.VOTE_DETAIL,
      page: () =>  VoteDetailView(),
      binding: VoteDetailBinding(),
    ),
    GetPage(
      name: _Paths.RESULTS,
      page: () => const ResultsView(),
      binding: ResultsBinding(),
    ),
  ];
}

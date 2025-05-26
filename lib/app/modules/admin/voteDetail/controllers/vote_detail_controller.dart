import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Candidats/views/adding_candidat_view.dart';

class VoteDetailController extends GetxController {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  Rx<Widget> currentEndDrawer = Rx(Container());
//  AddingCandidatView(voteId: selectedVote?.id ?? 0)
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

  Future<void> updateEnddraw(Widget newEndDrawer) async {
    currentEndDrawer.value = newEndDrawer;
  }

  void displayAddCandidatView({required int voteId}) {
    updateEnddraw(AddingCandidatView(voteId: voteId));
    scaffoldKey.currentState!.openEndDrawer();
  }

  void closeAddCandidatView() {
    scaffoldKey.currentState!.closeEndDrawer();
  }
}

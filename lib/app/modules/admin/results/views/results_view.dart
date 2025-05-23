import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/results_controller.dart';

class ResultsView extends GetView<ResultsController> {
  const ResultsView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ResultsView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'ResultsView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}

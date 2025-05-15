import 'package:faso_vote_client/app/utils/constants/gradientcolor.dart';
import 'package:faso_vote_client/app/widgets/animated_dotted_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/splash_screen_controller.dart';

class SplashScreenView extends StatelessWidget {
  const SplashScreenView({super.key});
  @override
  Widget build(BuildContext context) {
    var w = Get.width;
    var h = Get.height;
    return GetBuilder<SplashScreenController>(
        init: SplashScreenController(),
        builder: (context) {
          return Scaffold(
            body: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                color: Colors.red,
                gradient: GradientColor.gradient(
                  const Color.fromARGB(255, 30, 39, 97),
                  const Color.fromARGB(255, 122, 32, 72),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [],
                    ),
                    clipBehavior: Clip.antiAlias,
                    width: w / 4,
                    height: h / 8,
                    child: Image.asset("images/votelogo.png"),
                  ),
                  const Column(
                    children: [
                      Text(
                        // 'Fast-Vote',
                        "Test Vote du public",
                        style: TextStyle(
                            fontSize: 34,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Une transparante total',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const AnimatedDottedProgressBar(
                    totalDots: 8,
                    dotSize: 8,
                    spacing: 6,
                    speed: Duration(milliseconds: 120),
                  ),
                ],
              ),
            ),
          );
        });
  }
}

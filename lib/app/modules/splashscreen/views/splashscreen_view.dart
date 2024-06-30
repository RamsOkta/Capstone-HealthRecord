import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:healthrecord/app/modules/dashboard/views/dashboard_view.dart';
import 'package:healthrecord/app/modules/onboarding/views/onboarding_view.dart';
import 'package:healthrecord/app/modules/splashscreen/controllers/splashscreen_controller.dart';
import 'package:page_transition/page_transition.dart';

class SplashscreenView extends GetView<SplashscreenController> {
  const SplashscreenView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 3), () async {
      User? user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        Get.offNamed('/onboarding');
        (
          context,
          PageTransition(
            child: OnboardingView(),
            type: PageTransitionType.fade,
            duration: const Duration(seconds: 2),
          ),
        );
      } else {
        Get.offNamed('/dashboard');
        (
          context,
          PageTransition(
            child: DashboardView(),
            type: PageTransitionType.fade,
            duration: const Duration(seconds: 2),
          ),
        );
      }
    });

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              "assets/images/image.png",
              fit: BoxFit.fill,
            ),
          ),
          Center(
            child: Image.asset("assets/images/Logo.png"),
          )
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:page_transition/page_transition.dart';
import '../controllers/onboarding_controller.dart';
import 'package:healthrecord/app/modules/masuk/views/masuk_view.dart';

class OnboardingView extends GetView<OnboardingController> {
  OnboardingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Responsive
    double screenWidth = MediaQuery.of(context).size.width;

    return WillPopScope(
      onWillPop: controller.onWillPop,
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Image.asset("assets/images/Logo.png"),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Container(
                    width: screenWidth,
                    height: 145.w,
                    decoration: BoxDecoration(
                      color: const Color(0xff01CBEF),
                      borderRadius: BorderRadius.circular(10.w),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "HEALTH RECORD",
                          style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10.h),
                        Text(
                          "Selamat Datang di Health Record\nPermudah Pendataan pasien\nTingkatkan Pelayanan",
                          style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 80.h, bottom: 20.h),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        PageTransition(
                          child: const MasukView(),
                          type: PageTransitionType.fade,
                          duration: const Duration(milliseconds: 400),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff01CBEF),
                    ),
                    child: Text(
                      "Masuk",
                      style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

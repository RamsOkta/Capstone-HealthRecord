import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:healthrecord/app/modules/masuk/views/masuk_view.dart';
import 'package:page_transition/page_transition.dart';
import '../controllers/lupapassword_controller.dart';

class LupapasswordView extends GetView<LupapasswordController> {
  const LupapasswordView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    double screenWidth = mediaQuery.size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding:
              const EdgeInsets.only(top: 60, left: 20, right: 20, bottom: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    PageTransition(
                      child: const MasukView(),
                      type: PageTransitionType.fade,
                      duration: const Duration(milliseconds: 400),
                    ),
                  );
                },
                child: Icon(
                  Icons.arrow_back_rounded,
                  size: 25.sp,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 15.h),
              Center(
                child: Text(
                  "Lupa Password",
                  style: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 30.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ),
              SizedBox(height: 40.h),
              Text(
                "Masukan email anda untuk ubah password",
                style: TextStyle(
                    fontFamily: "Poppins",
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.black),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 48.h),
              TextField(
                controller: controller.emailController,
                style: const TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  labelText: "Email",
                  labelStyle: TextStyle(
                    fontFamily: "Poppins",
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 2),
                  ),
                  enabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 2),
                  ),
                ),
              ),
              SizedBox(height: 40.h),
              SizedBox(
                width: screenWidth,
                height: 51.w,
                child: ElevatedButton(
                  onPressed: () =>
                      controller.resetPassword(controller.emailController.text),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff01CBEF),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    "Kirim",
                    style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

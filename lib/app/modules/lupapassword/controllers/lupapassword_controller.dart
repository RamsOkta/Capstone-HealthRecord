import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LupapasswordController extends GetxController {
  TextEditingController emailController = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;

  void resetPassword(String email) async {
    final String email = emailController.text.trim();
    if (email.isEmpty) {
      Get.snackbar("Error", "Masukan email anda");
      return;
    }
    try {
      await auth.sendPasswordResetEmail(email: email);
      Get.snackbar('Success', 'Password reset email has been sent.');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Get.snackbar('Error', 'No user found for that email.');
      } else {
        Get.snackbar('Error', 'Failed to send password reset email.');
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred. Please try again.');
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    super.onClose();
  }
}

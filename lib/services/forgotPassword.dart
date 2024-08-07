// ignore_for_file: file_names, unused_element, unused_import, avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:od_pro/views/loginScreen.dart';
import 'package:get/get.dart';
import 'package:od_pro/widgets/custom_loading_dialog.dart';


final FirebaseAuth _firebaseAuthLogin = FirebaseAuth.instance;

resetPassword(
    BuildContext context,
    TextEditingController forgortEmailController,
    ) async {
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
    return const CustomLoadingDialog(message: "Please Wait..");

      });

  try {
    await FirebaseAuth.instance
        .sendPasswordResetEmail(email: forgortEmailController.text.trim())
        .then((value) {
      print("Please check your email address!");
      Get.to(() => const LoginScreen());
      forgortEmailController.clear();
    });
  } catch (e) {
    print("Please check your email address!");
    Navigator.pop(context);
  }
}
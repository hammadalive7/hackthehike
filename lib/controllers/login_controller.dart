import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hackthehike/bottom_navigation.dart';
import 'package:hackthehike/controllers/session_controller.dart';

class LoginController extends GetxController {
  static LoginController get instance => Get.find();

  // TextField Controllers to get data from TextFields
  var isSigningIn = false.obs;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // TextField Validation

  //Call this Function from Design & it will do the rest
  void loginUser(String email, String password) async {
    FirebaseAuth auth = FirebaseAuth.instance;

    // user authentication
    try {
      await auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) {
        SessionController().userid = value.user!.uid
            .toString(); // this Session will store current user ID that will be useful for showing current user profile info

        Get.offAll(() => const BottomNavigationScreen(title: "Home"));
        isSigningIn.value = false;
        Get.snackbar("Success", "Login Successfully",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.green,
            colorText: Colors.white);
      }).onError((error, stackTrace) {
        if (error == null) {
          isSigningIn.value = false;

          Get.snackbar("Error", "Please Enter Email & Password",
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.red,
              colorText: Colors.white);
        } else if (error.toString().contains("user-not-found")) {
          isSigningIn.value = false;

          Get.snackbar("Error", "User Not Found",
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.red,
              colorText: Colors.white);
        } else if (error.toString().contains("wrong-password")) {
          isSigningIn.value = false;

          Get.snackbar("Error", "Wrong Password",
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.red,
              colorText: Colors.white);
        } else if (error.toString().contains("invalid-email")) {
          isSigningIn.value = false;

          Get.snackbar("Error", "Invalid Email",
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.red,
              colorText: Colors.white);
        } else if (error.toString().contains("network-request-failed")) {
          isSigningIn.value = false;

          Get.snackbar("Error", "Network Error",
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.red,
              colorText: Colors.white);
        } else if (error.toString().contains("too-many-requests")) {
          isSigningIn.value = false;

          Get.snackbar("Error", "Too Many Requests",
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.red,
              colorText: Colors.white);
        } else if (error.toString().contains("user-disabled")) {
          isSigningIn.value = false;

          Get.snackbar("Error", "User Disabled",
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.red,
              colorText: Colors.white);
        } else if (error.toString().contains("operation-not-allowed")) {
          isSigningIn.value = false;

          Get.snackbar("Error", "Operation Not Allowed",
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.red,
              colorText: Colors.white);
        } else if (error.toString().contains("invalid-credential")) {
          isSigningIn.value = false;

          Get.snackbar("Error", "Invalid Credential",
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.red,
              colorText: Colors.white);
        } else if (error
            .toString()
            .contains("account-exists-with-different-credential")) {
          Get.snackbar("Error", "Account Exists With Different Credential",
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.red,
              colorText: Colors.white);
        } else if (error.toString().contains("requires-recent-login")) {
          isSigningIn.value = false;

          Get.snackbar("Error", "Requires Recent Login",
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.red,
              colorText: Colors.white);
        } else if (error.toString().contains("email-already-in-use")) {
          isSigningIn.value = false;

          Get.snackbar("Error", "Email Already In Use",
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.red,
              colorText: Colors.white);
        } else if (error.toString().contains("weak-password")) {
          isSigningIn.value = false;

          Get.snackbar("Error", "Password Should Be At Least 6 Characters",
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.red,
              colorText: Colors.white);
        } else if (error.toString().contains("invalid-email")) {
          isSigningIn.value = false;

          Get.snackbar("Error", "Invalid Email",
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.red,
              colorText: Colors.white);
        } else if (error.toString().contains("user-not-found")) {
          isSigningIn.value = false;

          Get.snackbar("Error", "User Not Found",
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.red,
              colorText: Colors.white);
        } else if (error.toString().contains("wrong-password")) {
          isSigningIn.value = false;

          Get.snackbar("Error", "Wrong Password",
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.red,
              colorText: Colors.white);
        } else if (error.toString().contains("network-request-failed")) {
          isSigningIn.value = false;

          Get.snackbar("Error", "Network Error",
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.red,
              colorText: Colors.white);
        }
      });
    } catch (error) {
      isSigningIn.value = false;
      Get.snackbar("Error", error.toString(),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    }
  }
}

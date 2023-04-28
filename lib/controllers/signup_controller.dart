import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hackthehike/Screens/qr_code_screen.dart';
import 'package:hackthehike/bottom_navigation.dart';
import 'package:hackthehike/controllers/session_controller.dart';


// SignUpController is used to store user data will he signup and alse create User Email And Password Authentication for login

class SignUpController extends GetxController {
  static SignUpController get instance => Get.find();
  var isSigningUp = false.obs;

  //TextField Controllers to get data from TextFields
  final email = TextEditingController();
  final password = TextEditingController();
  final fullName = TextEditingController();
  final phoneNo = TextEditingController();
  final university = TextEditingController();
  final teamid = TextEditingController();

  DatabaseReference ref = FirebaseDatabase.instance.ref('users');

  // final userRepo = Get.put(UserRepository());

  void signUp(String username, String email, String password, String phone, String university, String teamid) async {
    FirebaseAuth auth = FirebaseAuth.instance;

    UserCredential? userCredential;
    try {
      userCredential = await auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) {
        SessionController().userid = value.user!.uid.toString();
        ref.child(value.user!.uid.toString()).set({
          'email': value.user!.email.toString(),
          // 'password': password,
          'userName': username,
          'phone': phone,
          "university": university,
          "teamid": teamid,
        });

        Get.offAll(() => const BottomNavigationScreen(title: "Home"));
        Get.snackbar("Success", "Sign Up Successfully", snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.green, colorText: Colors.white);
      }).onError((error, stackTrace) {
        isSigningUp.value = false;

        if (error.toString().contains("email-already-in-use")) {
          isSigningUp.value = false;

          Get.snackbar("Error", "Email Already In Use", snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red, colorText: Colors.white);
        } else if (error.toString().contains("weak-password")) {
          isSigningUp.value = false;

          Get.snackbar("Error", "Password Should Be At Least 6 Characters", snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red, colorText: Colors.white);
        } else if (error.toString().contains("invalid-email")) {
          isSigningUp.value = false;

          Get.snackbar("Error", "Invalid Email", snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red, colorText: Colors.white);
        } else if (error.toString().contains("network-request-failed")) {
          isSigningUp.value = false;

          Get.snackbar("Error", "Check Your Internet Connection", snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red, colorText: Colors.white);
        } else {
          isSigningUp.value = false;

          Get.snackbar("Error", error.toString(), snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red, colorText: Colors.white);
        }
      });
    } catch (error) {
      isSigningUp.value = false;

      Get.snackbar("Error", error.toString(), snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red, colorText: Colors.white);
      debugPrint(error.toString());
    }
  }
}

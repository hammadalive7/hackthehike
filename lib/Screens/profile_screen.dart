import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:hackthehike/Screens/profile_screen_form.dart';

import '../Admin/admin_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndTop,

      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        //position of button

        onPressed: () {
          Get.to(() => AdminPanel());
        },
        child: const Icon(Icons.admin_panel_settings_outlined),
      ),
      // floatingActionButton:FloatingActionButton(
      //   foregroundColor: Colors.white,
      //   shape: const StadiumBorder(
      //       side: BorderSide(
      //           color: Colors.white24, width: 4)),
      //   onPressed: () { FirebaseAuth auth = FirebaseAuth.instance;
      //
      //   auth.signOut().then((value){
      //     SessionController().userid = '';
      //     Get.offAll(() => const LoginScreen());
      //   });},
      //   child: const Icon(Icons.logout_outlined),
      // ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerTop,

      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              ProfileFormWidget(),
            ],
          ),
        ),
      ),
    );
  }
}

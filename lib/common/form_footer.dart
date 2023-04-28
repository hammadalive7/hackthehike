import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hackthehike/Screens/signup_screen.dart';

import '../Screens/login_screen.dart';

// import '../Features/Login/login_screen.dart';

class FooterWidget extends StatelessWidget {
  final String Texts, Title;
  const FooterWidget({
    Key? key,
    required this.Texts,
    required this.Title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 20),
          TextButton(
            style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: const BorderSide(color: Colors.transparent)))),
            onPressed: () {
              if (Title == "Login") {
                Get.off(() => const LoginScreen());
              } else {
                Get.to(() => const SignupScreen());
              }
            },
            child: Text.rich(
              TextSpan(
                  text: Texts,
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w400),
                  children: [
                    TextSpan(
                        text: Title,
                        style: const TextStyle(color: Colors.green))
                  ]),
            ),
          ),
        ],
      ),
    );
  }
}

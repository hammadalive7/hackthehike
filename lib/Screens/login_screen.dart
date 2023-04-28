import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hackthehike/controllers/login_controller.dart';

import '../common/form_footer.dart';
import '../common/transparent_appBar.dart';
import '../controllers/signup_controller.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isObscure = true;
  final controller = Get.put(LoginController());
  bool isChecked = false;
  bool newsletterSubscription = false;
  bool letterChecked = false;
  final height = Get.height;
  final width = Get.width;
  @override
  Widget build(BuildContext context) {
    final _formkey = GlobalKey<FormState>();

    return Scaffold(
      appBar: transparentAppBar(context),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: Get.height * 0.1),
                const Text("LOGIN",
                    style: TextStyle(
                      fontSize: 30,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w600,
                      fontStyle: FontStyle.normal,
                      color: Color(0xff000000),
                    )),
                const SizedBox(height: 10),
                const Text("Welcome back, login to your account",
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal,
                      color: Color(0xff000000),
                    )),
                Container(
                  padding: EdgeInsets.only(top: height * 0.04),
                  child: Form(
                    key: _formkey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFormField(
                          controller: controller.emailController,
                          validator: (value) {
                            bool _isEmailValid = RegExp(
                                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                .hasMatch(value!);
                            if (!_isEmailValid) {
                              return 'Invalid email.';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.email_outlined),
                            labelText: "Email",
                            hintText: "Email",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12)),
                          ),
                        ),
                        SizedBox(height: height * 0.02),
                        TextFormField(
                          controller: controller.passwordController,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'This field is required';
                            }
                            if (value.trim().length < 6) {
                              return 'Password must be valid';
                            }
                            // Return null if the entered username is valid
                            return null;
                          },
                          obscureText: _isObscure,
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                                icon: Icon(_isObscure
                                    ? Icons.visibility_off
                                    : Icons.visibility),
                                onPressed: () {
                                  setState(() {
                                    _isObscure = !_isObscure;
                                  });
                                }),
                            prefixIcon: const Icon(Icons.fingerprint),
                            labelText: "Password",
                            hintText: "Password",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12)),
                          ),
                        ),
                        SizedBox(height: height * 0.04),
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child:

                              //SIGN UP BUTTON THAT WILL SHOW A DIALOG BOX FOR USER  FIRST TO AGREE UPON TERMS AND CONDITIONS, THEN WILL REGISTER

                              ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12))),
                            onPressed: () {
                              controller.isSigningIn.value = true;
                              if (_formkey.currentState!.validate()) {
                                controller.loginUser(
                                  controller.emailController.text,
                                  controller.passwordController.text,
                                );
                              }
                              else{
                                controller.isSigningIn.value = false;
                              }
                            },
                            child: Obx(() {
                             if (controller.isSigningIn.isTrue) {
                                  return const CircularProgressIndicator(
                                    color: Colors.white,
                                  );
                                } else {
                                  return  Text("Login".toUpperCase(),
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16,
                                      ));
                                }
                            }) ,
                            // child: Text("Login".toUpperCase(),style: const TextStyle(
                            //   fontWeight: FontWeight.w600,
                            //   fontSize: 16,
                            // ),),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const FooterWidget(
                    Texts: "Don't have a Account ", Title: "Sign up")
              ],
            ),
          ),
        ),
      ),
    );
  }
}

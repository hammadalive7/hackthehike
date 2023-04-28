import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../common/form_footer.dart';
import '../common/transparent_appBar.dart';
import '../controllers/signup_controller.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final controller = Get.put(SignUpController());
  bool isChecked = false;
  bool newsletterSubscription = false;
  bool letterChecked = false;
 final  height = Get.height;
 final width = Get.width;
  @override
  Widget build(BuildContext context) {
    final _formkey = GlobalKey<FormState>();

    return Scaffold(
      appBar: transparentAppBar(context),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
             const Text("SIGN UP",
                  style: TextStyle(
                    fontSize: 30,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w600,
                    fontStyle: FontStyle.normal,
                    color: const Color(0xff000000),
                  )),
              const SizedBox(height: 10),
              const Text("Signup to create your account",
                  style: TextStyle(
                    fontSize: 15,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.normal,
                    color: const Color(0xff000000),
                  )),
              Container(
                padding:  EdgeInsets.only(top: height * 0.04),
                child: Form(
                  key: _formkey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        controller: controller.fullName,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'This field is required';
                          }
                          if (value.trim().length < 2) {
                            return 'Name must be valid';
                          }
                          // Return null if the entered username is valid
                          return null;
                        },
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.person_outline_rounded),
                          labelText: "Full Name",
                          hintText: "Full Name",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15)),
                        ),
                      ),
                       SizedBox(height: height * 0.02),
                      TextFormField(
                        controller: controller.email,
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
                        controller: controller.phoneNo,
                        validator: (value) {
                          bool _isEmailValid =
                              RegExp(r'^(?:[+0][1-9])?[0-9]{8,15}$')
                                  .hasMatch(value!);
                          if (!_isEmailValid) {
                            return 'Invalid phone number';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.phone),
                          labelText: "Phone Number",
                          hintText: "Phone Number",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12)),
                        ),
                      ),
                      SizedBox(height: height * 0.02),
                      TextFormField(
                        controller: controller.teamid,
                        validator: (value) {
                          //validate if name is entered
                          if (value == null || value.trim().isEmpty) {
                            return 'This field is required';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.group),
                          labelText: "Team ID",
                          hintText: "Team ID",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12)),
                        ),
                      ),
                      SizedBox(height: height * 0.02),
                      TextFormField(
                        controller: controller.university,
                        validator: (value) {
                          //validate if name is entered
                          if (value == null || value.trim().isEmpty) {
                            return 'This field is required';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.school),
                          labelText: "University Name",
                          hintText: "University Name",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12)),
                        ),
                      ),
                      SizedBox(height: height * 0.02),
                      TextFormField(
                        controller: controller.password,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'This field is required';
                          }
                          if (value.trim().length < 6) {
                            return 'Password must be at least 6 characters in length';
                          }
                          // Return null if the entered password is valid
                          return null;
                        },
                        decoration: InputDecoration(
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
                            controller.isSigningUp.value = true;
                            if (_formkey.currentState!.validate()) {
                              SignUpController.instance.signUp(
                                controller.fullName.text.trim(),
                                controller.email.text.trim(),
                                controller.password.text.trim(),
                                controller.phoneNo.text.trim(),
                                controller.university.text.trim(),
                                controller.teamid.text.trim(),
                              );
                            }else{
                              controller.isSigningUp.value = false;
                            }
                          },
                          child:   Obx(() {
                            if (controller.isSigningUp.isTrue) {
                              return const CircularProgressIndicator(
                                color: Colors.white,
                              );
                            } else {
                              return  Text("SIGNUP".toUpperCase(),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                  ));
                            }
                          }) ,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
             const FooterWidget(Texts: "Already have Account ", Title: "Login")
            ],
          ),
        ),
      ),
    );
  }
}

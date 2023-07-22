import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hackthehike/Screens/login_screen.dart';
import 'package:hive/hive.dart';
import '../../Controllers/session_controller.dart';
import '../Admin/admin_screen.dart';

class ProfileFormWidget extends StatefulWidget {
  const ProfileFormWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<ProfileFormWidget> createState() => _ProfileFormWidgetState();
}

class _ProfileFormWidgetState extends State<ProfileFormWidget> {
  DatabaseReference ref = FirebaseDatabase.instance.ref('users');

  @override
  Widget build(BuildContext context) {
    final _formkey = GlobalKey<FormState>();
    String userEmail, teamID;
    final user =FirebaseAuth.instance.currentUser;
    final answerbox = Hive.box('answer');

    FirebaseDatabase database = FirebaseDatabase.instance;



    return Padding(
      padding:  EdgeInsets.symmetric(vertical: Get.height * 0.05),
      // this function will get current user data form firebase
      child: StreamBuilder(
          stream: ref.child(user!.uid.toString()).onValue,
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              Map<dynamic, dynamic> map = snapshot.data.snapshot.value ?? {};
              final nameController =
              TextEditingController(text: map['userName']);
              final phoneController =
              TextEditingController(text: map['phone']);
              final teamController = TextEditingController(text: map['teamid']);
              userEmail=map["email"].toString();
              teamID=map["teamid"].toString();


              return Form(
                key: _formkey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("USER INFO",
                        style: TextStyle(
                          fontSize: 30,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w600,
                          fontStyle: FontStyle.normal,
                          color:  Color(0xff000000),
                        )),
                     SizedBox(height: Get.height * 0.05),
                    TextFormField(
                      controller: nameController,
                      // initialValue: map['UserName'],
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'This field is required';
                        }
                        if (value.trim().length < 2) {
                          return 'Name must be valid';
                        }
                        // Return null if the entered username is valid
                        // return null;
                      },

                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.person_outline_rounded),
                        labelText: "Full Name",
                        hintText: "Full Name",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                      ),
                    ),
                     SizedBox(height: Get.height * 0.03),
                    TextFormField(
                      // initialValue: map['Phone'],
                      controller: phoneController,

                      validator: (value) {
                        bool isPhoneValid =
                        RegExp(r'^(?:[+0][1-9])?[0-9]{8,15}$')
                            .hasMatch(value!);
                        if (!isPhoneValid) {
                          return 'Invalid phone number';
                        }
                        // return null;
                      },
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.phone),
                        labelText: "Phone Number",
                        hintText: "Phone Number",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                      ),
                    ),
                    SizedBox(height: Get.height * 0.03),
                    TextFormField(
                      initialValue: map['email'],
                      enableInteractiveSelection: false,
                      focusNode: AlwaysDisabledFocusNode(),
                      validator: (value) {
                        bool _isEmailValid = RegExp(
                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(value!);
                        if (!_isEmailValid) {
                          return 'Invalid email.';
                        }
                        // return null;
                      },
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.email_outlined),
                        labelText: "Email",
                        hintText: "Email",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                      ),
                    ),
                    SizedBox(height: Get.height * 0.03),
                    TextFormField(
                      initialValue: map['teamid'],
                      enableInteractiveSelection: false,
                      focusNode: AlwaysDisabledFocusNode(),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'This field is required';
                        }
                        if (value.trim().length < 2) {
                          return 'Team ID must be valid';
                        }
                        // Return null if the entered username is valid
                        // return null;
                      },
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.email_outlined),
                        labelText: "Team ID",
                        hintText: "Team ID",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                      ),
                    ),
                    SizedBox(height: Get.height * 0.03),
                    TextFormField(
                      initialValue: map['university'],
                      enableInteractiveSelection: false,
                      focusNode: AlwaysDisabledFocusNode(),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'This field is required';
                        }
                        if (value.trim().length < 2) {
                          return 'University Name must be valid';
                        }
                        // Return null if the entered username is valid
                        // return null;
                      },
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.email_outlined),
                        labelText: "University Name",
                        hintText: "University Name",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                      ),
                    ),

                    SizedBox(height: Get.height * 0.03),

                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20))),
                        onPressed: () {

                          if ((_formkey.currentState)!.validate()) {
                            updateprofile(nameController.text.trim(),
                                phoneController.text.trim());

                            Get.snackbar("Save", "Profile Updated",
                                snackPosition: SnackPosition.BOTTOM,
                                backgroundColor: Colors.green,
                                colorText: Colors.white,
                                duration: const Duration(seconds: 2));


                          }
                        },
                        child: Text("Update".toUpperCase(),style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,

                        ),),
                      ),
                    ),
                    SizedBox(height: Get.height * 0.015),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20))),
                        onPressed: () {

                          FirebaseAuth.instance.signOut().whenComplete(() {
                            Get.offAll(() => const LoginScreen());
                          });
                          },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Logout".toUpperCase(),
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),),
                            const SizedBox(width: 10),
                            const Icon(Icons.logout),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: Get.height * 0.015),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20))),
                        onPressed: ()  {


                          Map<String, String> answerMap = {};
                          for (int i = 0; i < answerbox.length; i++) {
                            answerMap[answerbox.keyAt(i).toString()] =
                                answerbox.getAt(i).toString();
                          }



                           database.reference().child("Results").child(teamID).child(user.uid).update(answerMap).whenComplete((){
                              Get.snackbar("Sync", "Syncing with Database",
                                  snackPosition: SnackPosition.BOTTOM,
                                  backgroundColor: Colors.green,
                                  colorText: Colors.white,
                                  duration: const Duration(seconds: 2));
                           });



                        },




                        child: Row(

                          mainAxisAlignment: MainAxisAlignment.center,

                          children: [
                            Text("Sync with Database".toUpperCase(),
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),),
                            const SizedBox(width: 10),
                            const Icon(Icons.sync),

                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
            // else if (snapshot.hasError) {
            //   return Center(child: Text(snapshot.error.toString()));
            // }
            else {
              return const Center(child: CircularProgressIndicator());
            }
          }),
    );
  }

  // this function to update user profile
  void updateprofile(String name, String phone) {
    ref.child(SessionController().userid.toString()).update({
      'username': name,
      'phone': phone,
    });
  }

}



class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}


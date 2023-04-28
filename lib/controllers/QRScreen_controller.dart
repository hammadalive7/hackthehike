import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class QRcontroller extends GetxController {
  var questionBoxEnabled = false.obs;
  var result;

  var user = FirebaseAuth.instance.currentUser;

  DatabaseReference ref = FirebaseDatabase.instance.ref('Questions');

  getQuestion() {
    questionBoxEnabled.value = true;
    return Text("${result!.code}",
        style: const TextStyle(color: Colors.green, fontSize: 20));
  }

}
import 'package:flutter/material.dart';
import 'package:hackthehike/common/transparent_appBar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: transparentAppBar(context),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
          },
          child: const Text("Go to Login Screen"),
        ),
      ),
    );
  }
}

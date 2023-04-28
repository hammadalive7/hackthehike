import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hackthehike/Screens/cautions_screen.dart';
import 'package:lottie/lottie.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Padding(
        padding:  EdgeInsets.only(top: height*0.1),
        child: SizedBox(
          height: height,
          width: width,
          child: Center(
            child: IntroductionScreen(
              done: const Text("Next",style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),),
              onDone: (){
                _storeOnboardInfo();
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => CautionsScreen()),(route) => false);
              },
              next: const Icon(Icons.arrow_forward_ios_rounded,size: 30,),
              skip: const Text("Skip",style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),),
              showSkipButton: true,
              pages:[
                PageViewModel(
                  decoration: pageDecoration(),
                  title: "Welcome to the Hack The Hike!",
                  body: "Hey, adventurer!\nAre you ready to conquer the great outdoors and challenge your limits? sIntroducing Hack The Hike, the ultimate hiking competition app designed to help you level up your hiking game, monitor your progress, and ensure your safety while you're out there exploring.",
                  image: Lottie.asset("assets/climb.json"),
                ),PageViewModel(
                  decoration: pageDecoration(),
                  title: "Stay Safe on the Trail",
                  body: "Prepare for the hike, including checking the weather forecast, wearing appropriate clothing and gear, and carrying sufficient water and food. Knowing basic first-aid procedures and carrying a first-aid kit is necessary for a safe journey.",
                  image: Lottie.asset("assets/safe.json"),
                ),PageViewModel(
                  decoration: pageDecoration(),
                  title: "Scan to Score Points",
                  body: "By scanning the QR code on the hiking trail, you can track your progress and earn points for each completed section. Each code scan will reward you with a certain number of points, adding to your overall score",
                  image: LottieBuilder.asset("assets/qrcode1.json"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  PageDecoration pageDecoration(){
    return const PageDecoration(
        bodyPadding: EdgeInsets.symmetric(horizontal: 10),
        titleTextStyle: TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.w500,
        ),
        bodyTextStyle: TextStyle(
          color:Colors.grey,
          fontSize: 18,
          fontStyle: FontStyle.italic,
          fontWeight: FontWeight.w300,
        ),
    );
  }

  _storeOnboardInfo() async {
    debugPrint("Shared pref called");
    int isViewed = 0;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('onBoard', isViewed);
    debugPrint(prefs.getInt('onBoard').toString());
  }
}

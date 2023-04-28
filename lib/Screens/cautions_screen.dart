import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hackthehike/Screens/login_screen.dart';
import 'package:hackthehike/Screens/qr_code_screen.dart';
import 'package:hackthehike/Screens/signup_screen.dart';

class CautionsScreen extends StatelessWidget {
  List<String> svgIcon = [
    "assets/emergency.svg",
    "assets/firstaid.svg",
    "assets/hazard.svg",
    "assets/nolittering.svg",
    "assets/safety.svg",
    "assets/weather.svg",
  ];

  List<String> text = [
    "Emergency Response",
    "First-aid Kit",
    "Common Hazards",
    "Respect the Trail",
    "Stay Safe",
    "Weather Forecast"
  ];

  List<String> description = [
    "Hikers will be provided with emergency contact information and advised to understand the emergency response procedures for their area.",
    "Hikers are encouraged to carry a first-aid kit and to be familiar with basic first-aid procedures in case of an emergency.",
    "The hikers are informed of common hazards they may encounter on the trail, such as slippery surfaces, wildlife, and steep inclines. They are also advised to exercise caution and be mindful of their surroundings.",
    "Hikers are reminded to respect the trail and to minimize their impact on the environment, such as by properly disposing of waste and avoiding littering.",
    "Hikers are reminded to stay on the designated trail and to avoid taking shortcuts or going off-route, as this can be dangerous and can result in disqualification from the competition.",
    "The hikers are advised to check the weather forecast before starting their hike and to come prepared for any conditions they may encounter."
  ];

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding:  EdgeInsets.only(top: height * 0.1),
          child: Container(
            height: height,
            width: width,
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  "images/caution.png",
                  width: width / 1.8,
                  fit: BoxFit.fitWidth,
                ),
                Expanded(
                  child: GridView.builder(
                      itemCount: text.length,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2, childAspectRatio: 1.2),
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(10),
                          child: PhysicalModel(
                            elevation: 10,
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(10),
                            child: InkWell(
                              onTap: () => showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(18)),
                                      backgroundColor: Colors.white,
                                      elevation: 20,
                                      title: FittedBox(
                                          child: Text(text[index],
                                              style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 20,
                                                  fontWeight:
                                                      FontWeight.w600))),
                                      icon: SvgPicture.asset(
                                        svgIcon[index],
                                        height: height * 0.1,
                                      ),
                                      content: Text(description[index],textAlign: TextAlign.justify,
                                          style: TextStyle(
                                              color: Colors.grey.shade700,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400)),
                                    );
                                  }),
                              child: Container(
                                height: height * 0.1,
                                width: width / 2.4,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                      svgIcon[index],
                                      height: height * 0.1,
                                    ),
                                    FittedBox(
                                        child: Text(text[index],
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400))),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                ),
                SizedBox(
                  height: height * 0.07,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.green,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                      onPressed: () => Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const LoginScreen()), (route) => false),
                      child: const Center(
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child:Text(
                            "Let's Start!",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w500)
                          ),
                        ),
                      )),
                )
              ],
            ),
          ),
        ));
  }
}

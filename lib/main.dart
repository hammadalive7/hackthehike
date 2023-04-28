import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hackthehike/bottom_navigation.dart';
import 'package:hackthehike/models/question_model.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'Screens/splash_screen.dart';
import 'firebase_options.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  var directory = await getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  Hive.registerAdapter(QuestionAdapter());
  await Hive.openBox<Question>('quest');
  await Hive.openBox('answer');


  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,

  ).whenComplete(() => debugPrint("Firebase Initialized"));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    User? firebaseUser = FirebaseAuth.instance.currentUser;
// Define a widget
    Widget firstWidget;

// Assign widget based on availability of currentUser
    if (firebaseUser != null) {
      firstWidget = const BottomNavigationScreen(title: "Home");
    } else {
      firstWidget = const SplashScreen();
    }
    return GetMaterialApp(
      title: 'hackthehike',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.green,
        textTheme: GoogleFonts.amaranthTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      home:  firstWidget,
    );
  }
}



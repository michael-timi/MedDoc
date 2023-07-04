import 'package:flutter/material.dart';
import 'package:meddoc/Screens/NewSplashScreen.dart';
import 'package:meddoc/Screens/SignIn.dart';
import 'package:meddoc/Screens/SignUp.dart';
import 'package:meddoc/Screens/SplashScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:meddoc/Screens/learning.dart';
import 'Screens/VerificationScreen.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MedDoc',
      debugShowCheckedModeBanner: false,

      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SignIn(),
    );
  }
}



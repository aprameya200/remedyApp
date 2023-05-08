// ignore_for_file: dead_code, prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:remedy_app/pages/auth.dart';
import 'package:remedy_app/pages/doctor-skeleton.dart';
import 'package:remedy_app/pages/doctor/about-doctor-page.dart';
import 'package:remedy_app/pages/patient/patient-form.dart';
import 'package:remedy_app/pages/patient_skeleton.dart';
import 'package:remedy_app/pages/login_page.dart';
import 'package:remedy_app/pages/patient/mesages.dart';
import 'package:remedy_app/pages/patient/patients_page.dart';
import 'package:remedy_app/pages/patient/searchDoctor.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:remedy_app/pages/pick_account.dart';
import 'package:remedy_app/pages/verify_email.dart';
import 'package:remedy_app/widgets/themes.dart';
import 'package:remedy_app/widgets/utils.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

Color? selectedColor;

final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scaffoldMessengerKey: Utils.messengerKey,
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      //home: homePage.build(context), set below from route

      /**
       * Themes selection from here
       */
      themeMode: ThemeMode.light,
      theme: ThemeData(
        primarySwatch: Colors.teal,
        fontFamily: GoogleFonts.poppins().fontFamily,
        appBarTheme:
            AppBarTheme(), //themse from anotehr class called using method of that class
      ), //setting primary forn from google fonts

      /**
       * Router from here
       */
      initialRoute:
          "/login", //opens initial route instead of specified routes below

      routes: {
        //routes like laravel
        "/login": (context) => StreamBuilder<User?>(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return Center(child: Text("Something went wrong !"));
              } else if (snapshot.hasData) {
                return VerifyEmail();
              } else {
                return Authenticate();
              }
            }),

        //route has been changes to this page
        // MyRoutes.homeRoute: (context) =>
        //     HomePage(), //routing using rpoute classes
        // MyRoutes.loginRoute: (context) => LoginPage(),
      },
    );
  }
}

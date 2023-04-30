import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:remedy_app/pages/patient_skeleton.dart';
import 'package:remedy_app/pages/login_page.dart';
import 'package:remedy_app/pages/patient/mesages.dart';
import 'package:remedy_app/pages/patient/patients_page.dart';
import 'package:remedy_app/pages/patient/searchDoctor.dart';

void main() {
  runApp(const MyApp());
}

Color? selectedColor;

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      //home: homePage.build(context), set below from route

      /**
       * Themes selection from here
       */
      themeMode: ThemeMode.light,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
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
        "/login": (context) =>
            SkeletonPage(), //route has been changes to this page
        // MyRoutes.homeRoute: (context) =>
        //     HomePage(), //routing using rpoute classes
        // MyRoutes.loginRoute: (context) => LoginPage(),
      },
    );
  }
}

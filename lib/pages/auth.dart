import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:remedy_app/pages/doctor-skeleton.dart';
import 'package:remedy_app/pages/doctor/about-doctor-page.dart';
import 'package:remedy_app/pages/patient_skeleton.dart';
import 'package:remedy_app/pages/login_page.dart';
import 'package:remedy_app/pages/patient/mesages.dart';
import 'package:remedy_app/pages/patient/patients_page.dart';
import 'package:remedy_app/pages/patient/searchDoctor.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:remedy_app/pages/sign-up_page.dart';
import 'package:remedy_app/widgets/themes.dart';

class Authenticate extends StatefulWidget {
  @override
  State<Authenticate> createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool isLoggedIn = true;

  @override
  Widget build(BuildContext context) => isLoggedIn
      ? LoginPage(onClickedSignUp: toggle)
      : SignInPage(onClickedSignIn: toggle);

  void toggle() => setState(() => isLoggedIn = !isLoggedIn);
}

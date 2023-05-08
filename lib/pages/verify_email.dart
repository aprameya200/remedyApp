import 'dart:async';

import 'package:animate_gradient/animate_gradient.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:remedy_app/pages/auth.dart';
import 'package:remedy_app/pages/patient/patients_page.dart';
import 'package:remedy_app/pages/pick_account.dart';
import 'package:remedy_app/pages/sign-up_page.dart';
import 'package:remedy_app/widgets/anime-gradient.dart';
import 'package:social_login_buttons/social_login_buttons.dart';
import 'package:velocity_x/velocity_x.dart';

import 'package:remedy_app/pages/login_page.dart';

import '../main.dart';
import '../widgets/themes.dart';
import '../widgets/utils.dart';
import 'patient_skeleton.dart';

class VerifyEmail extends StatefulWidget {
  @override
  State<VerifyEmail> createState() => _VerifyEmailState();
}

class _VerifyEmailState extends State<VerifyEmail> {
  bool isEmailVerified = false;

  Timer? timer;

  @override
  initState() {
    super.initState();

    isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;

    try {
      if (!isEmailVerified) {
        sendVerificationEmail();

        timer =
            Timer.periodic(Duration(seconds: 3), (_) => checkEmailVerified());
      }
    } on FirebaseAuthException catch (e) {
      Utils.showSnackBar(e.toString());
    }
  }

  @override
  void dispose() {
    timer?.cancel();

    super.dispose();
  }

  Future checkEmailVerified() async {
    await FirebaseAuth.instance.currentUser!.reload();
    setState(() {
      isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });

    if (isEmailVerified) timer?.cancel();
  }

  Future sendVerificationEmail() async {
    final user = FirebaseAuth.instance.currentUser!;

    await user.sendEmailVerification();
  }

  @override
  Widget build(BuildContext context) => isEmailVerified
      ? PickAccountPage() //pick account page
      : Scaffold(
          // bottomNavigationBar: Example(),
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: "Verify Email".text.xl3.black.make(),
            backgroundColor: Colors.white,
            elevation: 0.0,
            centerTitle: true,
          ),
          body: Container(
            child: Column(
              children: [
                Text("An email has been sent to your address",
                    style: TextStyle(color: Colors.black54, fontSize: 40)),
                TextButton(
                  onPressed: () async {
                    final user = FirebaseAuth.instance.currentUser!;

                    await user.sendEmailVerification();
                    ;
                  },
                  child: "Resend email".text.xl5.make(),
                ),
                15.squareBox,
                TextButton(
                  onPressed: () {
                    FirebaseAuth.instance.signOut();
                  },
                  child: "Back to Login Screen".text.xl2.make(),
                ),
              ],
            ),
          ).p16());
}

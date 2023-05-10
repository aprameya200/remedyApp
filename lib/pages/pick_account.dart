// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:remedy_app/pages/doctor-skeleton.dart';

import 'package:remedy_app/pages/patient/patient-form.dart';

import 'package:velocity_x/velocity_x.dart';

import '../main.dart';
import '../utils/routes.dart';
import '../widgets/themes.dart';
import 'package:animate_gradient/animate_gradient.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import '../widgets/utils.dart';
import 'patient_skeleton.dart';

class PickAccountPage extends StatefulWidget {
  @override
  State<PickAccountPage> createState() => _PickAccountPage();
}

class _PickAccountPage extends State<PickAccountPage> {
  bool pickedAccount = false;

  bool patientInfoFilles = false;

  bool isPatient = true;

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future checkAccountPicked() async {
    User? user = _firebaseAuth.currentUser;

    final data = await FirebaseFirestore.instance //here
        .collection("patient")
        .doc(user!.email.toString())
        .get();

    final data2 = await FirebaseFirestore.instance //here
        .collection("doctor")
        .doc(user!.email.toString())
        .get();

    if (data.exists || data2.exists) {
      setState(() {
        pickedAccount = true;
      });
    }

    if (data!.data()!.containsKey('blood-group')) {
      setState(() {
        patientInfoFilles = true;
        isPatient = true;
      });
    }
  }

  @override
  initState() {
    super.initState();
  }

  @override
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    checkAccountPicked();
    if (pickedAccount) {
      if (!patientInfoFilles) {
        if (isPatient) {
          return PatientPersonalForm();
        } else {
          return DoctorSkeletonPage();
        }
      } else {
        return SkeletonPage();
      }
    } else {
      return Scaffold(
        appBar: AppBar(
          title: "Choose User".text.xl3.black.make(),
          backgroundColor: Colors.white,
          elevation: 0.0,
          centerTitle: true,
        ),
        resizeToAvoidBottomInset: false,
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        body: Container(
          alignment: Alignment.topCenter,
          height: double.infinity,
          child: SafeArea(
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Center(
                    child: Column(children: [
                  "You are a".text.xl5.make(),
                  30.squareBox,
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStatePropertyAll(MyThemes.boxEdge),
                      elevation: MaterialStateProperty.all(15),
                    ),
                    onPressed: () => patient(),
                    child: "Patient".text.xl5.make(),
                  ),
                  30.squareBox,
                  ElevatedButton(
                    onPressed: () => doctor(),
                    child: "Doctor".text.xl5.make(),
                  ),
                ])),
              ),
            ),
          ),
        ).pOnly(top: 50),
      );
    }
  }

  Future<void> _showDialog1(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: const Text('Error Picking Account'),
        );
      },
    );
  }

  Future doctor() async {
    final db = FirebaseFirestore.instance;

    final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
    User? user = _firebaseAuth.currentUser;

    print(user!.email.toString());

    try {
      await db.collection("doctor").doc(user!.email.toString()).set({
        "email": user!.email.toString(),
      });

      setState(() {
        isPatient = false;
      });
      checkAccountPicked();
    } on FirebaseAuthException catch (e) {
      _showDialog1(context);
    }
  }

  Future patient() async {
    final db = FirebaseFirestore.instance;
    User? user = _firebaseAuth.currentUser;

    print(user!.email.toString());

    try {
      await db.collection("patient").doc(user!.email.toString()).set({
        "email": user!.email.toString(),
      });

      checkAccountPicked();
    } on FirebaseAuthException catch (e) {
      _showDialog1(context);
    }
  }
}

class LineDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      child: Container(
        height: 1.0,
        width: 85.0,
        color: MyThemes.textColor,
      ),
    );
  }
}

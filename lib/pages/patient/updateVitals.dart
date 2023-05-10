// ignore_for_file: prefer_const_constructors

import 'package:animate_gradient/animate_gradient.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fast_forms/flutter_fast_forms.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:remedy_app/data/patient-data.dart';
import 'package:remedy_app/pages/login_page.dart';
import 'package:remedy_app/pages/patient/validate-patient.dart';
import 'package:remedy_app/pages/patient/vitals.dart';
import 'package:social_login_buttons/social_login_buttons.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:age_calculator/age_calculator.dart';
import 'package:remedy_app/pages/sign-up_page.dart';

//Calander
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../../utils/routes.dart';
import '../../widgets/themes.dart';

class UpdateVitalsPage extends StatefulWidget {
  @override
  State<UpdateVitalsPage> createState() => _UpdateVitalsPageState();
}

class _UpdateVitalsPageState extends State<UpdateVitalsPage> {
  final _formKey = GlobalKey<FormState>();

  final systolicController = TextEditingController();
  final diastolicController = TextEditingController();
  final bloodPressureController = TextEditingController();
  final heartRateController = TextEditingController();
  final temperatureController = TextEditingController();

  Validate validate = new Validate();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Color(0xffB9EDDD),
        body: Container(
          child: SafeArea(
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Padding(
                  padding: EdgeInsets.all(30.0),
                  child: Column(
                    children: [
                      "Patient Info".text.xl4.color(MyThemes.textColor).make(),
                      20.squareBox,
                      Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                  color: MyThemes.shadows,
                                  blurRadius: 20.0,
                                  offset: Offset(0, 10))
                            ]),
                        child: Column(
                          children: [
                            "Vitals Information".text.xl3.make(),
                            5.squareBox,
                            "Blood Presssure".text.xl2.make(),
                            15.squareBox,
                            FastTextField(
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: (value) =>
                                  value != null && validate.isTrueNumber(value)
                                      ? "Enter a valid number"
                                      : null,
                              onChanged: (value) =>
                                  systolicController.text = value.toString(),
                              keyboardType: TextInputType.number,
                              name: 'systolic',
                              labelText: 'Systolic (Upper Number)',
                            ),
                            15.squareBox,
                            FastTextField(
                              keyboardType: TextInputType.number,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: (value) =>
                                  value != null && validate.isTrueNumber(value)
                                      ? "Enter a valid number"
                                      : null,
                              onChanged: (value) =>
                                  diastolicController.text = value.toString(),
                              name: 'diastolic',
                              labelText: 'Diastoli (Lower Number)',
                            ),
                            20.squareBox,
                            "Heart Rate".text.xl2.make(),
                            15.squareBox,
                            FastTextField(
                              keyboardType: TextInputType.number,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: (value) =>
                                  value != null && validate.isTrueNumber(value)
                                      ? "Enter a valid number"
                                      : null,
                              onChanged: (value) =>
                                  heartRateController.text = value.toString(),
                              name: 'heartrate',
                              labelText: 'Heart Rate in bpm',
                            ),
                            20.squareBox,
                            "Blood Oxygen".text.xl2.make(),
                            15.squareBox,
                            FastTextField(
                              keyboardType: TextInputType.number,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: (value) => value != null &&
                                      validate.isTrueBloodOxygen(value)
                                  ? "Enter a valid number"
                                  : null,
                              onChanged: (value) => bloodPressureController
                                  .text = value.toString(),
                              name: 'bloodoxygen',
                              labelText: 'Blood Oxygen %',
                            ),
                            20.squareBox,
                            "Temperature".text.xl2.make(),
                            15.squareBox,
                            FastTextField(
                              keyboardType: TextInputType.number,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: (value) =>
                                  value != null && validate.isTrueNumber(value)
                                      ? "Enter a valid number"
                                      : null,
                              onChanged: (value) =>
                                  temperatureController.text = value.toString(),
                              name: 'temperature',
                              labelText: 'Temperature in ° F',
                            ),
                          ],
                        ).p12(),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      12.squareBox,
                      Material(
                        color: Color(0xff57C5B6),
                        // shape: changedButton ? BoxShape.circle : BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(50),
                        child: InkWell(
                          onTap: () => submit(),
                          //  Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) => PatientHealthForm(),
                          //   ),
                          // ),
                          child: AnimatedContainer(
                            width: 220,
                            height: 50,
                            // cannot use both color (of container and color of box decoration)
                            duration: Duration(seconds: 1),
                            child: Center(
                              //can use wrap with center
                              child: Text(
                                "Submit",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      // Expanded(child: MyAnimation()),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
  }

  Future submit() async {
    final isValid = _formKey.currentState!.validate();

    if (!isValid) return;

    final user = FirebaseAuth.instance.currentUser!.email;

    try {
      await FirebaseFirestore.instance
          .collection("patient")
          .doc(user.toString())
          .update({
        "systolic": systolicController.text,
        "diastolic": diastolicController.text,
        "heart-rate": heartRateController.text,
        "blood-oxygen": bloodPressureController.text,
        "temperature": temperatureController.text,
      });

      await FirebaseFirestore.instance
          .collection("patient")
          .doc(user.toString())
          .update({"loginDate": DateUtils.dateOnly(DateTime.now()).toString()});

      Navigator.pushNamed(context, MyRoutes.patientsProfileRoute);
    } on FirebaseAuthException catch (e) {
      print(e);
    }
  }
}

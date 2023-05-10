// ignore_for_file: public_member_api_docs, sort_constructors_first, prefer_interpolation_to_compose_strings
// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:animate_gradient/animate_gradient.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:social_login_buttons/social_login_buttons.dart';
import 'package:velocity_x/velocity_x.dart';

import 'package:remedy_app/pages/sign-up_page.dart';

import '../../widgets/themes.dart';

Color setColor(String status) {
  if (status == "Normal") {
    return Color.fromARGB(239, 255, 255, 255);
  } else if (status == "Elevated" || status == "Low") {
    return Colors.yellow;
  } else if (status == "High") {
    return Colors.red;
  } else if (status == "Very High" || status == "Very Low") {
    return Color.fromARGB(255, 255, 17, 0);
  } else {
    return Color.fromARGB(239, 255, 255, 255);
  }
}

String setText(String status, String text) {
  if (status == "Low") {
    return "Your " + text + " is lower than normal";
  } else if (status == "Normal") {
    return "Your " + text + " is normal";
  } else if (status == "Elevated") {
    return "Your " + text + " has elevated";
  } else if (status == "High") {
    return "Your " + text + " is high";
  } else if (status == "Very High") {
    return "Your " + text + " is very high";
  } else if (status == "Very Low") {
    return "Your " + text + " is very low";
  } else {
    return "Your " + text + " is normal";
  }
}

class ShowBloodPressure extends StatelessWidget {
  final String bloodPressure;
  final String status;
  const ShowBloodPressure({
    Key? key,
    required this.bloodPressure,
    required this.status,
  }) : super(key: key);

  @override
  Widget build(Object context) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Container(
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
            color: Color.fromARGB(171, 47, 43, 43),
            blurRadius: 15.0, // soften the shadow
            spreadRadius: 5.0, //extend the shadow
            offset: Offset(
              5.0, // Move to right 5  horizontally
              5.0, // Move to bottom 5 Vertically
            ),
          )
        ], color: setColor(status), borderRadius: BorderRadius.circular(10)),
        height: 160,
        width: 180,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 255, 205, 210),
                      borderRadius: BorderRadius.circular(10)),
                  child: Icon(
                    size: 50,
                    CupertinoIcons.drop,
                    color: Color.fromARGB(255, 255, 0, 0),
                  ).p4(),
                ),
                bloodPressure.text.xl.red900.bold.make()
              ],
            ),
            6.squareBox,
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                "Blood Pressure".text.bold.make(),
                setText(status, "blood pressure").text.scale(0.88).make()
              ],
            )
          ],
        ).p16(),
      ),
    ]);
  }
}

class ShowHeartRate extends StatelessWidget {
  final String heartRate;

  final String status;

  const ShowHeartRate({
    Key? key,
    required this.heartRate,
    required this.status,
  }) : super(key: key);

  @override
  Widget build(Object context) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Container(
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
            color: Color.fromARGB(171, 47, 43, 43),
            blurRadius: 15.0, // soften the shadow
            spreadRadius: 5.0, //extend the shadow
            offset: Offset(
              5.0, // Move to right 5  horizontally
              5.0, // Move to bottom 5 Vertically
            ),
          )
        ], color: setColor(status), borderRadius: BorderRadius.circular(10)),
        height: 160,
        width: 180,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Color(0xffFF5959),
                      borderRadius: BorderRadius.circular(10)),
                  child: Icon(
                    size: 50,
                    CupertinoIcons.waveform_path_ecg,
                    color: Color.fromARGB(255, 255, 255, 255),
                  ).p4(),
                ),
                heartRate.text.xl.bold.make()
              ],
            ),
            6.squareBox,
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                "Heart Rate".text.bold.make(),
                setText(status, "heart rate").text.scale(0.88).make()
              ],
            )
          ],
        ).p16(),
      ),
    ]);
  }
}

class ShowBloodOxygen extends StatelessWidget {
  final String bloodOxygen;
  final String status;
  const ShowBloodOxygen({
    Key? key,
    required this.bloodOxygen,
    required this.status,
  }) : super(key: key);

  @override
  Widget build(Object context) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Container(
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
            color: Color.fromARGB(171, 47, 43, 43),
            blurRadius: 15.0, // soften the shadow
            spreadRadius: 5.0, //extend the shadow
            offset: Offset(
              5.0, // Move to right 5  horizontally
              5.0, // Move to bottom 5 Vertically
            ),
          )
        ], color: setColor(status), borderRadius: BorderRadius.circular(10)),
        height: 160,
        width: 180,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Colors.red[400],
                      borderRadius: BorderRadius.circular(10)),
                  child: Icon(
                    size: 50,
                    CupertinoIcons.circle_grid_hex,
                    color: Color(0xffEEF2FF),
                  ).p4(),
                ),
                bloodOxygen.text.xl.bold.make()
              ],
            ),
            6.squareBox,
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                "Blood Oxygen Level".text.bold.make(),
                setText(status, "blood oxygen").text.scale(0.88).make()
              ],
            )
          ],
        ).p16(),
      ),
    ]);
  }
}

class ShowTemperature extends StatelessWidget {
  final String temperature;
  final String status;
  const ShowTemperature({
    Key? key,
    required this.temperature,
    required this.status,
  }) : super(key: key);

  @override
  Widget build(Object context) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Container(
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
            color: Color.fromARGB(171, 47, 43, 43),
            blurRadius: 15.0, // soften the shadow
            spreadRadius: 5.0, //extend the shadow
            offset: Offset(
              5.0, // Move to right 5  horizontally
              5.0, // Move to bottom 5 Vertically
            ),
          )
        ], color: setColor(status), borderRadius: BorderRadius.circular(10)),
        height: 160,
        width: 180,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Colors.blue[100],
                      borderRadius: BorderRadius.circular(10)),
                  child: Icon(
                    size: 50,
                    CupertinoIcons.thermometer,
                    color: Color.fromARGB(255, 175, 111, 0),
                  ).p4(),
                ),
                temperature.text.xl.bold.make()
              ],
            ),
            6.squareBox,
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                "Temperature".text.bold.make(),
                setText(status, "temperature").text.scale(0.88).make()
              ],
            )
          ],
        ).p16(),
      ),
    ]);
  }
}

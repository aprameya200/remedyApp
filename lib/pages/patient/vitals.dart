import 'package:animate_gradient/animate_gradient.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:social_login_buttons/social_login_buttons.dart';
import 'package:velocity_x/velocity_x.dart';

import 'package:remedy_app/pages/sign-up_page.dart';

import '../../widgets/themes.dart';

class ShowBloodPressure extends StatelessWidget {
  @override
  Widget build(Object context) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Container(
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Color.fromARGB(171, 47, 43, 43),
                blurRadius: 15.0, // soften the shadow
                spreadRadius: 5.0, //extend the shadow
                offset: Offset(
                  5.0, // Move to right 5  horizontally
                  5.0, // Move to bottom 5 Vertically
                ),
              )
            ],
            color: Color.fromARGB(239, 255, 255, 255),
            borderRadius: BorderRadius.circular(10)),
        height: 160,
        width: 180,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Colors.red[100],
                      borderRadius: BorderRadius.circular(10)),
                  child: Icon(
                    size: 50,
                    CupertinoIcons.drop,
                    color: Color.fromARGB(255, 255, 0, 0),
                  ).p4(),
                ),
                "120/80".text.xl.red900.bold.make()
              ],
            ),
            6.squareBox,
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                "Blood Pressure".text.bold.make(),
                "Your blood pressure is normal".text.scale(0.88).make()
              ],
            )
          ],
        ).p16(),
      ),
    ]);
  }
}

class ShowHeartRate extends StatelessWidget {
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
        ], color: Color(0xffEEF2FF), borderRadius: BorderRadius.circular(10)),
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
                "104 bpm".text.xl.bold.make()
              ],
            ),
            6.squareBox,
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                "Heart Rate".text.bold.make(),
                "Your heart rate is normal".text.scale(0.88).make()
              ],
            )
          ],
        ).p16(),
      ),
    ]);
  }
}

class ShowBloodOxygen extends StatelessWidget {
  @override
  Widget build(Object context) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Container(
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Color.fromARGB(171, 47, 43, 43),
                blurRadius: 15.0, // soften the shadow
                spreadRadius: 5.0, //extend the shadow
                offset: Offset(
                  5.0, // Move to right 5  horizontally
                  5.0, // Move to bottom 5 Vertically
                ),
              )
            ],
            color: Color.fromARGB(255, 253, 253, 253),
            borderRadius: BorderRadius.circular(10)),
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
                "95%".text.xl.bold.make()
              ],
            ),
            6.squareBox,
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                "Blood Oxygen Level".text.bold.make(),
                "Your Blood Oxygen Level is normal".text.scale(0.88).make()
              ],
            )
          ],
        ).p16(),
      ),
    ]);
  }
}

class ShowTemperature extends StatelessWidget {
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
        ], color: Color(0xffA1DD70), borderRadius: BorderRadius.circular(10)),
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
                "98 °F".text.xl.bold.make()
              ],
            ),
            6.squareBox,
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                "Temperature".text.bold.make(),
                "Your temperature  is normal".text.scale(0.88).make()
              ],
            )
          ],
        ).p16(),
      ),
    ]);
  }
}

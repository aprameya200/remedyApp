// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_import

import 'package:animate_gradient/animate_gradient.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:remedy_app/pages/patient/vitals.dart';
import 'package:social_login_buttons/social_login_buttons.dart';
import 'package:velocity_x/velocity_x.dart';

import 'package:remedy_app/pages/sign-up_page.dart';

//Calander
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../../widgets/bottomBar.dart';
import '../../widgets/themes.dart';

class PatientPage extends StatefulWidget {
  @override
  State<PatientPage> createState() => _PatientPage();
}

class _PatientPage extends State<PatientPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Example(),
      backgroundColor: MyThemes.boxEdge,
      appBar: AppBar(
        title: "Profile".text.xl3.black.make(),
        backgroundColor: Colors.white,
        elevation: 0.0,
        centerTitle: true,
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(children: [
            PatientInitialInfo(),
            InfoAdditionButton(),
            "Health".text.xl4.bold.make().pOnly(bottom: 12),
            PatientVitalsInfo(),
            "Appointments".text.xl4.bold.make().pOnly(bottom: 12),
            AppointmentCalander()
          ]),
        ),
      ),
    );
  }
}

class PatientInitialInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Color.fromARGB(255, 47, 43, 43),
              blurRadius: 15.0, // soften the shadow
              spreadRadius: 5.0, //extend the shadow
              offset: Offset(
                5.0, // Move to right 5  horizontally
                5.0, // Move to bottom 5 Vertically
              ),
            )
          ],
          color: Colors.white,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(40),
              bottomRight: Radius.circular(40))),
      //color: Colors.red,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            backgroundColor: MyThemes.boxEdge,
            radius: 55,
            child: CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/images/CAPS.jpg'),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              "Eren Yaeger".text.xl2.bold.make(),
              "Male".text.xl.make(),
              "22".text.xl.make(),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStatePropertyAll(MyThemes.loginColor),
                ),
                onPressed: null,
                child: Row(
                  children: [
                    Icon(
                      CupertinoIcons.info,
                      color: Color.fromARGB(255, 254, 254, 254),
                    ),
                    5.squareBox,
                    "Patient".text.white.bold.make()
                  ],
                ),
              )
              // "180 cm".text.make(),
              // "80 kg".text.make()
            ],
          ).pOnly(left: 24),
        ],
      ).pOnly(right: 32, left: 32, top: 0, bottom: 15),
    );
  }
}

class InfoAdditionButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.start, children: [
      ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(Color(0xffEEF2FF)),
            elevation: MaterialStateProperty.all(15),
          ),
          onPressed: () {},
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                CupertinoIcons.add,
                color: Color.fromARGB(255, 0, 0, 0),
              ),
              5.squareBox,
              "Add Personal Information".text.black.bold.make(),
            ],
          )).pOnly(left: 32, right: 32, top: 10, bottom: 10),
    ]);
  }
}

class PatientVitalsInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Row(
              //top row
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [ShowBloodPressure(), ShowHeartRate()])
          .pOnly(right: 10, left: 10, bottom: 20),
      Row(
              //bottom row
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [ShowBloodOxygen(), ShowTemperature()])
          .pOnly(right: 10, left: 10, bottom: 20)
    ]);
  }
}

class AppointmentCalander extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: SfCalendar(
        view: CalendarView.month,
        headerStyle: CalendarHeaderStyle(textStyle: TextStyle(fontSize: 20)),
        todayHighlightColor: Colors.black,
        cellBorderColor: Colors.transparent,
        selectionDecoration: BoxDecoration(color: MyThemes.calanderSelection),
      ).p12(),
    ).pOnly(top: 0, left: 35, right: 40, bottom: 35);
  }
}
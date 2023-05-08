// ignore_for_file: public_member_api_docs, sort_constructors_first, sort_child_properties_last
// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_import

import 'package:animate_gradient/animate_gradient.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:social_login_buttons/social_login_buttons.dart';
import 'package:velocity_x/velocity_x.dart';

import 'package:remedy_app/pages/doctor/dashboard-elements.dart';
import 'package:remedy_app/pages/patient/patients_page.dart';
import 'package:remedy_app/pages/patient/vitals.dart';
import 'package:remedy_app/pages/sign-up_page.dart';

//firebase
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

//Calander
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../../widgets/themes.dart';

class AboutDoctor extends StatefulWidget {
  @override
  State<AboutDoctor> createState() => _AboutDoctorState();
}

class _AboutDoctorState extends State<AboutDoctor> {
  String aboutDoctor =
      "Grisha Yeager (グリシャ・イェーガー Gurisha Yēgā?) was an Eldian doctor who originated from the Liberio internment zone in Marley, and was one of the Eldian Restorationists. He was sent on a mission from 'the Owl' to infiltrate the Walls and take the Founding Titan from the Reiss family, and was given the power of the Attack Titan in order to do so";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyThemes.boxEdge,
      appBar: AppBar(
        title: "About".text.xl3.black.bold.make(),
        elevation: 0,
        backgroundColor: MyThemes.boxEdge,
        leading: IconButton(
          color: Colors.black,
          icon: Icon(Icons.arrow_back_ios),
          iconSize: 20.0,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
      ),
      body: Container(
          child: SingleChildScrollView(
        child: Column(children: [
          50.squareBox,
          Container(
            height: 1000,
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
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40))),
            child: Column(
              children: [
                Row(
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
                        "Dr. Grisha Yaeger".text.xl2.bold.make(),
                        "Proctologist".text.xl.make(),
                        Row(
                          children: [
                            Icon(
                              CupertinoIcons.star_fill,
                              size: 20,
                              color: Colors.amber[400],
                            ),
                            10.squareBox,
                            "4.2".text.bold.make(),
                          ],
                        ),

                        // "180 cm".text.make(),
                        // "80 kg".text.make()
                      ],
                    ).pOnly(left: 24),
                  ],
                ).pOnly(right: 32, left: 32, top: 20, bottom: 15),
                Container(
                  width: double.infinity,
                  height: 80,
                  decoration: BoxDecoration(
                    color: Color(0xffDBDFEA),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          "123".text.xl.bold.make(),
                          "Reviews".text.make()
                        ],
                      ),
                      VerticalDivider(
                        thickness: 1.5,
                        color: Color.fromARGB(255, 37, 36, 36),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          "34".text.xl.bold.make(),
                          "Patients".text.make()
                        ],
                      ),
                      VerticalDivider(
                        thickness: 1.5,
                        color: Color.fromARGB(255, 37, 36, 36),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          "23".text.xl.bold.make(),
                          "Years Exp.".text.make(),
                        ],
                      )
                    ],
                  ).p12(),
                ).pOnly(right: 30, left: 30),
                15.squareBox,
                Container(
                  width: double.infinity,
                  height: 250,
                  decoration: BoxDecoration(
                    color: Color(0xffDBDFEA),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      "About".text.xl2.bold.make(),
                      10.squareBox,
                      aboutDoctor.text.medium.justify.make(),
                    ],
                  ).p16(),
                ).pOnly(right: 30, left: 30),
                15.squareBox,
                "Available Days".text.xl3.make(),
                5.squareBox,
                Container(
                    child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        height: 100,
                        child: ListView.builder(
                          itemCount: 10,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) => Container(
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Color.fromARGB(255, 246, 239, 239),
                                    blurRadius: 15.0, // soften the shadow
                                    spreadRadius: 1.0, //extend the shadow
                                    offset: Offset(
                                      2.0, // Move to right 5  horizontally
                                      2.0, // Move to bottom 5 Vertically
                                    ),
                                  )
                                ],
                                color: Color(0xffDBDFEA),
                                borderRadius: BorderRadius.circular(13)),
                            height: 150,
                            width: 100,
                            margin: EdgeInsets.all(10),
                            child: Center(
                              child: Text(
                                "Monday",
                                style: TextStyle(
                                    color: Color.fromARGB(255, 0, 0, 0),
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )).pOnly(left: 25, right: 25),
                5.squareBox,
                "Pricing".text.xl3.make(),
                5.squareBox,
                Container(
                  width: 200,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Color(0xffDBDFEA),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(child: "Rs 700".text.xl6.bold.make().p16()),
                ).pOnly(right: 30, left: 30),
                15.squareBox,
                ElevatedButton(
                    onPressed: () {},
                    style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        )),
                        backgroundColor:
                            MaterialStatePropertyAll(MyThemes.boxEdge)),
                    child: "Book Appointment".text.xl4.black.make().p16()),
                // AddReport(addText: "Book Appointment"),
                // AppointmentCalander()
              ],
            ),
          )
        ]),
      )),
    );
  }
}

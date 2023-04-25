// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_import

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:remedy_app/pages/sign-up_page.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:social_login_buttons/social_login_buttons.dart';

import '../../widgets/themes.dart';
import 'package:animate_gradient/animate_gradient.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class PatientPage extends StatefulWidget {
  @override
  State<PatientPage> createState() => _PatientPage();
}

class _PatientPage extends State<PatientPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyThemes.boxEdge,
      appBar: AppBar(
        title: "Profile".text.xl3.black.make(),
        backgroundColor: Colors.white,
        elevation: 0.0,
        centerTitle: true,
      ),
      body: Container(
        child: Column(children: [
          PatientInitialInfo(),
          InfoAdditionButton(),
        ]),
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
    // TODO: implement build
    return Row(children: [
      ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(MyThemes.btnBox),
            elevation: MaterialStateProperty.all(15),
          ),
          onPressed: () {},
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(
                CupertinoIcons.add,
                color: Color.fromARGB(255, 0, 0, 0),
              ),
              5.squareBox,
              "Add Personal Information".text.black.bold.make()
            ],
          )).pOnly(left: 32, right: 32, top: 10, bottom: 10),
    ]);
  }
}

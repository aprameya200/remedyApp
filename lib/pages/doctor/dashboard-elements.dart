// ignore_for_file: public_member_api_docs, sort_constructors_first
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

class ShowNewPatients extends StatelessWidget {
  @override
  Widget build(Object context) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Container(
        decoration: BoxDecoration(
            boxShadow: [
              // ignore: prefer_const_constructors
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
                      color: MyThemes.docIcon,
                      borderRadius: BorderRadius.circular(10)),
                  child: Icon(
                    size: 50,
                    CupertinoIcons.person_2,
                    color: MyThemes.docIconWhite,
                  ).p4(),
                ),
                "12 ".text.xl.bold.make()
              ],
            ),
            6.squareBox,
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                "New Patients".text.bold.make(),
                "You have new patients today".text.scale(0.88).make()
              ],
            )
          ],
        ).p16(),
      ),
    ]);
  }
}

class ShowConsultations extends StatelessWidget {
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
                      color: MyThemes.docIcon,
                      borderRadius: BorderRadius.circular(10)),
                  child: Icon(
                    size: 50,
                    CupertinoIcons.captions_bubble_fill,
                    color: MyThemes.docIconWhite,
                  ).p4(),
                ),
                "4".text.xl.bold.make()
              ],
            ),
            6.squareBox,
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                "Consultations".text.bold.make(),
                "You have few a consultations".text.scale(0.88).make()
              ],
            )
          ],
        ).p16(),
      ),
    ]);
  }
}

class ShowInProgress extends StatelessWidget {
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
                      color: MyThemes.docIcon,
                      borderRadius: BorderRadius.circular(10)),
                  child: Icon(
                    size: 50,
                    CupertinoIcons.arrow_2_squarepath,
                    color: MyThemes.docIconWhite,
                  ).p4(),
                ),
                "5".text.xl.bold.make()
              ],
            ),
            6.squareBox,
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                "In Progress".text.bold.make(),
                "You have few patients".text.scale(0.88).make()
              ],
            )
          ],
        ).p16(),
      ),
    ]);
  }
}

class ShowReports extends StatelessWidget {
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
        ], color: Color(0xff36AE7C), borderRadius: BorderRadius.circular(10)),
        height: 160,
        width: 180,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: MyThemes.docIcon,
                      borderRadius: BorderRadius.circular(10)),
                  child: Icon(
                    size: 50,
                    CupertinoIcons.doc_text_fill,
                    color: Color.fromARGB(255, 255, 255, 255),
                  ).p4(),
                ),
                "14".text.white.xl.bold.make()
              ],
            ),
            6.squareBox,
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                "Patient Medical Report".text.bold.white.make(),
                "You have new report".text.white.scale(0.88).make()
              ],
            )
          ],
        ).p16(),
      ),
    ]);
  }
}

class AddReport extends StatelessWidget {
  final String addText;
  const AddReport({
    Key? key,
    required this.addText,
  }) : super(key: key);

  Widget build(Object context) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      InkWell(
        child: Container(
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
          height: 70,
          width: 370,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                size: 45,
                CupertinoIcons.plus,
                color: Color.fromARGB(255, 55, 51, 51),
              ),
              addText.text.xl3.bold.make()
            ],
          ).p16(),
        ),
      ),
    ]);
  }
}

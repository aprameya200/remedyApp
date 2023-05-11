// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_import

import 'package:age_calculator/age_calculator.dart';
import 'package:animate_gradient/animate_gradient.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:remedy_app/pages/doctor/dashboard-elements.dart';
import 'package:remedy_app/pages/patient/vitals.dart';
import 'package:social_login_buttons/social_login_buttons.dart';
import 'package:velocity_x/velocity_x.dart';

import 'package:remedy_app/pages/sign-up_page.dart';

//Calander
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../../utils/routes.dart';
import '../../widgets/themes.dart';

class DoctorPage extends StatefulWidget {
  final dummy;
  const DoctorPage({super.key, required this.dummy});

  @override
  State<DoctorPage> createState() => _DoctorPage();
}

class _DoctorPage extends State<DoctorPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // bottomNavigationBar: Example(),
      backgroundColor: MyThemes.btnBox,
      appBar: AppBar(
        title: "Profile".text.xl3.black.make(),
        backgroundColor: Colors.white,
        elevation: 0.0,
        centerTitle: true,
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(children: [
            DoctorInitialInfo(),
            InfoAdditionButton(),
            "Dashboard".text.xl4.bold.make().pOnly(bottom: 12),
            DoctorDashboardInfo(),
            AddReport(
              addText: "Add Appomtment",
            ),
            20.squareBox,
            "Your Calander".text.xl4.bold.make().pOnly(bottom: 12),
            DoctorCalander()
          ]),
        ),
      ),
    );
  }
}

class DoctorInitialInfo extends StatefulWidget {
  @override
  State<DoctorInitialInfo> createState() => _DoctorInitialInfoState();
}

class _DoctorInitialInfoState extends State<DoctorInitialInfo> {
  List userList = [];

  @override
  initState() {
    super.initState();
    getPatientData();
  }

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future getPatientData() async {
    User? user = _firebaseAuth.currentUser;

    try {
      final data = await FirebaseFirestore.instance //here
          .collection("doctor")
          .doc(user!.email.toString())
          .get();

      setState(() {
        userList.add(data.data());
      });
    } on Exception catch (e) {
      // TODO
    }

    print(userList[0]["first-name"]);
  }

  String parseAge(String dob) {
    DateTime birthday = DateTime.parse(dob);

    DateDuration duration;

    // Find out your age as of today's date 2021-03-08
    duration = AgeCalculator.age(birthday, today: DateTime.now());
    String result =
        duration.toString().substring(0, duration.toString().indexOf(','));

    var splitted = result.split(' ');

    return splitted[1].toString();
  }

  Future<String> getImage() async {
    User? user = _firebaseAuth.currentUser;

    Reference downloadUrl = await FirebaseStorage.instance
        .ref()
        .child("profilePictures")
        .child("${user!.email.toString()}-profile-pic.jpg");

    return downloadUrl.getDownloadURL();
  }

  @override
  Widget build(BuildContext context) {
    String fullName = userList[0]["first-name"].toString() +
        " " +
        userList[0]["last-name"].toString();

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
            backgroundColor: MyThemes.btnBox,
            radius: 55,
            child: CircleAvatar(
              radius: 50,
              backgroundColor: Colors.white,
              child: ClipOval(
                child: FutureBuilder<String>(
                  future: getImage(),
                  builder: (BuildContext context, AsyncSnapshot<String> image) {
                    if (image.hasData) {
                      return Image.network(
                        image.data.toString(),
                        fit: BoxFit.cover,
                        width: 200,
                        height: 200,
                      ); // image is ready
                      //return Text('data');
                    } else {
                      return new Container(); // placeholder
                    }
                  },
                ),
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              fullName.text.xl2.bold.make(),
              userList[0]["sex"].toString().text.xl.make(),
              parseAge(userList[0]["date-of-birth"].toString()).text.xl.make(),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(MyThemes.btnBox),
                ),
                onPressed: null,
                child: Row(
                  children: [
                    Icon(
                      CupertinoIcons.info,
                      color: Color.fromARGB(255, 254, 254, 254),
                    ),
                    5.squareBox,
                    "Doctor".text.white.bold.make()
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
          onPressed: () {
            Navigator.pushNamed(context, MyRoutes.updatePatientPersonal);
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                CupertinoIcons.person_crop_circle_badge_plus,
                color: Color.fromARGB(255, 0, 0, 0),
              ),
              5.squareBox,
              "Personal Information".text.black.bold.make(),
            ],
          )),
      20.squareBox,
      ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(Color(0xffEEF2FF)),
            elevation: MaterialStateProperty.all(15),
          ),
          onPressed: () {
            _signOut();
            Navigator.pushNamed(context, MyRoutes.loginRoute);
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                CupertinoIcons.arrow_right,
                color: Color.fromARGB(255, 0, 0, 0),
              ),
              5.squareBox,
              "Logout".text.black.bold.make(),
            ],
          )),
    ]).pOnly(left: 20, right: 20, top: 10, bottom: 10);
  }

  Future _signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}

class DoctorDashboardInfo extends StatefulWidget {
  @override
  State<DoctorDashboardInfo> createState() => _DoctorDashboardInfoState();
}

class _DoctorDashboardInfoState extends State<DoctorDashboardInfo> {
  List userList = [];

  @override
  initState() {
    super.initState();
    getPatientData();
  }

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future getPatientData() async {
    User? user = _firebaseAuth.currentUser;

    try {
      final data = await FirebaseFirestore.instance //here
          .collection("doctor")
          .doc(user!.email.toString())
          .get();

      setState(() {
        userList.add(data.data());
      });
    } on Exception catch (e) {
      // TODO
    }

    print(userList[0]["first-name"]);
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Row(
          //top row
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ShowNewPatients(
              patients: userList[0]["patients"],
            ),
            ShowConsultations(
              consultations: userList[0]["consulatations"],
            )
          ]).pOnly(right: 10, left: 10, bottom: 20),
      Row(
          //bottom row
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ShowInProgress(progress: userList[0]["in-progress"]),
            ShowReports(reports: userList[0]["reports"]),
          ]).pOnly(right: 10, left: 10, bottom: 20)
    ]);
  }
}

class DoctorCalander extends StatelessWidget {
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

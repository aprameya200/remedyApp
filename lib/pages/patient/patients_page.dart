// ignore_for_file: public_member_api_docs, sort_constructors_first, curly_braces_in_flow_control_structures, unused_local_variable, unnecessary_new
// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_import

import 'package:animate_gradient/animate_gradient.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:remedy_app/data/patient-data.dart';
import 'package:remedy_app/pages/login_page.dart';
import 'package:remedy_app/pages/patient/check-vital-status.dart';
import 'package:remedy_app/pages/patient/vitals.dart';
import 'package:remedy_app/widgets/singleton-widget.dart';
import 'package:social_login_buttons/social_login_buttons.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:age_calculator/age_calculator.dart';
import 'package:remedy_app/pages/sign-up_page.dart';

//Calander
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../../utils/routes.dart';
import '../../widgets/themes.dart';
import 'ehr.dart';

class PatientPage extends StatefulWidget {
  final dummy;
  const PatientPage({super.key, required this.dummy});

  @override
  State<PatientPage> createState() => _PatientPage();
}

class _PatientPage extends State<PatientPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // bottomNavigationBar: Example(),
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
            "Health Today".text.xl4.bold.make().pOnly(bottom: 5),
            PatientVitalsInfo(),
            "Appointments".text.xl4.bold.make().pOnly(bottom: 12),
            AppointmentCalander()
          ]),
        ),
      ),
    );
  }
}

class PatientInitialInfo extends StatefulWidget {
  @override
  State<PatientInitialInfo> createState() => _PatientInitialInfoState();
}

class _PatientInitialInfoState extends State<PatientInitialInfo> {
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
          .collection("patient")
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

    // String replacement = duration.toString().replaceAll(RegExp('[^0-9:]'), '');
  }

  @override
  Widget build(BuildContext context) {
    // readUsers();

    // ignore: prefer_interpolation_to_compose_strings
    String fullName = userList[0]["first-name"].toString() +
        " " +
        userList[0]["last-name"].toString();

//Data for other update page is set from here
    Singleton singleObject = new Singleton();
    singleObject.setUserData(userList);

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
              fullName.text.xl2.bold.make(),
              userList[0]["sex"].toString().text.xl.make(),
              parseAge(userList[0]["date-of-birth"].toString()).text.xl.make(),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(MyThemes.boxEdge),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EletronicHealthRecord(),
                    ),
                  );
                },
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
            Singleton singleObject = new Singleton();
            singleObject.deteleUserData();
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

class PatientVitalsInfo extends StatefulWidget {
  @override
  State<PatientVitalsInfo> createState() => _PatientVitalsInfoState();
}

class _PatientVitalsInfoState extends State<PatientVitalsInfo> {
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
          .collection("patient")
          .doc(user!.email.toString())
          .get();

      setState(() {
        userList.add(data.data());
      });
    } on Exception catch (e) {
      // TODO
    }

    print(userList[0]["loginDate"]);
    print(DateUtils.dateOnly(DateTime.now()).toString());
  }

  @override
  Widget build(BuildContext context) {
    String bloodPressure =
        userList[0]["systolic"] + "/" + userList[0]["diastolic"];

    String heartRate = userList[0]["heart-rate"] + " bpm";

    String bloodOxygen = userList[0]["blood-oxygen"] + "%";

    String temperature = userList[0]["temperature"] + " °F";

    // return Text("Hwllo");

    CheckVitalStatus vitalStatus = new CheckVitalStatus(
      bloodOxygen: userList[0]["blood-oxygen"],
      diastolic: userList[0]["diastolic"],
      heartRate: userList[0]["heart-rate"],
      systolic: userList[0]["systolic"],
      temperature: userList[0]["temperature"],
    );

    if (userList[0]["loginDate"] == null ||
        userList[0]["loginDate"].toString() !=
            DateUtils.dateOnly(DateTime.now()).toString()) {
      return InkWell(
        child: Container(
          child: ElevatedButton(
            child: "Update Vitals Info".text.xl3.make(),
            onPressed: () {
              Navigator.pushNamed(context, MyRoutes.updatePatientVital);
            },
          ),
        ),
      );
    } else
      return Column(children: [
        Row(
            //top row
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ShowBloodPressure(
                bloodPressure: bloodPressure,
                status: vitalStatus.getBloodPressureStatus(),
              ),
              ShowHeartRate(
                  heartRate: heartRate,
                  status: vitalStatus.getHeartRateStatus())
            ]).pOnly(right: 10, left: 10, bottom: 20),
        Row(
            //bottom row
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ShowBloodOxygen(
                bloodOxygen: bloodOxygen,
                status: vitalStatus.getBloodOxygenStatus(),
              ),
              ShowTemperature(
                temperature: temperature,
                status: vitalStatus.getTemperatureStatus(),
              )
            ]).pOnly(right: 10, left: 10, bottom: 20)
      ]);
  }
}

class AppointmentCalander extends StatefulWidget {
  @override
  State<AppointmentCalander> createState() => _AppointmentCalanderState();
}

class _AppointmentCalanderState extends State<AppointmentCalander> {
  List appointments = [];
  List appointmentKeys = [];

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getPatientAppointments();
  }

  Future getPatientAppointments() async {
    User? user = _firebaseAuth.currentUser;

    try {
      final data = await FirebaseFirestore.instance //here
          .collection("patient-appointment")
          .doc(user!.email.toString())
          .get();

      setState(() {
        appointments.add(data.data());
        appointmentKeys = appointments[0].keys.toList();
      });
    } on Exception catch (e) {
      // TODO
    }

    print(appointmentKeys.toString());
  }

  String convertDateTimeDisplay(String date) {
    final DateFormat displayFormater = DateFormat('yyyy-MM-dd HH:mm:ss.SSS');
    final DateFormat serverFormater = DateFormat('dd-MM-yyyy');
    final DateTime displayDate = displayFormater.parse(date);
    final String formatted = serverFormater.format(displayDate);
    return formatted;
  }

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
      child: Container(
        height: 200,
        child: ListView.builder(
            itemCount: appointmentKeys.length,
            itemBuilder: (BuildContext context, int index) {
              int count = index + 1;
              String title = count.toString();

              String onlyDate = convertDateTimeDisplay(appointments[0]
                      [appointmentKeys[index]]["date"]
                  .toDate()
                  .toString());

              return ListTile(
                leading: Text(title),
                trailing: Text(
                  appointments[0][appointmentKeys[index]]["time"].toString(),
                  style: TextStyle(
                      color: Color.fromARGB(255, 0, 0, 0), fontSize: 15),
                ),
                title: Text(appointments[0][appointmentKeys[index]]["subject"] +
                    "\n" +
                    "Dr." +
                    appointments[0][appointmentKeys[index]]["doctor"]),
                subtitle: Text(onlyDate),
              ).pOnly(bottom: 20);
            }),
      ).p12(),
    ).pOnly(top: 0, left: 35, right: 40, bottom: 35);
  }
}

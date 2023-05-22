// ignore_for_file: public_member_api_docs, sort_constructors_first, curly_braces_in_flow_control_structures, unused_local_variable, unnecessary_new, prefer_interpolation_to_compose_strings, non_constant_identifier_names
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

class EletronicHealthRecord extends StatefulWidget {
  @override
  State<EletronicHealthRecord> createState() => _EletronicHealthRecord();
}

class _EletronicHealthRecord extends State<EletronicHealthRecord> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // bottomNavigationBar: Example(),
      backgroundColor: MyThemes.boxEdge,
      appBar: AppBar(
        title: "Health Record".text.xl3.black.make(),
        backgroundColor: Colors.white,
        elevation: 0.0,
        centerTitle: true,
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(children: [
            PatientInitialInfo(),
            20.squareBox,
            "Personal".text.bold.xl3.make(),
            HealthReport(),
            "Health".text.bold.xl3.make(),
            HealthRelated(),
            "Vitals Today".text.bold.xl3.make(),
            VitalsToday(),
            "Check Up History".text.bold.xl3.make(),
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
            ],
          ).pOnly(left: 24),
        ],
      ).pOnly(right: 32, left: 32, top: 0, bottom: 15),
    );
  }
}

class HealthReport extends StatefulWidget {
  @override
  State<HealthReport> createState() => _HealthReportState();
}

class _HealthReportState extends State<HealthReport> {
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
    String patient_name = "Name: " +
        userList[0]["first-name"].toString() +
        " " +
        userList[0]["last-name"].toString();
    String patient_sex = "Sex: " + userList[0]["sex"];
    String patient_age =
        "Age: " + parseAge(userList[0]["date-of-birth"].toString()) + " years";
    String patient_height = "Height: " + userList[0]["height"] + " cm";
    String patient_weight = "Weight: " + userList[0]["weight"] + " kg";
    String patient_bloodGroup = "Blood Group: " + userList[0]["blood-group"];

    return Container(
      height: 200,
      width: double.infinity,
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: Color.fromARGB(255, 47, 43, 43),
          blurRadius: 15.0, // soften the shadow
          spreadRadius: 5.0, //extend the shadow
          offset: Offset(
            5.0, // Move to right 5  horizontally
            5.0, // Move to bottom 5 Vertically
          ),
        )
      ], color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            patient_name.text.xl.make(),
            patient_age.text.xl.make(),
            patient_height.text.xl.make(),
            patient_weight.text.xl.make(),
            patient_bloodGroup.text.red700.xl.make(),
          ]).p32(),
    ).p16();
  }
}

class HealthRelated extends StatefulWidget {
  @override
  State<HealthRelated> createState() => _HealthRelatedState();
}

class _HealthRelatedState extends State<HealthRelated> {
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
    String allergy_info = userList[0]["allergy"];
    String allergy_detail = "Allergies: " + userList[0]["allergy-detail"];
    String asthama_info = userList[0]["asthama"];
    String asthama_details = "Asthama: " + userList[0]["asthama-detail"];
    String diabetes_info = userList[0]["diabetes"];
    String diabetes_details = "Diabetes: " + userList[0]["diabetes-detail"];
    String seizures_info = userList[0]["seizures"];
    String seizures_detail = "Seizures: " + userList[0]["seizure-detail"];
    String otherIllness = userList[0]["other-illness"];

    if (allergy_info == "no-allergy") {
      allergy_detail = "Allergies: No";
    }
    if (asthama_info == "no-asthama") {
      asthama_details = "Asthama: No";
    }
    if (diabetes_info == "no-diabetes") {
      diabetes_details = "Diabetes: No";
    }
    if (seizures_info == "no-seizures") {
      seizures_detail = "Seizures: No";
    }
    if (otherIllness == "") {
      otherIllness = "Others: No";
    } else {
      otherIllness = "Others: " + otherIllness;
    }

    return Container(
      height: 200,
      width: double.infinity,
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: Color.fromARGB(255, 47, 43, 43),
          blurRadius: 15.0, // soften the shadow
          spreadRadius: 5.0, //extend the shadow
          offset: Offset(
            5.0, // Move to right 5  horizontally
            5.0, // Move to bottom 5 Vertically
          ),
        )
      ], color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            allergy_detail.text.xl.make(),
            asthama_details.text.xl.make(),
            diabetes_details.text.xl.make(),
            seizures_detail.text.xl.make(),
            otherIllness.text.xl.make()
          ]).p32(),
    ).p16();
  }
}

class VitalsToday extends StatefulWidget {
  @override
  State<VitalsToday> createState() => _VitalsTodayState();
}

class _VitalsTodayState extends State<VitalsToday> {
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
    String bloodPressure = "Blood Pressure: " +
        userList[0]["systolic"] +
        "/" +
        userList[0]["diastolic"];
    String heartRate = "Heart Rate: " + userList[0]["heart-rate"] + " bpm";
    String bloodOxygen = "Blood Oxygen: " + userList[0]["blood-oxygen"] + "%";
    String temperature = "Temperature: " + userList[0]["temperature"] + " °F";

    if (bloodPressure == "") {
      bloodPressure = "Not Updated Today";
    }
    if (heartRate == "") {
      heartRate = "Not Updated Today";
    }
    if (bloodOxygen == "") {
      bloodOxygen = "Not Updated Today";
    }
    if (temperature == "") {
      temperature = "Not Updated Today";
    }

    return Container(
      height: 200,
      width: double.infinity,
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: Color.fromARGB(255, 47, 43, 43),
          blurRadius: 15.0, // soften the shadow
          spreadRadius: 5.0, //extend the shadow
          offset: Offset(
            5.0, // Move to right 5  horizontally
            5.0, // Move to bottom 5 Vertically
          ),
        )
      ], color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            bloodPressure.text.xl.red700.make(),
            heartRate.text.xl.make(),
            bloodOxygen.text.xl.red700.make(),
            temperature.text.xl.make(),
          ]).p32(),
    ).p16();
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyThemes {
  static Color loginColor = Color(0xff27E1C1);
  static Color background = Color(0xffFFEBEB);
  static Color shadows = Color.fromARGB(255, 211, 179, 179);
  static Color textColor = Color(0xff121211);
  static Color googleButton = Color(0xffFAF9F6);
  static Color darkBlueish = Color.fromARGB(255, 65, 79, 151);
  static Color boxEdge = Color.fromARGB(255, 86, 201, 138);
  static Color btnBox = Color(0xff6DA9E4);
  static Color docIcon = Color(0xff8294C4);
  static Color docIconWhite = Color(0xffF6F1F1);

  static Color calanderSelection = Color.fromARGB(138, 39, 225, 194);

  AppBarTheme currentTheme() {
    return AppBarTheme(
        backgroundColor: Colors.white,
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.black),
        titleTextStyle: TextStyle(
          color: Colors.black,
          fontSize: 20,
          fontFamily: GoogleFonts.poppins().fontFamily,
        ));
  }

  AppBarTheme searchTheme() {
    return AppBarTheme(
        backgroundColor: MyThemes.boxEdge,
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.black),
        titleTextStyle: TextStyle(
          color: Colors.black,
          fontSize: 20,
          fontFamily: GoogleFonts.poppins().fontFamily,
        ));
  }
}

class GetStudentName extends StatelessWidget {
  List userList = [12];

  void getData() {
    final db = FirebaseFirestore.instance;

    for (var i = 0; i < 1; i++) {
      userList.add(db.collection("users").doc("user$i").get());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Text(userList[0].toString());
  }
}

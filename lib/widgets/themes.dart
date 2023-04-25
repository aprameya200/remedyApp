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
}

// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:remedy_app/pages/doctor/doctor-page.dart';
import 'package:remedy_app/pages/patient/medicine.dart';
import 'package:remedy_app/pages/patient/mesages.dart';
import 'package:remedy_app/pages/patient/patients_page.dart';
import 'package:remedy_app/pages/patient/searchDoctor.dart';
import 'package:bottom_bar_page_transition/bottom_bar_page_transition.dart';

import '../widgets/themes.dart';
import 'doctor/doctor-message.dart';
import 'doctor/report-page.dart';

// void main() => runApp(MaterialApp(
//     builder: (context, child) {
//       return Directionality(textDirection: TextDirection.ltr, child: child!);
//     },
//     // title: 'GNav',
//     theme: ThemeData(
//       primaryColor: Colors.grey[800],
//     ),
//     home: Example()));

class DoctorSkeletonPage extends StatefulWidget {
  @override
  _DoctorSkeletonPageState createState() => _DoctorSkeletonPageState();
}

class _DoctorSkeletonPageState extends State<DoctorSkeletonPage> {
  int _selectedIndex = 2;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.w600);
  static const List<Widget> _widgetOptions = <Widget>[
    SearchDoctorPage(),
    ReportPage(
      dummy: null,
    ),
    DoctorPage(
      dummy: null,
    ),
    DoctorMessagePage(
      secondUser: '',
      currentUser: '',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // appBar: AppBar(
      //   elevation: 20,
      //   title: const Text('GoogleNavBar'),
      // ),
      //from here//from here//from here//from here//from here//from here//from here
      //from here
      //from here
      //from here
      //from here
      //from here
      body: Center(
        child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: _widgetOptions.elementAt(_selectedIndex)),
      ),
      // child: _widgetOptions.elementAt(_selectedIndex), //from here

      bottomNavigationBar: Container(
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
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: GNav(
              rippleColor: Colors.grey[300]!,
              hoverColor: Colors.grey[100]!,
              gap: 8,
              activeColor: Colors.black,
              iconSize: 30,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              duration: Duration(milliseconds: 400),
              tabBackgroundColor: MyThemes.btnBox!,
              color: Colors.black,
              // ignore: prefer_const_literals_to_create_immutables
              tabs: [
                // ignore: prefer_const_constructors
                GButton(
                  icon: CupertinoIcons.search_circle_fill,
                  text: 'Search',
                ),
                GButton(
                  icon: CupertinoIcons.doc_plaintext,
                  text: 'Reports',
                ),
                GButton(
                  icon: CupertinoIcons.profile_circled,
                  text: 'Profile',
                ),
                GButton(
                  icon: CupertinoIcons.mail_solid,
                  text: 'Inbox',
                ),
              ],
              selectedIndex: _selectedIndex,
              onTabChange: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}

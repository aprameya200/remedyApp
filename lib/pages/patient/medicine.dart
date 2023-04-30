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

import '../../widgets/themes.dart';

class MedicniePage extends StatefulWidget {
  final dummy;

  const MedicniePage({super.key, required this.dummy});

  @override
  State<MedicniePage> createState() => _MedicniePageState();
}

class _MedicniePageState extends State<MedicniePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // bottomNavigationBar: Example(),
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: "Medicines".text.xl3.black.make(),
          backgroundColor: Colors.white,
          elevation: 0.0,
          centerTitle: true,
        ),
        body: Container(
          child: Text("No Presciption",
              style: TextStyle(color: Colors.black54, fontSize: 40)),
        ).p16());
  }
}

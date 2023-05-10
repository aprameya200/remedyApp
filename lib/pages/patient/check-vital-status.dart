// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: unused_import

import 'package:age_calculator/age_calculator.dart';
import 'package:animate_gradient/animate_gradient.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:social_login_buttons/social_login_buttons.dart';
import 'package:velocity_x/velocity_x.dart';

import 'package:remedy_app/data/patient-data.dart';
import 'package:remedy_app/pages/login_page.dart';
import 'package:remedy_app/pages/patient/vitals.dart';
import 'package:remedy_app/pages/sign-up_page.dart';

//Calander
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../../utils/routes.dart';
import '../../widgets/themes.dart';

class CheckVitalStatus {
  final String systolic;
  final String diastolic;

  final String heartRate;

  final String bloodOxygen;

  final String temperature;

  CheckVitalStatus({
    required this.systolic,
    required this.diastolic,
    required this.heartRate,
    required this.bloodOxygen,
    required this.temperature,
  });

  String getBloodPressureStatus() {
    if (int.parse(systolic) <= 120 && int.parse(diastolic) <= 80) {
      return "Normal";
    } else if (int.parse(systolic) > 120 &&
        int.parse(systolic) < 129 &&
        int.parse(diastolic) <= 80) {
      return "Elevated";
    } else if (int.parse(systolic) >= 130 &&
        int.parse(systolic) < 139 &&
        int.parse(diastolic) > 80 &&
        int.parse(diastolic) < 89) {
      return "High";
    } else {
      return "Very High";
    }
  }
}

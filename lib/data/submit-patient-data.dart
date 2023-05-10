// ignore_for_file: public_member_api_docs, sort_constructors_first, unnecessary_this
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PatientPersonalData {
  final String fname;
  final String lname;
  final String dob;
  final String address;
  final String phone;
  final String height;
  final String weight;
  final String sex;
  final String bloodGroup;

  PatientPersonalData({
    required this.fname,
    required this.lname,
    required this.dob,
    required this.address,
    required this.phone,
    required this.height,
    required this.weight,
    required this.sex,
    required this.bloodGroup,
  });

  Future submitData() async {
    final db = FirebaseFirestore.instance;

    final user = FirebaseAuth.instance.currentUser!.email;

    try {
      await FirebaseFirestore.instance
          .collection("patient")
          .doc(user.toString())
          .set({
        "first-name": this.fname,
        "last-name": this.lname,
        "date-of-birth": this.dob,
        "address": this.address,
        "phone": this.phone,
        "height": this.height,
        "weight": this.weight,
        "sex": this.sex,
        "blood-group": this.bloodGroup,
        "systolic": "",
        "diastolic": "",
        "heart-rate": "",
        "blood-oxygen": "",
        "temperature": "",
      });
    } on FirebaseAuthException catch (e) {
      print(e);
    }
  }

  Future updateData() async {
    final db = FirebaseFirestore.instance;

    final user = FirebaseAuth.instance.currentUser!.email;

    try {
      await FirebaseFirestore.instance
          .collection("patient")
          .doc(user.toString())
          .update({
        "first-name": this.fname,
        "last-name": this.lname,
        "date-of-birth": this.dob,
        "address": this.address,
        "phone": this.phone,
        "height": this.height,
        "weight": this.weight,
        "sex": this.sex,
        "blood-group": this.bloodGroup,
      });
    } on FirebaseAuthException catch (e) {
      print(e);
    }
  }
}

class PatientHealthData {
  final String allergy;
  final String allergy_specific;
  final String asthama;
  final String asthama_specific;
  final String diabetes;
  final String diabetes_specific;
  final String seizures;
  final String seizures_specific;

  final String others;

  PatientHealthData({
    required this.allergy,
    required this.allergy_specific,
    required this.asthama,
    required this.asthama_specific,
    required this.diabetes,
    required this.diabetes_specific,
    required this.seizures,
    required this.seizures_specific,
    required this.others,
  });

  Future submitData() async {
    final db = FirebaseFirestore.instance;

    final user = FirebaseAuth.instance.currentUser!.email;

    try {
      await FirebaseFirestore.instance
          .collection("patient")
          .doc(user.toString())
          .update({
        "allergy": this.allergy,
        "allergy-detail": this.allergy_specific,
        "asthama": this.asthama,
        "asthama-detail": this.asthama_specific,
        "diabetes": this.diabetes,
        "diabetes-detail": this.diabetes_specific,
        "seizures": this.seizures,
        "seizure-detail": this.seizures_specific,
        "other-illness": this.others,
      });
    } on FirebaseAuthException catch (e) {
      print(e);
    }
  }

  Future update() async {
    final db = FirebaseFirestore.instance;

    final user = FirebaseAuth.instance.currentUser!.email;

    try {
      await FirebaseFirestore.instance
          .collection("patient")
          .doc(user.toString())
          .update({
        "allergy": this.allergy,
        "allergy-detail": this.allergy_specific,
        "asthama": this.asthama,
        "asthama-detail": this.asthama_specific,
        "diabetes": this.diabetes,
        "diabetes-detail": this.diabetes_specific,
        "seizures": this.seizures,
        "seizure-detail": this.seizures_specific,
        "other-illness": this.others,
      });
    } on FirebaseAuthException catch (e) {
      print(e);
    }
  }
}

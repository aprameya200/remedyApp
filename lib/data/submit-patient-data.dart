// ignore_for_file: public_member_api_docs, sort_constructors_first
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

    // try {
    //   await FirebaseFirestore.instance
    //       .collection("user")
    //       .doc(emailController.text.trim())
    //       .set({
    //     "email": emailController.text.trim(),
    //     "fullname": fullnameController.text.trim(),
    //   });
    // } on FirebaseAuthException catch (e) {}
  }
}

class PatientHealthData {
  final String allergy;
  final String asllergy_specific;
  final String asthama;
  final String asthama_specific;
  final String diabetes;
  final String diabetes_specific;
  final String seizures;
  final String seizures_specific;

  final String others;

  PatientHealthData({
    required this.allergy,
    required this.asllergy_specific,
    required this.asthama,
    required this.asthama_specific,
    required this.diabetes,
    required this.diabetes_specific,
    required this.seizures,
    required this.seizures_specific,
    required this.others,
  });
}

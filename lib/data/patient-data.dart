// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class GetPatientData {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  late final currentPatient;

  Future getPatientData() async {
    User? user = _firebaseAuth.currentUser;

    final data = await FirebaseFirestore.instance //here
        .collection("patient")
        .doc(user!.email.toString())
        .get();

    data.data()!["first-name"];
  }
}

class Patient {
  final String fname;
  final String lname;
  final String dob;
  final String address;
  final String phone;
  final String height;
  final String weight;
  final String sex;
  final String bloodGroup;

  final String allergy;
  final String allergy_specific;
  final String asthama;
  final String asthama_specific;
  final String diabetes;
  final String diabetes_specific;
  final String seizures;
  final String seizures_specific;
  final String others;

  Patient(
      {required this.fname,
      required this.lname,
      required this.dob,
      required this.address,
      required this.phone,
      required this.height,
      required this.weight,
      required this.sex,
      required this.bloodGroup,
      required this.allergy,
      required this.allergy_specific,
      required this.asthama,
      required this.asthama_specific,
      required this.diabetes,
      required this.diabetes_specific,
      required this.seizures,
      required this.seizures_specific,
      required this.others});

  Map<String, dynamic> toJSON() => {
        "first-name": this.fname,
        "last-name": this.lname,
        "date-of-birth": this.dob,
        "address": this.address,
        "phone": this.phone,
        "height": this.height,
        "weight": this.weight,
        "sex": this.sex,
        "blood-group": this.bloodGroup,
        "allergy": this.allergy,
        "allergy-detail": this.allergy_specific,
        "asthama": this.asthama,
        "asthama-detail": this.asthama_specific,
        "diabetes": this.diabetes,
        "diabetes-detail": this.diabetes_specific,
        "seizures": this.seizures,
        "seizure-detail": this.seizures_specific,
        "other-illness": this.others,
      };

  static Patient fromJSON(Map<String, dynamic> json) => Patient(
        fname: json["first-name"],
        lname: json["last-name"],
        dob: json["date-of-birth"],
        address: json["address"],
        phone: json["phone"],
        height: json["height"],
        weight: json["weight"],
        sex: json["sex"],
        bloodGroup: json["blood-group"],
        allergy: json["allergy"],
        allergy_specific: json["allergy-detail"],
        asthama: json["asthama"],
        asthama_specific: json["asthama-detail"],
        diabetes: json["diabetes"],
        diabetes_specific: json["diabetes-detail"],
        seizures: json["seizures"],
        seizures_specific: json["seizures-detail"],
        others: json["other-illness"],
      );
}

class DatabaseManager {
  final CollectionReference profileList =
      FirebaseFirestore.instance.collection("patient");

  Future getUsersList() async {
    User? user = FirebaseAuth.instance.currentUser;

    List itemslist = [];

    final data = await profileList.doc(user!.email.toString()).get();

    itemslist.add(data.data);
  }
}

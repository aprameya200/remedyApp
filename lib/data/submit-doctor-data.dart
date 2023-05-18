// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SubmitDoctorData {
  final String fname;
  final String lname;
  final String dob;
  final String sex;
  final String address;
  final String phone;
  final String department;
  final String experience;

  SubmitDoctorData({
    required this.fname,
    required this.lname,
    required this.sex,
    required this.dob,
    required this.address,
    required this.phone,
    required this.department,
    required this.experience,
  });

  Future submit() async {
    final db = FirebaseFirestore.instance;

    final user = FirebaseAuth.instance.currentUser!.email;

    try {
      await FirebaseFirestore.instance
          .collection("doctor")
          .doc(user.toString())
          .set({
        "first-name": this.fname,
        "last-name": this.lname,
        "date-of-birth": this.dob,
        "address": this.address,
        "phone": this.phone,
        "sex": this.sex,
        "department": this.department,
        "experience": this.experience,
        "patients": "0",
        "consulatations": "0",
        "in-progress": "0",
        "reports": "0",
        "about": ""
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
          .collection("doctor")
          .doc(user.toString())
          .update({
        "first-name": this.fname,
        "last-name": this.lname,
        "date-of-birth": this.dob,
        "address": this.address,
        "phone": this.phone,
        "sex": this.sex,
        "department": this.department,
        "experience": this.experience
      });
    } on FirebaseAuthException catch (e) {
      print(e);
    }
  }
}

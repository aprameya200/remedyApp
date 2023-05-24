import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class GetReports {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Map<String, dynamic> consultancyData = {};

  Future getReports() async {
    User? user = _firebaseAuth.currentUser;

    var data = await FirebaseFirestore.instance //here
        .collection("consultancy")
        .doc(user!.email.toString()) //need to change this
        .get();

    consultancyData = data.data()!;
  }
}

class SubmitReport {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  List reportString = [];

  Future submitReport() async {
    User? user = _firebaseAuth.currentUser;

    await FirebaseFirestore.instance //here
        .collection("health-record")
        .doc(user!.email.toString()) //need to change this
        .set({});
  }
}

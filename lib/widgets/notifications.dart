// ignore_for_file: public_member_api_docs, sort_constructors_first
// // ignore_for_file: prefer_const_constructors

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class NotificationAPI {
  static void trigger_notification() {
    AwesomeNotifications().createNotification(
        content: NotificationContent(
      id: 10,
      channelKey: "basic",
      title: 'Hello',
      body: 'hi',
    ));
  }
}

class FeedNotification {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  String userEmail = "ludenstrky@gmail.com";

  Map<String, dynamic> userPresciptions = {};

  Map<String, dynamic> medicines = {};

  List meds = [];

  List allMedicine = [];

  Future getNotifications() async {
    User? user = _firebaseAuth.currentUser;

    var data = await FirebaseFirestore.instance //here
        .collection("notifications")
        .doc(userEmail) //need to change this
        .get();

    int number = data.data()!.length;
    meds.add(data.data()!);

    for (var i = 0; i < meds[0].length; i++) {
      String notification_number = "Notification-" + i.toString();

      allMedicine.add(meds[0][notification_number]);
      // print(meds[0][notification_number]);
    }
  }

  Future precriptions() async {
    User? user = _firebaseAuth.currentUser;

    Map<String, dynamic> toGetCount = {};
    int prescriptionCount = 0;

    final data = await FirebaseFirestore.instance //here
        .collection("prescriptions")
        .doc(userEmail) //need to change this
        .get();

    userPresciptions = data.data()!;
    seperateMedicine(userPresciptions);
  }

  void seperateMedicine(Map<String, dynamic> data) {
    List<dynamic> allValues =
        data.values.toList(); //saves all value of different prescription

    int count = 1;

    for (var j = 0; j < allValues.length; j++) {
      allMedicine.add(allValues[j].keys.toString());
      // print(allMedicine[j]);
    }

    for (var j = 0; j < allValues.length; j++) {
      // print(allValues[j].keys.toString() + "top");
      // print(allMedicine[j].toString() + "bottom");

      String medicineValue = "Medicine-" + count.toString();

      for (var i = 0; i < allValues[j].length; i++) {
        print(allMedicine[i]);
        print(allValues[i]["Medicine-2"]);
        // medicines[medicineValue] = allValues[i][allMedicine[i]];
        // count++;

        // print(allValues[i][allMedicine[i]]);
      }

      // print(medicines.toString());
    }
  }
}

class FillNotification {
  String userID;
  String medicine_name;
  String times_per_day;
  FillNotification({
    required this.userID,
    required this.medicine_name,
    required this.times_per_day,
  });

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future setNotification() async {
    User? user = _firebaseAuth.currentUser;

    var data = await FirebaseFirestore.instance //here
        .collection("notifications")
        .doc(userID) //need to change this
        .get();

    int number = data.data()!.length;
    String notification_number = "Notification-" + number.toString();

    await FirebaseFirestore.instance //here
        .collection("notifications")
        .doc(userID) //need to change this
        .update({
      notification_number: {
        "patient_id": userID,
        "name": medicine_name,
        "times-per-day": times_per_day
      }
    });
  }
}

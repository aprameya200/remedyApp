// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:cloud_firestore/cloud_firestore.dart';

class PatientList {
  String patientEmail = "";

  List doctors = [];

  Map<String, dynamic> doctorFullnames = {};

  List chatDoctors = [];
  List chatIds = [];

  String hi = "hi";

  void changeValue() {
    hi = "Bye";
  }

  Future<List<DocumentSnapshot>> getAllDocuments() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection(
            'patient') // Replace 'your_collection' with your actual collection name
        .get();

    return querySnapshot.docs;
  }

  void setDoctors(String doctor) {
    doctors.add(doctor);
  }

  List getAllDoctorEmails() {
    return doctors;
  }

  Future<void> addDoctorDocumentIds() async {
    List<DocumentSnapshot> documents = await getAllDocuments();

    for (var document in documents) {
      String documentId = document.id;
      Object? data = document.data();

      setDoctors(documentId);
      doctorFullnames[documentId] =
          document["first-name"] + " " + document["last-name"];
    }
  }

  List getAllDoctorChat() {
    return chatDoctors;
  }

  String chatRoomId(String user1, String user2) {
    final sortedInputs = [user1, user2]..sort();
    final concatenatedString = sortedInputs.join();
    return concatenatedString;
  }

  Future getChats() async {
    for (var i = 0; i < doctors.length; i++) {
      String chatID = chatRoomId(patientEmail, doctors[i]);

      print(chatID);

      DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
          .collection('chatroom')
          .doc(chatID)
          .get();

      print(documentSnapshot.id + " is the id");

      if (documentSnapshot.exists != null) {
        // Document exists, do something
        chatIds.add(chatID);
      } else {
        print(chatID + " does not exist");
      }
    }
  }

  Future<List<DocumentSnapshot>> getAllChatIds() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection(
            'chats') // Replace 'your_collection' with your actual collection name
        .get();

    return querySnapshot.docs;
  }

  Future<void> addChatIds() async {
    List<DocumentSnapshot> documents = await getAllChatIds();

    for (var document in documents) {
      String documentId = document.id;
      Object? data = document.data();

      chatIds.add(documentId);
    }
  }

  String getChatDoctorName(String chatID) {
    String doctorName = "";

    for (var i = 0; i < doctors.length; i++) {
      if (chatID.contains(doctors[i])) {
        doctorName = doctorFullnames[doctors[i]];
        break;
      }
    }

    return doctorName;
  }
}

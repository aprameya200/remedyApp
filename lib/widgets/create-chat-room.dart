// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CreateChat {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String user1;
  String user2;
  CreateChat({
    required this.user1,
    required this.user2,
  });

  void createChatRoom() async {
    User? user = _firebaseAuth.currentUser;

    Map<String, dynamic> messages = {
      "sendby": user!.email.toString(),
      "message": "Appointment Booked!",
      "type": "text",
      "time": DateTime.now().toString(),
    };

    await _firestore
        .collection('chatroom')
        .doc(chatRoomId()) //from above and below
        .collection('chats')
        .add(messages);
  }

  String chatRoomId() {
    final sortedInputs = [user1, user2]..sort();
    final concatenatedString = sortedInputs.join();
    return concatenatedString;
  }
}

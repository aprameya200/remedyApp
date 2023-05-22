// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:animate_gradient/animate_gradient.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:remedy_app/pages/patient/vitals.dart';
import 'package:social_login_buttons/social_login_buttons.dart';
import 'package:velocity_x/velocity_x.dart';

import 'package:remedy_app/pages/sign-up_page.dart';
import 'package:crypto/crypto.dart';

//Calander
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../../widgets/themes.dart';

class MessagePage extends StatefulWidget {
  final dummy;

  const MessagePage({super.key, required this.dummy});

  @override
  State<MessagePage> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  List patient_data = [];

  String generateHash(String input1, String input2) {
    final sortedInputs = [input1, input2]..sort();
    final concatenatedString = sortedInputs.join();
    return concatenatedString;
  }

  void value() {
    // final string1 = "ludensth@gmail.com";
    // final string2 = "ludenstrky@gmail.com";

    final string2 = "ludensth@gmail.com";
    final string1 = "ludenstrky@gmail.com";
    final hashValue = generateHash(string1, string2);
    print(hashValue);
  }

  String chatRoomId(String user1, String user2) {
    final sortedInputs = [user1, user2]..sort();
    final concatenatedString = sortedInputs.join();
    return concatenatedString;
  }

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future getChatUser2() async {
    final data = await FirebaseFirestore.instance //here
        .collection("patient")
        .doc("ludenstrky@gmail.com") //need to change this
        .get();

    setState(() {
      patient_data.add(data.data());
    });
  }

  @override
  Widget build(BuildContext context) {
    User? user = _firebaseAuth.currentUser;
    value();

    String roomId = chatRoomId("ludenstrky@gmail.com", user!.email.toString());

    return Scaffold(
      // bottomNavigationBar: Example(),
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: "Messages".text.xl3.black.make(),
        backgroundColor: Colors.white,
        elevation: 0.0,
        centerTitle: true,
      ),
      body: ChatRoom(
        chatRoomId: roomId,
        userMap: patient_data,
      ),
    );
  }
}

class ChatRoom extends StatelessWidget {
  final List userMap;
  final String chatRoomId;

  ChatRoom({required this.chatRoomId, required this.userMap});

  final TextEditingController _message = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  void onSendMessage() async {
    User? user = _firebaseAuth.currentUser;

    if (_message.text.isNotEmpty) {
      Map<String, dynamic> messages = {
        "sendby": user!.email.toString(),
        "message": _message.text,
        "type": "text",
        "time": DateTime.now().toString(),
      };

      _message.clear();
      await _firestore
          .collection('chatroom')
          .doc(chatRoomId)
          .collection('chats')
          .add(messages);
    } else {
      print("Enter Some Text");
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    onSendMessage();

    return SingleChildScrollView(
        child: Column(
      children: [
        Container(
          height: 620,
          width: size.width,
          child: StreamBuilder<QuerySnapshot>(
            stream: _firestore
                .collection('chatroom')
                .doc(chatRoomId)
                .collection('chats')
                .orderBy("time", descending: false)
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.data != null) {
                return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    Map<String, dynamic> map = snapshot.data!.docs[index].data()
                        as Map<String, dynamic>;
                    return messages(size, map, context);
                  },
                );
              } else {
                return Container();
              }
            },
          ),
        ),
        Container(
          height: size.height / 10,
          width: size.width,
          alignment: Alignment.center,
          child: Container(
            height: size.height / 12,
            width: size.width / 1.1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: size.height / 17,
                  width: size.width / 1.3,
                  child: TextField(
                    controller: _message,
                    decoration: InputDecoration(
                        hintText: "Send Message",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        )),
                  ),
                ),
                IconButton(icon: Icon(Icons.send), onPressed: onSendMessage),
              ],
            ),
          ),
        ),
      ],
    ));
  }

  Widget messages(Size size, Map<String, dynamic> map, BuildContext context) {
    final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
    User? user = _firebaseAuth.currentUser;
    return map['type'] == "text"
        ? Container(
            width: size.width,
            alignment: map['sendby'] == user!.email.toString()
                ? Alignment.centerRight
                : Alignment.centerLeft,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 14),
              margin: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.blue,
              ),
              child: Text(
                map['message'],
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ),
          )
        : Container(
            height: size.height / 2.5,
            width: size.width,
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
            alignment: map['sendby'] == user!.email.toString()
                ? Alignment.centerRight
                : Alignment.centerLeft,
            child: InkWell(
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => ShowImage(
                    imageUrl: map['message'],
                  ),
                ),
              ),
              child: Container(
                height: size.height / 2.5,
                width: size.width / 2,
                decoration: BoxDecoration(border: Border.all()),
                alignment: map['message'] != "" ? null : Alignment.center,
                child: map['message'] != ""
                    ? Image.network(
                        map['message'],
                        fit: BoxFit.cover,
                      )
                    : CircularProgressIndicator(),
              ),
            ),
          );
  }
}

class ShowImage extends StatelessWidget {
  final String imageUrl;

  const ShowImage({required this.imageUrl, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        color: Colors.black,
        child: Image.network(imageUrl),
      ),
    );
  }
}

//
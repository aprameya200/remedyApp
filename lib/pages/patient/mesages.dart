// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:animate_gradient/animate_gradient.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto/crypto.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:remedy_app/widgets/notifications.dart';
import 'package:social_login_buttons/social_login_buttons.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:velocity_x/velocity_x.dart';

import 'package:remedy_app/pages/patient/vitals.dart';
import 'package:remedy_app/pages/sign-up_page.dart';
import 'package:remedy_app/widgets/get-all-doctors.dart';

//Calander
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../../widgets/themes.dart';

//user 2 data must be taken from another collection
//user 2 data must be taken from another collection
//user 2 data must be taken from another collection
//user 2 data must be taken from another collection
//user 2 data must be taken from another collection
//user 2 data must be taken from another collection
//user 2 data must be taken from another collection

class MessagePage extends StatefulWidget {
  final String currentUser;

  final String secondUser;

  const MessagePage(
      {super.key, required this.currentUser, required this.secondUser});

  @override
  State<MessagePage> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> with WidgetsBindingObserver {
  List user_two_data = [];
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // String user2_email = "ludensth@gmail.com";
  // String user2_type = "doctor";

  bool isLoading = false;

  List chatIDs = [];

  DoctorList docs = DoctorList();

  String phone = "";

  @override
  void initState() {
    super.initState();
    // getChatUser2();

    // user2_email = widget.secondUser;
    // getID();

    checkDcotors();
  }

  Future checkDcotors() async {
    User? user = _firebaseAuth.currentUser;

    await docs.addDoctorDocumentIds();
    docs.patientEmail = user!.email.toString();
    await docs.getChats();

    setState(() {
      chatIDs = docs.chatIds;
    });
  }

  String chatRoomId(String user1, String user2) {
    final sortedInputs = [user1, user2]..sort();
    final concatenatedString = sortedInputs.join();
    return concatenatedString;
  }

  // Future getChatUser2() async {
  //   final data = await FirebaseFirestore.instance //here
  //       .collection(user2_type)
  //       .doc(user2_email) //need to change this
  //       .get();

  //   setState(() {
  //     user_two_data.add(data.data());
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    User? user = _firebaseAuth.currentUser;

    // String roomId = chatRoomId(user2_email, user!.email.toString());

    return Scaffold(
      // bottomNavigationBar: Example(),
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        title: "Messages".text.xl3.black.make(),
        backgroundColor: Colors.white,
        elevation: 0.0,
        centerTitle: true,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          user_two_data != null
              ? Container(
                  height: 660,
                  color: Color.fromARGB(0, 244, 67, 54),
                  child: ListView.builder(
                      itemCount: chatIDs.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                            onTap: () {
                              NotificationAPI.trigger_notification();

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ChatRoom(
                                          chatRoomId: chatIDs[index],
                                          Phone: docs
                                              .getDoctorNumber(chatIDs[index]),
                                        )),
                              );
                            },
                            leading: const Icon(Icons.message),
                            title: docs
                                .getChatDoctorName(chatIDs[index])
                                .text
                                .make());
                      }),
                )
              : Container(),
        ],
      ),
    );
  }
}

class ChatRoom extends StatelessWidget {
  // final List userMap;
  final String chatRoomId;
  final String Phone;

  ChatRoom({
    Key? key,
    required this.chatRoomId,
    required this.Phone,
  }) : super(key: key);

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

    return Scaffold(
      body: SingleChildScrollView(
          child: Column(
        children: [
          Container(
            height: 760,
            width: size.width,
            child: StreamBuilder<QuerySnapshot>(
              stream: _firestore
                  .collection('chatroom')
                  .doc(chatRoomId)
                  .collection('chats')
                  .orderBy("time", descending: false)
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.data != null) {
                  return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      Map<String, dynamic> map = snapshot.data!.docs[index]
                          .data() as Map<String, dynamic>;
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
                    width: size.width / 1.5,
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
                  IconButton(
                      onPressed: () async {
                        final Uri url = Uri(scheme: 'tel', path: Phone);

                        if (await canLaunchUrl(url)) {
                          await launchUrl(url);
                        }
                      },
                      icon: Icon(Icons.call))
                ],
              ),
            ),
          ),
        ],
      )),
    );
  }

  void makePhoneCall(String phoneNumber) async {
    String url = 'tel:$phoneNumber';

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      print('Could not make the phone call');
    }
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

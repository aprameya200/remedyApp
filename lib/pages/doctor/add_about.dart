// ignore_for_file: public_member_api_docs, sort_constructors_first, prefer_const_literals_to_create_immutables, unnecessary_new, use_build_context_synchronously
// ignore_for_file: prefer_const_constructors

import 'package:flutter_fast_forms/flutter_fast_forms.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:remedy_app/pages/patient/validate-patient.dart';

import 'package:velocity_x/velocity_x.dart';

import '../../utils/routes.dart';
import '../../widgets/singleton-widget.dart';
import '../../widgets/themes.dart';
import 'package:quickalert/quickalert.dart';

class AddAboutDoctor extends StatefulWidget {
  @override
  State<AddAboutDoctor> createState() => _AddAboutDoctorState();
}

class _AddAboutDoctorState extends State<AddAboutDoctor> {
  List userList = [];

  @override
  initState() {
    super.initState();

    aboutController.text = userData[0]["about"];
  }

  // List userData = Singleton.userData;

  bool changedButton = false;

  final aboutController = new TextEditingController();

  @override
  void dispose() {
    aboutController.dispose();

    super.dispose();
  }

  List userData = Singleton.userData;

  @override
  final _formKey = GlobalKey<FormState>();

  Validate validate = new Validate();

  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: MyThemes.btnBox,
        body: Container(
          child: SafeArea(
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Padding(
                  padding: EdgeInsets.all(30.0),
                  child: Column(
                    children: [
                      "About Info".text.xl4.color(MyThemes.textColor).make(),
                      20.squareBox,
                      Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                  color: MyThemes.shadows,
                                  blurRadius: 20.0,
                                  offset: Offset(0, 10))
                            ]),
                        child: Column(
                          children: [
                            5.squareBox,
                            15.squareBox,
                            FastTextField(
                              keyboardType: TextInputType.multiline,
                              maxLines: null,
                              minLines: 10,
                              initialValue: aboutController.text,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: (fname) => fname == null
                                  ? "Please  write about yourself"
                                  : null,
                              name: 'about',
                              labelText: 'About Me',
                              onChanged: (value) =>
                                  aboutController.text = value.toString(),
                            ),
                            15.squareBox,
                          ],
                        ).p12(),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      12.squareBox,
                      Material(
                        color: Color(0xff57C5B6),
                        // shape: changedButton ? BoxShape.circle : BoxShape.rectangle,
                        borderRadius:
                            BorderRadius.circular(changedButton ? 50 : 8),
                        child: InkWell(
                          onTap: () => updateData(),
                          //  Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) => PatientHealthForm(),
                          //   ),
                          // ),
                          child: AnimatedContainer(
                            width: changedButton ? 50 : 220,
                            height: 50,
                            // cannot use both color (of container and color of box decoration)
                            duration: Duration(seconds: 1),
                            child: Center(
                              //can use wrap with center
                              child: changedButton
                                  ? Icon(Icons.done,
                                      color: Colors.white) //if btn is clicked
                                  : Text(
                                      "Update",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                    ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      // Expanded(child: MyAnimation()),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
    ;
  }

  void updateData() async {
    final isValid = _formKey.currentState!.validate();

    if (!isValid) return;

    final db = FirebaseFirestore.instance;

    final user = FirebaseAuth.instance.currentUser!.email;

    try {
      await FirebaseFirestore.instance
          .collection("doctor")
          .doc(user.toString())
          .update({"about": aboutController.text});

      QuickAlert.show(
          context: context,
          text: "Updated successfully",
          type: QuickAlertType.success,
          onConfirmBtnTap: () {
            Navigator.pushNamed(context, MyRoutes.doctorDash);
          });
      // That's it to display an alert, use other properties to customize.
    } on FirebaseAuthException catch (e) {
      print(e);
      QuickAlert.show(
          context: context,
          type: QuickAlertType.error,
          onConfirmBtnTap: () {
            Navigator.pushNamed(context, MyRoutes.doctorDash);
          });
    }
  }
}

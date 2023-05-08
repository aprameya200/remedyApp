// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:remedy_app/pages/login_page.dart';
import 'package:remedy_app/pages/sign-up_page.dart';
import 'package:remedy_app/widgets/anime-gradient.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:social_login_buttons/social_login_buttons.dart';

import '../main.dart';
import '../widgets/themes.dart';
import 'package:animate_gradient/animate_gradient.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import '../widgets/utils.dart';
import 'patient_skeleton.dart';

class ForgotPasswordPage extends StatefulWidget {
  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPage();
}

class _ForgotPasswordPage extends State<ForgotPasswordPage>
    with TickerProviderStateMixin {
  bool changedButton = false;

  final emailController = TextEditingController();

  moveToHome(BuildContext context) async {
    //loading animation
    if (_formKey.currentState!.validate()) {
      setState(() {
        changedButton = true;
      });

      await Future.delayed(Duration(seconds: 1));
      // await Navigator.pushNamed(context, MyRoutes.homeRoute);

      setState(() {
        changedButton = false;
      });
    }
  }

  @override
  final _formKey = GlobalKey<FormState>();

  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: Container(
        alignment: Alignment.topCenter,
        height: double.infinity,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Form(
                key: _formKey,
                child: AnimateGradient(
                  controller: AnimationController(vsync: this),
                  duration: Duration(seconds: 3),
                  primaryBegin: Alignment.centerLeft,
                  primaryEnd: Alignment.centerRight,
                  secondaryBegin: Alignment.bottomLeft,
                  secondaryEnd: Alignment.bottomCenter,
                  primaryColors: AnimeGradient.primary_color,
                  secondaryColors: AnimeGradient.secondary_color,
                  child: Padding(
                    padding: EdgeInsets.all(30.0),
                    child: Column(
                      children: [
                        Image.asset(
                          "assets/images/forgot.png",
                          //fit: BoxFit.cover,
                          height: 200,
                        ),
                        10.squareBox,
                        "Forgot Password"
                            .text
                            .xl4
                            .color(MyThemes.textColor)
                            .make(),
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
                              Container(
                                padding: EdgeInsets.all(8.0),
                                child: TextFormField(
                                  controller: emailController,
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  validator: (email) => email != null &&
                                          !EmailValidator.validate(email)
                                      ? "Enter a valid email"
                                      : null,
                                  cursorColor: MyThemes.textColor,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      focusColor: Colors.red,
                                      icon: Icon(
                                        CupertinoIcons.at,
                                        color: Colors.black,
                                      ),
                                      hintText: "Enter Email",
                                      hintStyle:
                                          TextStyle(color: Colors.grey[400])),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Material(
                          color: Color(0xff57C5B6),
                          // shape: changedButton ? BoxShape.circle : BoxShape.rectangle,
                          borderRadius:
                              BorderRadius.circular(changedButton ? 50 : 8),
                          child: InkWell(
                            onTap: () => resetPassword(),
                            child: AnimatedContainer(
                              width: changedButton ? 50 : 220,
                              height: 50,
                              // cannot use both color (of container and color of box decoration)
                              duration: Duration(seconds: 1),
                              child: Center(
                                //can use wrap with center
                                child: Text(
                                  "Get Reset Link",
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
                        "Don't worry. Please enter your email address associated with your account"
                            .text
                            .align(TextAlign.center)
                            .make(),
                        SizedBox(
                          height: 20,
                        ),
                        InkWell(
                          onTap: () => Navigator.of(context).pop(),
                          child: "Back to Login Screen"
                              .text
                              .color(Color.fromRGBO(143, 148, 251, 1))
                              .medium
                              .make(),
                        ),
                        // Expanded(child: MyAnimation()),
                      ],
                    ),
                  ),
                )),
          ),
        ),
      ).pOnly(top: 50),
    );
  }

  Future<void> _showDialog1(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: const Text('No users were registered with that email'),
        );
      },
    );
  }

  Future resetPassword() async {
    final db = FirebaseFirestore.instance;

    final isValid = _formKey.currentState!.validate();

    if (!isValid) return;

    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailController.text.trim());

      Utils.showSnackBar("Password reset email sent");
    } on FirebaseAuthException catch (e) {
      _showDialog1(context);
    }
  }
}

class LineDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      child: Container(
        height: 1.0,
        width: 85.0,
        color: MyThemes.textColor,
      ),
    );
  }
}

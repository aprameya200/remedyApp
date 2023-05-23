// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: prefer_const_constructors

import 'package:animate_gradient/animate_gradient.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:remedy_app/widgets/anime-gradient.dart';
import 'package:social_login_buttons/social_login_buttons.dart';
import 'package:velocity_x/velocity_x.dart';

import 'package:remedy_app/pages/sign-up_page.dart';

import '../main.dart';
import '../widgets/themes.dart';
import '../widgets/utils.dart';
import 'forgot-password.dart';
import 'patient_skeleton.dart';

class LoginPage extends StatefulWidget {
  final VoidCallback onClickedSignUp;
  const LoginPage({
    Key? key,
    required this.onClickedSignUp,
  }) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with TickerProviderStateMixin {
  bool changedButton = false;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  @override
  final _formKey = GlobalKey<FormState>();

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffB9EDDD),
      body: Container(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Form(
                key: _formKey,
                child: AnimateGradient(
                  // controller: AnimationController(vsync: crea()),
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
                          "assets/images/doctors.png",
                          //fit: BoxFit.cover,
                        ),
                        10.squareBox,
                        "Welcome Back"
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
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            color: Color.fromARGB(
                                                51, 34, 26, 26)))),
                                child: TextFormField(
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  validator: (email) => email != null &&
                                          !EmailValidator.validate(email)
                                      ? "Enter a valid email"
                                      : null,
                                  controller: emailController,
                                  cursorColor: MyThemes.textColor,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      focusColor: Colors.red,
                                      icon: Icon(
                                        CupertinoIcons.mail,
                                        color: Colors.black,
                                      ),
                                      hintText: "Enter Email",
                                      hintStyle:
                                          TextStyle(color: Colors.grey[400])),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(8.0),
                                child: TextFormField(
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  validator: (password) =>
                                      password != null && password.length < 6
                                          ? "Enter a minimum of 6 characters"
                                          : null,
                                  obscureText: true,
                                  controller: passwordController,
                                  cursorColor: MyThemes.textColor,
                                  decoration: InputDecoration(
                                      icon: Icon(
                                        CupertinoIcons.lock_circle,
                                        color: Colors.black,
                                      ),
                                      border: InputBorder.none,
                                      hintText: "Enter Password",
                                      hintStyle:
                                          TextStyle(color: Colors.grey[400])),
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        Material(
                          color: Color(0xff57C5B6),
                          // shape: changedButton ? BoxShape.circle : BoxShape.rectangle,
                          borderRadius:
                              BorderRadius.circular(changedButton ? 50 : 8),
                          child: InkWell(
                            onTap: () => signIn(),
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
                                        "Login",
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
                        InkWell(
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ForgotPasswordPage(),
                            ),
                          ),
                          child: "Forgot Password?"
                              .text
                              .color(Color.fromRGBO(143, 148, 251, 1))
                              .medium
                              .make(),
                        ),
                        SizedBox(
                          height: 20,
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            "Don't have an account?".text.medium.make(),
                            "\t".text.make(),
                            InkWell(
                              onTap: widget.onClickedSignUp,
                              child: "Sign Up"
                                  .text
                                  .color(Color.fromRGBO(143, 148, 251, 1))
                                  .medium
                                  .make(),
                            )
                          ],
                        ),
                        130.squareBox
                        // Expanded(child: MyAnimation()),
                      ],
                    ),
                  ),
                )),
          ),
        ),
      ),
    );
  }

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future signIn() async {
    final db = FirebaseFirestore.instance;

    User? user = _firebaseAuth.currentUser;

    final isValid = _formKey.currentState!.validate();

    if (!isValid) return;
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Center(
              child: CircularProgressIndicator(),
            ));

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim());
    } on FirebaseAuthException catch (e) {
      Utils.showSnackBar("Please enter correct login credentials");
    }
    // email: "user123@gmail.com",
    // password: "user@123");

    //adds data

    navigatorKey.currentState!.popUntil((route) => route.isFirst);
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

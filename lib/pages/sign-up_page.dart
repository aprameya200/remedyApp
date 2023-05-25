// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: prefer_const_constructors

import 'package:animate_gradient/animate_gradient.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:remedy_app/data/sign-up-data.dart';
import 'package:remedy_app/pages/patient/patients_page.dart';
import 'package:remedy_app/widgets/anime-gradient.dart';
import 'package:social_login_buttons/social_login_buttons.dart';
import 'package:velocity_x/velocity_x.dart';

import 'package:remedy_app/pages/login_page.dart';

import '../main.dart';
import '../widgets/themes.dart';
import '../widgets/utils.dart';
import 'patient_skeleton.dart';

class SignInPage extends StatefulWidget {
  final Function() onClickedSignIn;
  const SignInPage({
    Key? key,
    required this.onClickedSignIn,
  }) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> with TickerProviderStateMixin {
  bool changedButton = false;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final fullnameController = TextEditingController();
  final confirmPasswordController = TextEditingController();

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
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xffB9EDDD),
      body: Container(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Form(
                key: _formKey,
                child: AnimateGradient(
                  controller: AnimationController(
                      vsync: this, duration: Duration(days: 100)),
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
                          "assets/images/signup.png",
                          height: 190,
                        ),
                        10.squareBox,
                        "Sign Up".text.xl4.color(MyThemes.textColor).make(),
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
                                  controller: fullnameController,
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  validator: (fullname) => fullname != null &&
                                          RegExp(r'[!@$#<>?":_`~;[\]\\|=+)(*&^%0-9-]')
                                              .hasMatch(fullname)
                                      ? "Enter valid name"
                                      : null,
                                  cursorColor: MyThemes.textColor,
                                  decoration: InputDecoration(
                                      icon: Icon(
                                        CupertinoIcons.profile_circled,
                                        color: Colors.black,
                                      ),
                                      border: InputBorder.none,
                                      focusColor: Colors.red,
                                      hintText: "Full Name",
                                      hintStyle:
                                          TextStyle(color: Colors.grey[400])),
                                ),
                              ),
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
                                      icon: Icon(
                                        CupertinoIcons.at,
                                        color: Colors.black,
                                      ),
                                      border: InputBorder.none,
                                      focusColor: Colors.red,
                                      hintText: "Email",
                                      hintStyle:
                                          TextStyle(color: Colors.grey[400])),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            color: Color.fromARGB(
                                                51, 34, 26, 26)))),
                                child: TextFormField(
                                  obscureText: true,
                                  controller: passwordController,
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  validator: (password) {
                                    RegExp regexCapital =
                                        RegExp(r'^(?=.*?[A-Z])');

                                    RegExp regexSmalll =
                                        RegExp(r'^(?=.*?[a-z])');

                                    RegExp regexNumber =
                                        RegExp(r'^(?=.*?[0-9])');

                                    RegExp regexSpecial =
                                        RegExp(r'^(?=.*?[#?!@$%^&*-])');

                                    if (password != null &&
                                        password.length < 6) {
                                      return "Password Length must be greater than 6 letters";
                                    }
                                    if (!regexCapital.hasMatch(password!)) {
                                      return "Password must have a capital letter";
                                    }
                                    if (!regexSmalll.hasMatch(password!)) {
                                      return "Password must have a small letter";
                                    }
                                    if (!regexNumber.hasMatch(password!)) {
                                      return "Password must have a number";
                                    }
                                    if (!regexSpecial.hasMatch(password!)) {
                                      return "Password must have a special character";
                                    }
                                  },
                                  cursorColor: MyThemes.textColor,
                                  decoration: InputDecoration(
                                      icon: Icon(
                                        CupertinoIcons.lock_open,
                                        color: Colors.black,
                                      ),
                                      border: InputBorder.none,
                                      focusColor: Colors.red,
                                      hintText: "Password",
                                      hintStyle:
                                          TextStyle(color: Colors.grey[400])),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(8.0),
                                child: TextFormField(
                                  controller: confirmPasswordController,
                                  obscureText: true,
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  validator: (confirmPassword) =>
                                      confirmPassword != null &&
                                              confirmPassword !=
                                                  passwordController.text.trim()
                                          ? "Passwords donot match"
                                          : null,
                                  cursorColor: MyThemes.textColor,
                                  decoration: InputDecoration(
                                      icon: Icon(
                                        CupertinoIcons.lock_shield,
                                        color: Colors.black,
                                      ),
                                      border: InputBorder.none,
                                      focusColor: Colors.red,
                                      hintText: "Confirm Password",
                                      hintStyle:
                                          TextStyle(color: Colors.grey[400])),
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        Material(
                          color: Color(0xff57C5B6),
                          // shape: changedButton ? BoxShape.circle : BoxShape.rectangle,
                          borderRadius:
                              BorderRadius.circular(changedButton ? 50 : 8),
                          child: InkWell(
                            onTap: () => signUp(),
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
                                        "Sign Up",
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

                        SizedBox(
                          height: 50,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            "Already have an account?".text.medium.make(),
                            "\t".text.make(),
                            InkWell(
                              onTap: widget.onClickedSignIn,
                              child: "Login"
                                  .text
                                  .color(Color.fromRGBO(143, 148, 251, 1))
                                  .medium
                                  .make(),
                            )
                          ],
                        ),
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

  /**
   * 
   * Form Submit and validation
   * 
   * 
   */

  Future<void> _showDialog1(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: const Text(
              'User with that email already Exists\nPlease pick new email'),
        );
      },
    );
  }

  Future signUp() async {
    final db = FirebaseFirestore.instance;

    final isValid = _formKey.currentState!.validate();

    if (!isValid) return;

    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Center(
              child: CircularProgressIndicator(),
            ));

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text.trim(),
          password: confirmPasswordController.text.trim());

      SignUpData(
          email: emailController.text.trim(),
          fullname: confirmPasswordController.text.trim());

      // await FirebaseFirestore.instance
      //     .collection("user")
      //     .doc(emailController.text.trim())
      //     .set({
      //   "email": emailController.text.trim(),
      //   "fullname": fullnameController.text.trim(),
      // });

      navigatorKey.currentState!.popUntil((route) => route.isFirst);
    } on FirebaseAuthException catch (e) {
      navigatorKey.currentState!.popUntil((route) => route.isFirst);
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

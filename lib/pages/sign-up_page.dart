// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:remedy_app/pages/login_page.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:social_login_buttons/social_login_buttons.dart';

import '../widgets/themes.dart';
import 'package:animate_gradient/animate_gradient.dart';

import 'patient_skeleton.dart';

class SignInPage extends StatefulWidget {
  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> with TickerProviderStateMixin {
  bool changedButton = false;

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
                  primaryColors: const [
                    Color.fromARGB(255, 255, 255, 255),
                    Color(0xff61F2F5),
                    Colors.white,
                  ],
                  secondaryColors: const [
                    Colors.white,
                    Color(0xffB9EDDD),
                    Color.fromARGB(255, 86, 201, 138),
                  ],
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
                                child: TextField(
                                  cursorColor: MyThemes.textColor,
                                  decoration: InputDecoration(
                                      icon: Icon(
                                        CupertinoIcons.profile_circled,
                                        color: Colors.black,
                                      ),
                                      border: InputBorder.none,
                                      focusColor: Colors.red,
                                      hintText: "Username",
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
                                child: TextField(
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
                                child: TextField(
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
                                child: TextField(
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
                          height: 20,
                        ),
                        Material(
                          color: Color(0xff57C5B6),
                          // shape: changedButton ? BoxShape.circle : BoxShape.rectangle,
                          borderRadius:
                              BorderRadius.circular(changedButton ? 50 : 8),
                          child: InkWell(
                            onTap: () => moveToHome(context),
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            LineDivider(),
                            "Or".text.lg.make(),
                            LineDivider()
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        SocialLoginButton(
                          backgroundColor: MyThemes.googleButton,
                          buttonType: SocialLoginButtonType.google,
                          onPressed: () {},
                          text: "Sign Up With Google",
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            "Already have an account?".text.medium.make(),
                            "\t".text.make(),
                            InkWell(
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LoginPage(),
                                ),
                              ),
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

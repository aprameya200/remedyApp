import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:remedy_app/pages/fancy-background-app.dart';
import 'package:remedy_app/pages/login_page.dart';
import 'package:remedy_app/pages/patient/patients_page.dart';

void main() {
  runApp(const MyApp());
}

Color? selectedColor;

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      //home: homePage.build(context), set below from route

      /**
       * Themes selection from here
       */
      themeMode: ThemeMode.light,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        fontFamily: GoogleFonts.poppins().fontFamily,
        appBarTheme:
            AppBarTheme(), //themse from anotehr class called using method of that class
      ), //setting primary forn from google fonts

      /**
       * Router from here
       */
      initialRoute:
          "/login", //opens initial route instead of specified routes below

      routes: {
        //routes like laravel
        "/login": (context) =>
            PatientPage(), //route has been changes to this page
        // MyRoutes.homeRoute: (context) =>
        //     HomePage(), //routing using rpoute classes
        // MyRoutes.loginRoute: (context) => LoginPage(),
      },
    );
  }
}

// import 'package:animate_gradient/animate_gradient.dart';
// import 'package:flutter/material.dart';
// import 'package:remedy_app/pages/login_page.dart';
// import 'package:remedy_app/widgets/themes.dart';
// import 'package:social_login_buttons/social_login_buttons.dart';
// import 'package:velocity_x/velocity_x.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       title: 'Animated Gradient',
//       home: App(),
//     );
//   }
// }

// class App extends StatelessWidget {
//   const App({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Form(
//           child: AnimateGradient(
//             duration: Duration(seconds: 3),
//             primaryBegin: Alignment.centerLeft,
//             primaryEnd: Alignment.centerRight,
//             secondaryBegin: Alignment.bottomLeft,
//             secondaryEnd: Alignment.bottomCenter,
//             primaryColors: const [
//               Color.fromARGB(255, 255, 255, 255),
//               Color(0xff61F2F5),
//               Colors.white,
//             ],
//             secondaryColors: const [
//               Colors.white,
//               Color(0xffB9EDDD),
//               Color.fromARGB(255, 0, 175, 79),
//             ],
//             child: Padding(
//               padding: EdgeInsets.all(30.0),
//               child: Column(
//                 children: [
//                   Image.asset(
//                     "assets/images/doctors.png",
//                     //fit: BoxFit.cover,
//                   ),
//                   10.squareBox,
//                   "Welcome Back".text.xl4.color(MyThemes.textColor).make(),
//                   20.squareBox,
//                   Container(
//                     padding: EdgeInsets.all(5),
//                     decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(10),
//                         boxShadow: [
//                           BoxShadow(
//                               color: MyThemes.shadows,
//                               blurRadius: 20.0,
//                               offset: Offset(0, 10))
//                         ]),
//                     child: Column(
//                       children: [
//                         Container(
//                           padding: EdgeInsets.all(8.0),
//                           decoration: BoxDecoration(
//                               border: Border(
//                                   bottom: BorderSide(
//                                       color: Color.fromARGB(51, 34, 26, 26)))),
//                           child: TextField(
//                             cursorColor: MyThemes.textColor,
//                             decoration: InputDecoration(
//                                 border: InputBorder.none,
//                                 focusColor: Colors.red,
//                                 hintText: "Email or Phone number",
//                                 hintStyle: TextStyle(color: Colors.grey[400])),
//                           ),
//                         ),
//                         Container(
//                           padding: EdgeInsets.all(8.0),
//                           child: TextField(
//                             cursorColor: MyThemes.textColor,
//                             decoration: InputDecoration(
//                                 border: InputBorder.none,
//                                 hintText: "Password",
//                                 hintStyle: TextStyle(color: Colors.grey[400])),
//                           ),
//                         )
//                       ],
//                     ),
//                   ),
//                   SizedBox(
//                     height: 20,
//                   ),
//                   Material(
//                     color: MyThemes.loginColor,
//                     // shape: changedButton ? BoxShape.circle : BoxShape.rectangle,
//                     borderRadius: BorderRadius.circular(8),
//                     child: InkWell(
//                       onTap: () => {},
//                       child: AnimatedContainer(
//                         width: 220,
//                         height: 50,
//                         // cannot use both color (of container and color of box decoration)
//                         duration: Duration(seconds: 1),
//                         child: Center(
//                           //can use wrap with center
//                           child: Text(
//                             "Login",
//                             style: TextStyle(
//                                 color: Colors.white,
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 18),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                   SizedBox(
//                     height: 20,
//                   ),
//                   Text(
//                     "Forgot Password?",
//                     style: TextStyle(color: Color.fromRGBO(143, 148, 251, 1)),
//                   ),
//                   SizedBox(
//                     height: 20,
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       LineDivider(),
//                       "Or".text.lg.make(),
//                       LineDivider()
//                     ],
//                   ),
//                   SizedBox(
//                     height: 20,
//                   ),
//                   SocialLoginButton(
//                     backgroundColor: MyThemes.googleButton,
//                     buttonType: SocialLoginButtonType.google,
//                     onPressed: () {},
//                     text: "Login With Google",
//                   ),
//                   SizedBox(
//                     height: 20,
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       "Don't have an account?".text.medium.make(),
//                       "\t".text.make(),
//                       "Sign Up"
//                           .text
//                           .color(Color.fromRGBO(143, 148, 251, 1))
//                           .medium
//                           .make()
//                     ],
//                   ),
//                   // Expanded(child: MyAnimation()),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:remedy_app/pages/fancy-background-app.dart';
import 'package:remedy_app/pages/login_page.dart';
import 'package:remedy_app/pages/patient/mesages.dart';
import 'package:remedy_app/pages/patient/patients_page.dart';
import 'package:remedy_app/pages/patient/searchDoctor.dart';

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
            LoginPage(), //route has been changes to this page
        // MyRoutes.homeRoute: (context) =>
        //     HomePage(), //routing using rpoute classes
        // MyRoutes.loginRoute: (context) => LoginPage(),
      },
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:google_nav_bar/google_nav_bar.dart';
// import 'package:line_icons/line_icons.dart';

// void main() => runApp(MaterialApp(
//     builder: (context, child) {
//       return Directionality(textDirection: TextDirection.ltr, child: child!);
//     },
//     title: 'GNav',
//     theme: ThemeData(
//       primaryColor: Colors.grey[800],
//     ),
//     home: Example()));

// class Example extends StatefulWidget {
//   @override
//   _ExampleState createState() => _ExampleState();
// }

// class _ExampleState extends State<Example> {
//   int _selectedIndex = 0;
//   static const TextStyle optionStyle =
//       TextStyle(fontSize: 30, fontWeight: FontWeight.w600);
//   static const List<Widget> _widgetOptions = <Widget>[
//     Text(
//       'Home',
//       style: optionStyle,
//     ),
//     Text(
//       'Likes',
//       style: optionStyle,
//     ),
//     Text(
//       'Search',
//       style: optionStyle,
//     ),
//     Text(
//       'Profile',
//       style: optionStyle,
//     ),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         elevation: 20,
//         title: const Text('GoogleNavBar'),
//       ),
//       //from here//from here//from here//from here//from here//from here//from here
//       //from here
//       //from here
//       //from here
//       //from here
//       //from here
//       body: Center(
//         child: _widgetOptions.elementAt(_selectedIndex), //from here
//       ),
//       bottomNavigationBar: Container(
//         decoration: BoxDecoration(
//           color: Colors.white,
//           boxShadow: [
//             BoxShadow(
//               blurRadius: 20,
//               color: Colors.black.withOpacity(.1),
//             )
//           ],
//         ),
//         child: SafeArea(
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
//             child: GNav(
//               rippleColor: Colors.grey[300]!,
//               hoverColor: Colors.grey[100]!,
//               gap: 8,
//               activeColor: Colors.black,
//               iconSize: 24,
//               padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
//               duration: Duration(milliseconds: 400),
//               tabBackgroundColor: Colors.grey[100]!,
//               color: Colors.black,
//               tabs: [
//                 GButton(
//                   icon: LineIcons.home,
//                   text: 'Home',
//                 ),
//                 GButton(
//                   icon: LineIcons.heart,
//                   text: 'Likes',
//                 ),
//                 GButton(
//                   icon: LineIcons.search,
//                   text: 'Search',
//                 ),
//                 GButton(
//                   icon: LineIcons.user,
//                   text: 'Profile',
//                 ),
//               ],
//               selectedIndex: _selectedIndex,
//               onTabChange: (index) {
//                 setState(() {
//                   _selectedIndex = index;
//                 });
//               },
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

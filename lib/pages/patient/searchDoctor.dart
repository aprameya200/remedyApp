import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:remedy_app/pages/doctor/about-doctor-page.dart';
import 'package:remedy_app/utils/routes.dart';
import 'package:remedy_app/widgets/themes.dart';
import 'package:search_page/search_page.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../widgets/singleton-widget.dart';

/// This is a very simple class, used to
/// demo the `SearchPage` package
class Person implements Comparable<Person> {
  final String name, surname;
  final String department;

  const Person(this.name, this.surname, this.department);

  @override
  int compareTo(Person other) => name.compareTo(other.name);
}

class SearchDoctorPage extends StatefulWidget {
  static const people = [];

  const SearchDoctorPage({super.key});

  @override
  State<SearchDoctorPage> createState() => _SearchDoctorPageState();
}

class _SearchDoctorPageState extends State<SearchDoctorPage> {
  List userList = [];
  List userIDs = [];
  List searchResults = [];

  @override
  initState() {
    super.initState();
    getDoctorAbout();
  }

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future getDoctorAbout() async {
    User? user = _firebaseAuth.currentUser;

    try {
      final data = await FirebaseFirestore.instance //here
          .collection("doctor")
          .get();

      final getDocID = data.docs.map((doc) => doc.id).toList();

      setState(() {
        userIDs.add(getDocID);
      });

      for (var i = 0; i < userIDs[0].length; i++) {
        final allDoctorDetails = await FirebaseFirestore.instance //here
            .collection("doctor")
            .doc(userIDs[0][i].toString())
            .get();

        setState(() {
          userList.add(allDoctorDetails.data());
          searchResults.add(Person(userList[i]["first-name"],
              userList[i]["last-name"], userList[i]["department"]));
        });
      }
    } on Exception catch (e) {
      // TODO
    }

    print(userList[1]["first-name"]);
  }

  @override
  Widget build(BuildContext context) {
    MyThemes search = new MyThemes();

    return Scaffold(
      // bottomNavigationBar: Example(),
      appBar: AppBar(
        title: "Search".text.xl3.black.make(),
        backgroundColor: Colors.white,
        elevation: 0.0,
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: MyThemes.boxEdge,
        tooltip: 'Search Doctor',
        onPressed: () => showSearch(
          context: context,
          delegate: SearchPage(
            searchStyle: TextStyle(
                fontSize: 30,
                decoration: null,
                fontFamily: GoogleFonts.poppins().fontFamily),
            barTheme: ThemeData(appBarTheme: search.searchTheme()),
            onQueryUpdate: print,
            items: searchResults,
            searchLabel: 'Search Doctor',
            suggestion: const Center(
              child: Text('Filter people by name, surname or department'),
            ),
            failure: const Center(
              child: Text('No person found :('),
            ),
            filter: (person) => [
              person.name,
              person.surname,
              person.department,
            ],
            sort: (a, b) => a.compareTo(b),
            builder: (person) => ListTile(
              onTap: () {
                AboutDoctorData doctorData = new AboutDoctorData();

                for (var i = 0; i < userIDs[0].length; i++) {
                  if (userList[i]["first-name"] == person.name) {
                    doctorData.setString(userIDs[0][i].toString());
                  }
                }

                Navigator.pushNamed(context, MyRoutes.aboutDoctorPage);
              },
              title: Text(
                person.name,
              ),
              subtitle: Text(person.surname),
              trailing: Text(person.department),
            ),
          ),
        ),
        child: const Icon(
          Icons.search,
          color: Colors.black,
        ),
      ),
    );
  }
}

class SearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:remedy_app/widgets/themes.dart';
import 'package:search_page/search_page.dart';
import 'package:velocity_x/velocity_x.dart';

/// This is a very simple class, used to
/// demo the `SearchPage` package
class Person implements Comparable<Person> {
  final String name, surname;
  final num age;

  const Person(this.name, this.surname, this.age);

  @override
  int compareTo(Person other) => name.compareTo(other.name);
}

class SearchDoctorPage extends StatelessWidget {
  static const people = [
    Person('Mike', 'Barron', 64),
    Person('Todd', 'Black', 30),
    Person('Ahmad', 'Edwards', 55),
    Person('Anthony', 'Johnson', 67),
    Person('Annette', 'Brooks', 39),
  ];

  const SearchDoctorPage({super.key});

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
            items: people,
            searchLabel: 'Search people',
            suggestion: const Center(
              child: Text('Filter people by name, surname or age'),
            ),
            failure: const Center(
              child: Text('No person found :('),
            ),
            filter: (person) => [
              person.name,
              person.surname,
              person.age.toString(),
            ],
            sort: (a, b) => a.compareTo(b),
            builder: (person) => ListTile(
              title: Text(person.name),
              subtitle: Text(person.surname),
              trailing: Text('${person.age} yo'),
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

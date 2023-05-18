// ignore_for_file: public_member_api_docs, sort_constructors_first, prefer_const_literals_to_create_immutables, unnecessary_new, use_build_context_synchronously
// ignore_for_file: prefer_const_constructors

import 'package:flutter_fast_forms/flutter_fast_forms.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:remedy_app/pages/patient/validate-patient.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import 'package:velocity_x/velocity_x.dart';

import '../../utils/routes.dart';
import '../../widgets/singleton-widget.dart';
import '../../widgets/themes.dart';
import 'package:quickalert/quickalert.dart';
import 'package:toggle_switch/toggle_switch.dart';

class BookAppointment extends StatefulWidget {
  @override
  State<BookAppointment> createState() => _BookAppointmentState();
}

class _BookAppointmentState extends State<BookAppointment> {
  List userList = [];

  List availability = [];
  List timings = [];
  List daysAvailble = [];
  bool initialOk = false;

  late DateTime initialDate = new DateTime.now();

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future getAvailability() async {
    User? user = _firebaseAuth.currentUser;
    AboutDoctorData singleObject = new AboutDoctorData();

    try {
      final data = await FirebaseFirestore.instance //here
          .collection("schedule")
          .doc(AboutDoctorData.getString())
          .get();

      setState(() {
        availability.add(data.data());
      });
    } on Exception catch (e) {
      // TODO
    }

    print(availability[0]["timing"]["Monday"].toString());
    print(availability[0]["timing"].length.toString());
    setState(() {
      timings.add(availability[0]["timing"]);
      daysAvailble = timings[0].keys.toList();
    });
  }

  @override
  initState() {
    super.initState();
    getAvailability();
  }

  // List userData = Singleton.userData;

  bool changedButton = false;

  final subjectController = new TextEditingController();
  final descriptionController = new TextEditingController();
  final dateController = new TextEditingController();

  @override
  void dispose() {
    subjectController.dispose();
    descriptionController.dispose();
    dateController.dispose();

    super.dispose();
  }

  List userData = Singleton.userData;

  @override
  final _formKey = GlobalKey<FormState>();

  Validate validate = new Validate();

  int getWeekday(String day) {
    if (day == "Monday") {
      return 1;
    }
    if (day == "Tuesday") {
      return 2;
    }
    if (day == "Wednesday") {
      return 3;
    }
    if (day == "Thursday") {
      return 4;
    }
    if (day == "Friday") {
      return 5;
    } else {
      return 4;
    }
  }

  List<DateTime> getAllInvalidDates(DateTime startDate) {
    List<DateTime> invalidDates = [];

    int counter = 1;

    DateTime currentDate = startDate;
    // while (currentDate.isBefore(DateTime(2024, 5, 30))) {
    for (var i = 0; i < 600; i++) {
      if (!daysInteger(daysAvailble).contains(currentDate.weekday)) {
        invalidDates.add(currentDate);
      }
      currentDate = currentDate.add(Duration(days: counter));
    }
    // }

    return invalidDates;
  }

  List daysInteger(List day) {
    List<int> daysInteger = [];

    for (var i = 0; i < day.length; i++) {
      setState(() {
        if (day[i] == "Monday") {
          daysInteger.add(1);
        }
        if (day[i] == "Tuesday") {
          daysInteger.add(2);
        }
        if (day[i] == "Wednesday") {
          daysInteger.add(3);
        }
        if (day[i] == "Thursday") {
          daysInteger.add(4);
        }
        if (day[i] == "Friday") {
          daysInteger.add(5);
        }
      });
    }

    return daysInteger;
  }

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
                      "Book An Appomiment"
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
                            5.squareBox,
                            15.squareBox,
                            FastTextField(
                              keyboardType: TextInputType.multiline,
                              maxLines: null,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: (fname) =>
                                  fname == null ? "Please enter reason" : null,
                              name: 'reason',
                              labelText: 'Reason',
                              onChanged: (value) =>
                                  subjectController.text = value.toString(),
                            ),
                            15.squareBox,
                            FastTextField(
                              keyboardType: TextInputType.multiline,
                              maxLines: null,
                              minLines: 10,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: (fname) => fname == null
                                  ? "Please enter description"
                                  : null,
                              name: 'description',
                              labelText: 'Description',
                              onChanged: (value) =>
                                  descriptionController.text = value.toString(),
                            ),
                            15.squareBox,
                            "Select Date and Time".text.xl2.make(),
                            15.squareBox,
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(width: 1),
                              ),
                              child: SfCalendar(
                                minDate: DateTime.now(),
                                viewNavigationMode: ViewNavigationMode.snap,
                                blackoutDatesTextStyle: TextStyle(
                                    color: Color.fromARGB(255, 255, 0, 0)),
                                view: CalendarView.month,
                                blackoutDates:
                                    getAllInvalidDates(DateTime.now()),
                                headerStyle: CalendarHeaderStyle(
                                    textStyle: TextStyle(fontSize: 20)),
                                todayHighlightColor: MyThemes.loginColor,
                                cellBorderColor: Color.fromARGB(0, 255, 193, 7),
                                onSelectionChanged: (CalendarDetails) {
                                  print(CalendarDetails.date.toString());
                                },
                                selectionDecoration: BoxDecoration(
                                    color: MyThemes.calanderSelection),
                              ).p12(),
                            ),
                            15.squareBox,
                            ToggleSwitch(
                              activeFgColor: Colors.black54,
                              borderColor: [Colors.black],
                              activeBorders: [
                                Border.all(
                                  color: Color.fromARGB(255, 0, 0, 0),
                                  width: 1.0,
                                ),
                              ],
                              borderWidth: 1,
                              inactiveBgColor:
                                  Color.fromARGB(255, 255, 255, 255),
                              isVertical: true,
                              minWidth: 350.0,
                              radiusStyle: true,
                              cornerRadius: 4.0,
                              initialLabelIndex: 10,
                              labels: [
                                '12:00',
                                '11:00',
                                '4:00',
                                'Winter',
                                'Eve'
                              ],
                              onToggle: (index) {
                                print('switched to: $index');
                              },
                            ),
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
                          // onTap: () => updateData(),
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

  // void updateData() async {
  //   final isValid = _formKey.currentState!.validate();

  //   if (!isValid) return;

  //   final db = FirebaseFirestore.instance;

  //   final user = FirebaseAuth.instance.currentUser!.email;

  //   try {
  //     await FirebaseFirestore.instance
  //         .collection("doctor")
  //         .doc(user.toString())
  //         .update({"about": aboutController.text});

  //     QuickAlert.show(
  //         context: context,
  //         text: "Updated successfully",
  //         type: QuickAlertType.success,
  //         onConfirmBtnTap: () {
  //           Navigator.pushNamed(context, MyRoutes.doctorDash);
  //         });
  //     // That's it to display an alert, use other properties to customize.
  //   } on FirebaseAuthException catch (e) {
  //     print(e);
  //     QuickAlert.show(
  //         context: context,
  //         type: QuickAlertType.error,
  //         onConfirmBtnTap: () {
  //           Navigator.pushNamed(context, MyRoutes.doctorDash);
  //         });
  //   }
  // }
}

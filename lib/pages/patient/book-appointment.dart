// ignore_for_file: public_member_api_docs, sort_constructors_first, prefer_const_literals_to_create_immutables, unnecessary_new, use_build_context_synchronously
// ignore_for_file: prefer_const_constructors

import 'package:flutter_fast_forms/flutter_fast_forms.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:remedy_app/pages/patient/mesages.dart';

import 'package:remedy_app/pages/patient/validate-patient.dart';
import 'package:remedy_app/pages/patient_skeleton.dart';
import 'package:remedy_app/widgets/create-chat-room.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import 'package:velocity_x/velocity_x.dart';

import '../../utils/routes.dart';
import '../../widgets/singleton-widget.dart';
import '../../widgets/themes.dart';
import 'package:quickalert/quickalert.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:intl/intl.dart';

class BookAppointment extends StatefulWidget {
  @override
  State<BookAppointment> createState() => _BookAppointmentState();
}

class _BookAppointmentState extends State<BookAppointment> {
  List userList = [];

  List availability = [];
  List timings = [];
  List daysAvailble = [];
  List daysAvailableInInt = [];

  int? timeIndex;

  Map<String, dynamic> bookedAppointments = {};

  List slotsAccordingToSelectedDay = [];

  List checkingAppointments = [];

  int slotNumber = 0;

  bool initialOk = false;

  Map<String, dynamic> timeSlots = {};

  Map<String, dynamic> dailytime = {};

  int total_appointments = 0;

  String maximumAppointments = "";

  List bookingSlot = [];

  late DateTime initialDate = new DateTime.now();

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  late DateTime initialDisplayDate;

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

    setState(() {
      timings.add(availability[0]["timing"]);
      daysAvailble = timings[0].keys.toList();

      timeSlots = timings[0];

      maximumAppointments = availability[0]["maximum-appointments"];
    });

    print(convertTimeSlots(timeSlots["Monday"]["slot-1"]["time"]));
    print(maximumAppointments.toString());

    for (var i = 0; i < daysAvailble.length; i++) {
      setState(() {
        dailytime[daysAvailble[i]] =
            timeSlots[daysAvailble[i]]["slot-${i + 1}"];
      });

      print(dailytime["Monday"].toString() + i.toString());
    }

    // convertTimeSlots(timeSlots[0]["slot-2"]["time"]);
  }

  DateTime convertTimeSlots(Timestamp slotTime) {
    Timestamp timeStamp = slotTime as Timestamp;

    DateTime time = timeStamp.toDate();

    print(time.toString());

    return time;
  }

  List<String> getTimeSlots(String date) {
    for (var i = 0; i < daysAvailble.length; i++) {
      setState(() {
        daysAvailableInInt.add(getWeekday(daysAvailble[i]));
      });
    }

    List<String> slots = [];
    DateTime convertedTime = DateTime.now();

// add for all days in week

    if (daysAvailableInInt.contains(DateTime.parse(date).weekday)) {
      for (var i = 0; i < daysAvailble.length; i++) {
        if (getWeekdayName(DateTime.parse(date).weekday) == daysAvailble[i]) {
          for (var j = 0; j < timeSlots[daysAvailble[i]].length; j++) {
            //check the total time slots

            convertedTime = convertTimeSlots(
                timeSlots[daysAvailble[i]]["slot-${j + 1}"]["time"]);

            String Hourminutes = DateFormat.Hm().format(convertedTime);
            print(j + 1);

            if (checkingAppointments
                    .contains(DateUtils.dateOnly(DateTime.parse(date))) &&
                !bookingSlot.contains(timeSlots[daysAvailble[i]]
                    ["slot-${j + 1}"]["slot-number"])) {
              print(bookingSlot.toString());
              slots.add(Hourminutes);
            } else if (!checkingAppointments
                .contains(DateUtils.dateOnly(DateTime.parse(date)))) {
              slots.add(Hourminutes);
            } else {
              slots.add("Unavailable");
            }
          }
          // print();
          // print(checkingAppointments.toString() +
          //     DateUtils.dateOnly(convertedTime).toString() +
          //     "bookd app + curetn app");

          print(bookingSlot.toString() + "Is the slot");

          // timeSlots["Monday"]["slot-1"]["time"]
        }
      }
    } else {
      slots.add("Please select available date");
    }

    return slots;
  }

  Future getAppointments() async {
    User? user = _firebaseAuth.currentUser;

    try {
      final data = await FirebaseFirestore.instance //here
          .collection("appointments")
          .doc(AboutDoctorData.getString())
          .get();

      setState(() {
        bookedAppointments[AboutDoctorData.getString()] = data.data();

        total_appointments =
            bookedAppointments[AboutDoctorData.getString()].length - 1;
      });

      for (var i = 0;
          i < bookedAppointments[AboutDoctorData.getString()].length - 1;
          i++) {
        print(bookedAppointments[AboutDoctorData.getString()].length);

        if (bookedAppointments[AboutDoctorData.getString()]
                ["appontment-${i + 1}"]["status"] ==
            "booked") {
          setState(() {
            checkingAppointments.add(DateUtils.dateOnly(convertTimeSlots(
                bookedAppointments[AboutDoctorData.getString()]
                    ["appontment-${i + 1}"]["date"])));

            bookingSlot.add(bookedAppointments[AboutDoctorData.getString()]
                ["appontment-${i + 1}"]["slot-number"]);

            print(checkingAppointments.toString() + "ABC");
          });
        }
      }
    } on Exception catch (e) {
      // TODO
    }

    //     ["booked-by"]);
  }

  @override
  initState() {
    super.initState();
    getAvailability();
    getAppointments();
    dateController.text = DateTime.now().toString();
  }

  // List userData = Singleton.userData;

  bool changedButton = false;

  final subjectController = new TextEditingController();
  final descriptionController = new TextEditingController();
  final dateController = new TextEditingController();
  var timeControllerIndex = new TextEditingController();

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

  String getWeekdayName(int day) {
    if (day == 1) {
      return "Monday";
    }
    if (day == 2) {
      return "Tuesday";
    }
    if (day == 3) {
      return "Wednesday";
    }
    if (day == 4) {
      return "Thursday";
    }
    if (day == 5) {
      return "Friday";
    } else {
      return "Error";
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
                              validator: (desc) {
                                if (desc == null || desc == "") {
                                  return "Please enter reason";
                                }
                              },
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
                              validator: (desc) {
                                if (desc == null || desc == "") {
                                  return "Please enter description";
                                }
                              },
                              name: 'description',
                              labelText: 'Description',
                              onChanged: (value) =>
                                  descriptionController.text = value.toString(),
                            ),
                            15.squareBox,
                            "Select Date".text.xl2.make(),
                            "Red: Unavailable".text.medium.red500.make(),
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

                                  setState(() {
                                    dateController.text =
                                        CalendarDetails.date.toString();
                                  });
                                },
                                selectionDecoration: BoxDecoration(
                                    color: MyThemes.calanderSelection),
                              ).p12(),
                            ),
                            15.squareBox,
                            "Select Time".text.xl2.make(),
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
                              labels: getTimeSlots(dateController.text),
                              onToggle: (index) {
                                print('switched to: $index');

                                timeIndex = index;
                                // slotsAccordingToSelectedDay =
                                //     getTimeSlots(dateController.text);
                                timeControllerIndex.text = timeIndex.toString();
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
                                      "Book",
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

    final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

    User? user = _firebaseAuth.currentUser;

    int addedAppointment = total_appointments + 1;
    String app = "appontment-" + addedAppointment.toString();

    int slotNum = int.parse(timeControllerIndex.text) + 1;

    Map<String, dynamic> appDetails = {
      "booked-by": user!.email.toString(),
      "date": DateTime.parse(dateController.text),
      "slot-number": slotNum.toString(),
      "status": "booked",
      "subject": subjectController.text,
      "details": descriptionController.text,
      "time": getTimeSlots(dateController.text)[slotNum - 1],
    };

    try {
      await FirebaseFirestore.instance
          .collection("appointments")
          .doc(AboutDoctorData.getString())
          .update({"total-appointments": addedAppointment, app: appDetails});

      await FirebaseFirestore.instance
          .collection("patient-appointment")
          .doc(user!.email.toString())
          .update({
        app: {
          "booked-by": user!.email.toString(),
          "date": DateTime.parse(dateController.text),
          "slot-number": slotNum.toString(),
          "status": "booked",
          "subject": subjectController.text,
          "details": descriptionController.text,
          "time": getTimeSlots(dateController.text)[slotNum - 1],
          "doctor": AboutDoctorData.getUserData()[0]["first-name"]
        },
      });

      QuickAlert.show(
          context: context,
          text: "Updated successfully",
          type: QuickAlertType.success,
          onConfirmBtnTap: () {
            CreateChat newChat = CreateChat(
                user1: user!.email.toString(),
                user2: AboutDoctorData.getString());

            newChat.createChatRoom();

            Navigator.push(context,
                MaterialPageRoute(builder: (context) => SkeletonPage()));
          });
      // That's it to display an alert, use other properties to customize.
    } on FirebaseAuthException catch (e) {
      print(e);
      QuickAlert.show(
          context: context,
          type: QuickAlertType.error,
          onConfirmBtnTap: () {
            Navigator.pushNamed(context, MyRoutes.patientsProfileRoute);
          });
    }
  }
}

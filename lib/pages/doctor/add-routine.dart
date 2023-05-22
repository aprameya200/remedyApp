// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fast_forms/flutter_fast_forms.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:social_login_buttons/social_login_buttons.dart';
import 'package:velocity_x/velocity_x.dart';

import 'package:remedy_app/data/submit-doctor-data.dart';
import 'package:remedy_app/data/submit-patient-data.dart';
import 'package:remedy_app/pages/login_page.dart';
import 'package:remedy_app/pages/patient/patients_page.dart';
import 'package:remedy_app/pages/patient/validate-patient.dart';
import 'package:remedy_app/widgets/anime-gradient.dart';

import '../../utils/routes.dart';
import '../../widgets/themes.dart';

class DoctorRoutine extends StatefulWidget {
  @override
  State<DoctorRoutine> createState() => _DoctorRoutineState();
}

class _DoctorRoutineState extends State<DoctorRoutine> {
  bool changedButton = false;

  List<Widget> formsWidgets = [];

  List daysSelected = [];

  final mondayController = new TextEditingController();
  final tuesdayController = new TextEditingController();
  final wednesdayController = new TextEditingController();
  final thursdayController = new TextEditingController();
  final fridayController = new TextEditingController();
  final priceController = new TextEditingController();
  final slotsController = new TextEditingController();

  @override
  void dispose() {
    mondayController.dispose();
    tuesdayController.dispose();
    wednesdayController.dispose();
    thursdayController.dispose();
    fridayController.dispose();
    priceController.dispose();
    slotsController.dispose();

    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initializeWidget();
  }

  void removeSlots(String item) {
    for (var i = 0; i < daysSelected.length; i++) {
      if (daysSelected[i] == item) {
        setState(() {
          daysSelected.remove(item);
        });
      }
    }
  }

  void initializeWidget() {
    setState(() {
      formsWidgets = [
        5.squareBox,
        FastChoiceChips(
          name: 'days',
          labelText: 'Days',
          alignment: WrapAlignment.center,
          chipPadding: const EdgeInsets.all(8.0),
          chips: [
            FastChoiceChip(
                selectedColor: MyThemes.btnBox,
                value: 'Monday',
                onSelected: (bool newValue) {
                  if (newValue) {
                    mondayController.text = "Monday";
                    // addForm(mondayController.text);
                    daysSelected.add("Monday");
                  } else {
                    mondayController.text = "";

                    removeSlots("Monday");
                  }
                }),
            FastChoiceChip(
              selectedColor: MyThemes.btnBox,
              value: 'Tuesday',
              onSelected: (bool newValue) {
                if (newValue) {
                  tuesdayController.text = "Tuesday";
                  // addForm(mondayController.text);
                  daysSelected.add("Tuesday");
                } else {
                  tuesdayController.text = "";

                  removeSlots("Tuesday");
                }
              },
            ),
            FastChoiceChip(
              selectedColor: MyThemes.btnBox,
              value: 'Wednesday',
              onSelected: (bool newValue) {
                if (newValue) {
                  wednesdayController.text = "Wednesday";
                  // addForm(mondayController.text);
                  daysSelected.add("Wednesday");
                } else {
                  wednesdayController.text = "";

                  removeSlots("Wednesday");
                }
              },
            ),
            FastChoiceChip(
              selectedColor: MyThemes.btnBox,
              value: 'Thursday',
              onSelected: (bool newValue) {
                if (newValue) {
                  thursdayController.text = "Thursday";
                  // addForm(mondayController.text);
                  daysSelected.add("Thursday");
                } else {
                  thursdayController.text = "";

                  removeSlots("Thursday");
                }
              },
            ),
            FastChoiceChip(
              selectedColor: MyThemes.btnBox,
              value: 'Friday',
              onSelected: (bool newValue) {
                if (newValue) {
                  fridayController.text = "Friday";
                  // addForm(mondayController.text);
                  daysSelected.add("Friday");
                } else {
                  fridayController.text = "";

                  removeSlots("Friday");
                }
              },
            ),
          ],
          validator: (value) => value == null || value.isEmpty
              ? 'Please select at least one chip'
              : null,
        ),
        15.squareBox,
        FastRadioGroup<String>(
          initialValue: "3",
          name: 'Slots',
          labelText: 'Total Slots Per Day',
          options: const [
            FastRadioOption(text: '5', value: '5'),
            FastRadioOption(text: '3', value: '3'),
          ],
          onChanged: (value) {
            slotsController.text = value.toString();
          },
          validator: (value) {
            if (slotsController.text == "") {
              slotsController.text = "3";
            }
          },
        ),
        15.squareBox,
        FastTextField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (exp) {
              if (exp == null || exp == "") {
                return "Please enter price";
              }
            },
            keyboardType: TextInputType.number,
            name: 'Price',
            labelText: 'Price',
            onChanged: (value) => priceController.text = value.toString()),
        15.squareBox,
      ];
    });
  }

  @override
  final _formKey = GlobalKey<FormState>();

  Validate validate = new Validate();

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
                      "Schedule".text.xl4.color(MyThemes.textColor).make(),
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
                          children: formsWidgets,
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
                          onTap: () => nextPage(),
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
                                      "Next",
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
  }

  void nextPage() async {
    final isValid = _formKey.currentState!.validate();

    if (!isValid) return;

    final db = FirebaseFirestore.instance;

    final user = FirebaseAuth.instance.currentUser!.email;

    try {
      await FirebaseFirestore.instance
          .collection("schedule")
          .doc(user.toString())
          .set({
        "maximum-appointments": slotsController.text,
        "pricing": priceController.text,
        "timing": ""
      });
    } on FirebaseAuthException catch (e) {
      print(e);
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddSlots(
          selectionDays: daysSelected,
          slotCount: slotsController.text,
        ),
      ),
    );
  }
}

class AddSlots extends StatefulWidget {
  final List selectionDays;
  final String slotCount;
  const AddSlots({
    Key? key,
    required this.selectionDays,
    required this.slotCount,
  }) : super(key: key);

  @override
  State<AddSlots> createState() => _AddSlotsState();
}

class _AddSlotsState extends State<AddSlots> {
  bool changedButton = false;

  List<Widget> formsWidgets = [];

  List daysSelected = [];

  DoctorRoutine dr = new DoctorRoutine();

  Map<String, dynamic> timing = {};
  Map<String, dynamic> timingByDay = {};
  Map<String, dynamic> timingBySlot = {};

  final mondayController = new TextEditingController();
  final tuesdayController = new TextEditingController();
  final wednesdayController = new TextEditingController();
  final thursdayController = new TextEditingController();
  final fridayController = new TextEditingController();
  final priceController = new TextEditingController();
  final slotsController = new TextEditingController();

  @override
  void dispose() {
    mondayController.dispose();
    tuesdayController.dispose();
    wednesdayController.dispose();
    thursdayController.dispose();
    fridayController.dispose();
    priceController.dispose();
    slotsController.dispose();

    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initializeWidget();
  }

  void removeSlots(String item) {
    for (var i = 0; i < daysSelected.length; i++) {
      if (daysSelected[i] == item) {
        setState(() {
          daysSelected.remove(item);
        });
      }
    }
  }

  void initializeWidget() {
    print(widget.selectionDays.toString());

    for (var i = 0; i < widget.selectionDays.length; i++) {
      formsWidgets.add(widget.selectionDays[i].toString().text.xl.make());
      for (var j = 0; j < int.parse(widget.slotCount); j++) {
        int s_count = j + 1;
        setState(() {
          formsWidgets.add(FastTimePicker(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            name: 'Slot',
            labelText: 'Slot ' + s_count.toString(),
            onChanged: (value) {
              DateTime now = DateTime.now();
              DateTime dateTime = DateTime(
                now.year,
                now.month,
                now.day,
                value!.hour,
                value.minute,
              );

              timingBySlot["slot-${s_count}"] = {
                "slot-number": s_count.toString(),
                "status": "open",
                "time": dateTime
              };
            },
          ).pOnly(bottom: 20));
        });
      }
      timingByDay[widget.selectionDays[i]] = timingBySlot;
      timing = timingByDay;
    }
  }

  @override
  final _formKey = GlobalKey<FormState>();

  Validate validate = new Validate();

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
                      "Schedule".text.xl4.color(MyThemes.textColor).make(),
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
                          children: formsWidgets,
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
                          onTap: () => nextPage(),
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
                                      "Next",
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
  }

  void nextPage() async {
    final isValid = _formKey.currentState!.validate();

    if (!isValid) return;

    final db = FirebaseFirestore.instance;

    final user = FirebaseAuth.instance.currentUser!.email;

    try {
      await FirebaseFirestore.instance
          .collection("schedule")
          .doc(user.toString())
          .update({"timing": timing});

      QuickAlert.show(
          context: context,
          text: "Routine added successfully",
          type: QuickAlertType.success,
          onConfirmBtnTap: () {
            Navigator.pushNamed(context, MyRoutes.doctorDash);
          });
    } on FirebaseAuthException catch (e) {
      print(e);
    }
  }
}

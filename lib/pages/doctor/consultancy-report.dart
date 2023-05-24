// ignore_for_file: public_member_api_docs, sort_constructors_first, prefer_const_literals_to_create_immutables, unnecessary_new, use_build_context_synchronously, prefer_interpolation_to_compose_strings
// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fast_forms/flutter_fast_forms.dart';
import 'package:intl/intl.dart';
import 'package:quickalert/quickalert.dart';
import 'package:remedy_app/widgets/notifications.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:velocity_x/velocity_x.dart';

import 'package:remedy_app/pages/patient/validate-patient.dart';

import '../../utils/routes.dart';
import '../../widgets/singleton-widget.dart';
import '../../widgets/themes.dart';

class ConsultancyReport extends StatefulWidget {
  @override
  State<ConsultancyReport> createState() => _ConsultancyReportState();
}

class _ConsultancyReportState extends State<ConsultancyReport> {
  List userList = [];

  List<Widget> medicineTextBox = [];

  @override
  initState() {
    super.initState();
  }

  // List userData = Singleton.userData;

  bool changedButton = false;

  final historyController = new TextEditingController();
  final assesmentController = new TextEditingController();
  final careController = new TextEditingController();

  @override
  void dispose() {
    super.dispose();
  }

  List userData = Singleton.userData;

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
                  padding: EdgeInsets.all(15.0),
                  child: Column(
                    children: [
                      "Consultance Report"
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
                            "History of illness".text.xl3.bold.make(),
                            15.squareBox,
                            FastTextField(
                              keyboardType: TextInputType.multiline,
                              maxLines: null,
                              minLines: 5,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: (desc) {
                                if (desc == null || desc == "") {
                                  return "Please enter reason";
                                }
                              },
                              name: 'history',
                              labelText: 'History',
                              onChanged: (value) =>
                                  historyController.text = value.toString(),
                            ),
                            15.squareBox,
                            "Assesment".text.xl3.bold.make(),
                            15.squareBox,
                            FastTextField(
                              keyboardType: TextInputType.multiline,
                              maxLines: null,
                              minLines: 5,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: (desc) {
                                if (desc == null || desc == "") {
                                  return "Please enter reason";
                                }
                              },
                              name: 'assesment',
                              labelText: 'Assesment',
                              onChanged: (value) =>
                                  assesmentController.text = value.toString(),
                            ),
                            15.squareBox,
                            "Plan of care".text.xl3.bold.make(),
                            15.squareBox,
                            FastTextField(
                              keyboardType: TextInputType.multiline,
                              maxLines: null,
                              minLines: 5,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: (desc) {
                                if (desc == null || desc == "") {
                                  return "Please enter reason";
                                }
                              },
                              name: 'plan-of-care',
                              labelText: 'Plan of Care',
                              onChanged: (value) =>
                                  careController.text = value.toString(),
                            ),
                            15.squareBox,
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
                          onTap: () => nextPage(),
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
    ;
  }

  void nextPage() async {
    final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

    User? user = _firebaseAuth.currentUser;

    Map<String, dynamic> toGetCount = {};
    int prescriptionCount = 0;

    final data = await FirebaseFirestore.instance //here
        .collection("consultancy")
        .doc(user!.email.toString()) //need to change this
        .get();

    try {
      setState(() {
        toGetCount = data.data()!;
        prescriptionCount = toGetCount.length;
      });
    } catch (e) {}

    prescriptionCount++;

    String prescriptionNumber = "Consultancy-" + prescriptionCount.toString();

    Map<String, dynamic> setData = {
      "history": historyController.text,
      "assesment": assesmentController.text,
      "plan-of-care": careController.text,
      "prescription-no": prescriptionCount.toString()
    };

    try {
      final data = await FirebaseFirestore.instance //here
          .collection("consultancy")
          .doc(user!.email.toString()) //need to change this
          .update({prescriptionNumber: setData});
    } on Exception catch (e) {
      // TODO
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Prescriptions(
          consultancyNumber: prescriptionCount,
        ),
      ),
    );
  }
}

// ignore_for_file: public_member_api_docs, sort_constructors_first, prefer_const_literals_to_create_immutables, unnecessary_new, use_build_context_synchronously
// ignore_for_file: prefer_const_constructors

class Prescriptions extends StatefulWidget {
  @override
  State<Prescriptions> createState() => _PrescriptionsState();

  final int consultancyNumber;
  const Prescriptions({
    Key? key,
    required this.consultancyNumber,
  }) : super(key: key);
}

class _PrescriptionsState extends State<Prescriptions> {
  List userList = [];

  List<Widget> medicineTextBox = [];

  Map<String, dynamic> allMedicines = {};
  Map<String, dynamic> singleMedicine = {};

  @override
  initState() {
    super.initState();

    getPrescriptionData();
  }

  // List userData = Singleton.userData;

  bool changedButton = false;

  final medinineNameController = new TextEditingController();
  final timesPerDayController = new TextEditingController();
  final durationController = new TextEditingController();
  var additionalInfoController = new TextEditingController();

  @override
  void dispose() {
    super.dispose();
  }

  List userData = Singleton.userData;

  int prescriptionNumberForMedicine = 0;

  @override
  final _formKey = GlobalKey<FormState>();

  Validate validate = new Validate();
  int prescriptionCount = 0;
  Map<String, dynamic> toGetCount = {};

  Future getPrescriptionData() async {
    final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

    User? user = _firebaseAuth.currentUser;

    final data = await FirebaseFirestore.instance //here
        .collection("consultancy")
        .doc(user!.email.toString()) //need to change this
        .get();

    try {
      setState(() {
        toGetCount = data.data()!;
        prescriptionCount = toGetCount.length;
        prescriptionNumberForMedicine = widget.consultancyNumber;
      });
    } catch (e) {}

    print(data.data()!.toString());

    if (prescriptionCount == 0) {
      prescriptionCount = 1;
    }
  }

  Widget build(BuildContext context) {
    final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

    User? user = _firebaseAuth.currentUser;

    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: MyThemes.btnBox,
        body: Container(
          child: SafeArea(
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Column(
                    children: [
                      "Consultance Report"
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
                            "Prescriptions".text.xl3.bold.make(),
                            5.squareBox,
                            Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  TextButton(
                                      onPressed: () {
                                        int medicineCount =
                                            medicineTextBox.length + 1;

                                        String medCount = "Medicine " +
                                            medicineCount.toString();
                                        setState(() {
                                          medicineTextBox.add(Container(
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                  width: 1,
                                                  color: Colors.green),
                                              color: Color.fromARGB(
                                                  255, 243, 235, 235),
                                            ),
                                            child: Column(
                                              children: [
                                                5.squareBox,
                                                medCount.text.xl2.make(),
                                                5.squareBox,
                                                FastTextField(
                                                  keyboardType:
                                                      TextInputType.multiline,
                                                  maxLines: null,
                                                  minLines: 1,
                                                  autovalidateMode:
                                                      AutovalidateMode
                                                          .onUserInteraction,
                                                  validator: (desc) {
                                                    if (desc == null ||
                                                        desc == "") {
                                                      return "Please enter medicine name";
                                                    }
                                                  },
                                                  name: 'medicine-name',
                                                  labelText: 'Medicine Name',
                                                  onChanged: (value) =>
                                                      medinineNameController
                                                              .text =
                                                          value.toString(),
                                                ),
                                                5.squareBox,
                                                FastTextField(
                                                  keyboardType:
                                                      TextInputType.number,
                                                  maxLines: null,
                                                  minLines: 1,
                                                  autovalidateMode:
                                                      AutovalidateMode
                                                          .onUserInteraction,
                                                  validator: (desc) {
                                                    if (desc == null ||
                                                        desc == "") {
                                                      return "Please enter times";
                                                    }
                                                  },
                                                  name: 'times-per-day',
                                                  labelText: 'Times Per Day',
                                                  onChanged: (value) =>
                                                      timesPerDayController
                                                              .text =
                                                          value.toString(),
                                                ),
                                                5.squareBox,
                                                FastTextField(
                                                  keyboardType:
                                                      TextInputType.multiline,
                                                  maxLines: null,
                                                  minLines: 1,
                                                  autovalidateMode:
                                                      AutovalidateMode
                                                          .onUserInteraction,
                                                  validator: (desc) {
                                                    if (desc == null ||
                                                        desc == "") {
                                                      return "Please enter duration";
                                                    }
                                                  },
                                                  name: 'medicine-duration',
                                                  labelText: 'Duration in days',
                                                  onChanged: (value) =>
                                                      durationController.text =
                                                          value.toString(),
                                                ),
                                                5.squareBox,
                                                FastTextField(
                                                  keyboardType:
                                                      TextInputType.multiline,
                                                  maxLines: null,
                                                  minLines: 1,
                                                  autovalidateMode:
                                                      AutovalidateMode
                                                          .onUserInteraction,
                                                  name: 'medicine-additional',
                                                  labelText:
                                                      'Additional Information',
                                                  onChanged: (value) =>
                                                      additionalInfoController
                                                              .text =
                                                          value.toString(),
                                                ),
                                                TextButton(
                                                    onPressed: () {
                                                      FillNotification fill =
                                                          FillNotification(
                                                              medicine_name:
                                                                  medinineNameController
                                                                      .text,
                                                              userID:
                                                                  "ludenstrky@gmail.com",
                                                              times_per_day:
                                                                  timesPerDayController
                                                                      .text);

                                                      fill.setNotification();

                                                      String count =
                                                          "Medicine-" +
                                                              prescriptionCount
                                                                  .toString();

                                                      setState(() {
                                                        singleMedicine[count] =
                                                            {
                                                          "name":
                                                              medinineNameController
                                                                  .text,
                                                          "times-per-day":
                                                              timesPerDayController
                                                                  .text,
                                                          "duration":
                                                              durationController
                                                                  .text,
                                                          "additional-info":
                                                              additionalInfoController
                                                                  .text,
                                                          "prescribed-by": user!
                                                              .email
                                                              .toString(),
                                                          "for-consultancy-no":
                                                              prescriptionNumberForMedicine,
                                                        };
                                                      });

                                                      prescriptionCount++;
                                                    },
                                                    child: "Save"
                                                        .text
                                                        .xl
                                                        .green700
                                                        .make())
                                              ],
                                            ).p8(),
                                          ));
                                        });
                                      },
                                      child:
                                          "Add medicine".text.green700.make()),
                                  TextButton(
                                      onPressed: () {
                                        int currentCount =
                                            prescriptionCount - 1;

                                        setState(() {
                                          medicineTextBox.removeLast();
                                          singleMedicine.removeWhere((key,
                                                  value) =>
                                              key ==
                                              "Medicine-" +
                                                  currentCount.toString());
                                        });
                                      },
                                      child:
                                          "Delete medicine".text.red700.make()),
                                ]),
                            15.squareBox,
                            Container(
                              height: 500,
                              child: ListView.builder(
                                  itemCount: medicineTextBox.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return ListTile(
                                        title: medicineTextBox[index]);
                                  }),
                            ),
                          ],
                        ).p12(),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      12.squareBox,
                      Material(
                        color: Color(0xff57C5B6),
                        // shape: changedButton ? BoxShape.circle : BoxShape.rectangle,
                        borderRadius:
                            BorderRadius.circular(changedButton ? 50 : 8),
                        child: InkWell(
                          onTap: () => submitMedicines(),
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

  void submitMedicines() async {
    final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

    User? user = _firebaseAuth.currentUser;

    Map<String, dynamic> toGetCount = {};
    int prescriptionCount = 0;

    final data = await FirebaseFirestore.instance //here
        .collection("prescriptions")
        .doc("ludenstrky@gmail.com") //need to change this
        .get();

    try {
      setState(() {
        toGetCount = data.data()!;
        prescriptionCount = toGetCount.length;
      });
    } catch (e) {}

    prescriptionCount++;

    String prescriptionNumber =
        "Prescription-" + widget.consultancyNumber.toString();

    Map<String, dynamic> setData = singleMedicine;

    try {
      final data = await FirebaseFirestore.instance //here
          .collection("prescriptions")
          .doc("ludenstrky@gmail.com") //need to change this
          .update({prescriptionNumber: setData});
    } on Exception catch (e) {
      // TODO
    }

    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) => (),
    //   ),
    // );
  }
}

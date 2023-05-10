// ignore_for_file: public_member_api_docs, sort_constructors_first, prefer_const_literals_to_create_immutables, unnecessary_new
// ignore_for_file: prefer_const_constructors

import 'package:animate_gradient/animate_gradient.dart';
import 'package:flutter_fast_forms/flutter_fast_forms.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:remedy_app/data/submit-patient-data.dart';
import 'package:remedy_app/pages/patient/patients_page.dart';
import 'package:remedy_app/pages/patient/validate-patient.dart';
import 'package:remedy_app/widgets/anime-gradient.dart';
import 'package:social_login_buttons/social_login_buttons.dart';
import 'package:velocity_x/velocity_x.dart';

import 'package:remedy_app/pages/login_page.dart';

import '../../utils/routes.dart';
import '../../widgets/themes.dart';

class PatientPersonalForm extends StatefulWidget {
  @override
  State<PatientPersonalForm> createState() => _PatientPersonalFormState();
}

class _PatientPersonalFormState extends State<PatientPersonalForm> {
  bool changedButton = false;

  final fnameController = new TextEditingController();
  final lnameController = new TextEditingController();
  final dateController = new TextEditingController();
  final addressController = new TextEditingController();
  final phoneController = new TextEditingController();
  final heightController = new TextEditingController();
  final weightController = new TextEditingController();
  final sexController = new TextEditingController();
  final bloodGroupController = new TextEditingController();

  @override
  void dispose() {
    fnameController.dispose();
    lnameController.dispose();
    dateController.dispose();
    addressController.dispose();
    phoneController.dispose();
    heightController.dispose();
    weightController.dispose();
    sexController.dispose();
    bloodGroupController.dispose();

    super.dispose();
  }

  @override
  final _formKey = GlobalKey<FormState>();

  Validate validate = new Validate();

  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Color(0xffB9EDDD),
        body: Container(
          child: SafeArea(
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Padding(
                  padding: EdgeInsets.all(30.0),
                  child: Column(
                    children: [
                      "Patient Info".text.xl4.color(MyThemes.textColor).make(),
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
                            "Personal Information".text.xl3.make(),
                            5.squareBox,
                            FastTextField(
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: (fname) =>
                                  fname != null && validate.validateName(fname)
                                      ? "Enter a valid first name"
                                      : null,
                              name: 'first_name',
                              labelText: 'First Name',
                              onChanged: (value) =>
                                  fnameController.text = value.toString(),
                            ),
                            15.squareBox,
                            FastTextField(
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: (lname) =>
                                  lname != null && validate.validateName(lname)
                                      ? "Enter a valid last name"
                                      : null,
                              name: 'last_name',
                              labelText: 'Last Name',
                              onChanged: (value) =>
                                  lnameController.text = value.toString(),
                            ),
                            15.squareBox,
                            FastDatePicker(
                              name: 'dob',
                              labelText: 'Date of Birth',
                              firstDate: DateTime(1940),
                              lastDate: DateTime.now(),
                              onChanged: (value) =>
                                  dateController.text = value.toString(),
                              validator: (value) {
                                if (dateController.text == "") {
                                  dateController.text =
                                      DateTime.now().toString();
                                }
                              },
                            ),
                            15.squareBox,
                            FastTextField(
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: (address) => address != null &&
                                        validate.validateAddress(address)
                                    ? "Enter a valid address"
                                    : null,
                                name: 'address',
                                labelText: 'Address',
                                onChanged: (value) =>
                                    addressController.text = value.toString()),
                            15.squareBox,
                            FastTextField(
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: (phone) => phone != null &&
                                        validate.validatePhoneNumber(phone)
                                    ? "Enter a valid phone number"
                                    : null,
                                keyboardType: TextInputType.number,
                                name: 'phone',
                                labelText: 'Phone Number (+977)',
                                onChanged: (value) =>
                                    phoneController.text = value.toString()),
                            15.squareBox,
                            FastTextField(
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: (height) => height != null &&
                                        validate.validateHeightandWeight(height)
                                    ? "Enter a valid height"
                                    : null,
                                keyboardType: TextInputType.number,
                                name: 'height',
                                labelText: 'Height in cm',
                                onChanged: (value) =>
                                    heightController.text = value.toString()),
                            15.squareBox,
                            FastTextField(
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: (weight) => weight != null &&
                                        validate.validateHeightandWeight(weight)
                                    ? "Enter a valid weight"
                                    : null,
                                keyboardType: TextInputType.number,
                                name: 'weight',
                                labelText: 'Weight in kg',
                                onChanged: (value) =>
                                    weightController.text = value.toString()),
                            15.squareBox,
                            FastRadioGroup<String>(
                                name: 'sex',
                                labelText: 'Sex',
                                options: const [
                                  FastRadioOption(text: 'Male', value: 'Male'),
                                  FastRadioOption(
                                      text: 'Female', value: 'Female'),
                                ],
                                onChanged: (value) =>
                                    sexController.text = value.toString(),
                                validator: (value) {
                                  if (sexController.text == "") {
                                    sexController.text = "Male";
                                  }
                                }),
                            15.squareBox,
                            FastDropdown<String>(
                              name: 'bloodgroup',
                              labelText: 'Blood Group',
                              items: [
                                'A+',
                                'A-',
                                'B+',
                                'B-',
                                'O+',
                                'O-',
                                'AB+',
                                'AB-'
                              ],
                              initialValue: 'A+',
                              onChanged: (value) =>
                                  bloodGroupController.text = value.toString(),
                              validator: (value) {
                                if (bloodGroupController.text == "") {
                                  bloodGroupController.text = 'A+';
                                }
                              },
                            )
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
                                      "Submit",
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

  void nextPage() {
    final isValid = _formKey.currentState!.validate();

    if (!isValid) return;

    PatientPersonalData healthdata = PatientPersonalData(
      fname: fnameController.text,
      lname: lnameController.text,
      dob: dateController.text,
      address: addressController.text,
      phone: phoneController.text,
      height: heightController.text,
      weight: weightController.text,
      sex: sexController.text,
      bloodGroup: bloodGroupController.text,
    );

    healthdata.submitData();

    Navigator.pushNamed(context, MyRoutes.patientHealthForm);
  }

  /**
   * 
   * Form Submit and validation
   * 
   * 
   */
}

class PatientHealthForm extends StatefulWidget {
  @override
  State<PatientHealthForm> createState() => _PatientHealthFormState();
}

class _PatientHealthFormState extends State<PatientHealthForm> {
  final _formKey = GlobalKey<FormState>();
  bool changedButton = false;

  final allergyController = new TextEditingController();

  final alergySpecificController = new TextEditingController();

  final asthamaController = new TextEditingController();
  final asthamaSpecificController = new TextEditingController();
  final diabetesController = new TextEditingController();
  final diabetesSpecificController = new TextEditingController();
  final seisurezController = new TextEditingController();
  final seisureSpecificController = new TextEditingController();

  final otherIssuesController = new TextEditingController();

  @override
  void dispose() {
    allergyController.dispose();
    alergySpecificController.dispose();
    asthamaController.dispose();
    asthamaSpecificController.dispose();
    diabetesController.dispose();
    diabetesSpecificController.dispose();
    seisurezController.dispose();
    seisureSpecificController.dispose();
    otherIssuesController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Color(0xffB9EDDD),
        body: Container(
          child: SafeArea(
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Padding(
                  padding: EdgeInsets.all(30.0),
                  child: Column(
                    children: [
                      "Patient Info".text.xl4.color(MyThemes.textColor).make(),
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
                              "Health Information".text.xl3.make(),
                              "Allergy".text.xl.make(),
                              10.squareBox,
                              "Do you have any allergies ?".text.medium.make(),
                              15.squareBox,
                              FastRadioGroup<String>(
                                  initialValue: "yes-allergy",
                                  name: 'allergy',
                                  labelText: 'Allergy',
                                  options: const [
                                    FastRadioOption(
                                        text: 'Yes', value: 'yes-allergy'),
                                    FastRadioOption(
                                        text: 'No', value: 'no-allergy'),
                                  ],
                                  onChanged: (value) =>
                                      allergyController.text = value.toString(),
                                  validator: (value) {
                                    if (allergyController.text == "") {
                                      allergyController.text = "yes-allergy";
                                    }
                                  }),
                              15.squareBox,
                              FastTextField(
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                name: 'allergy-specific',
                                labelText: 'If yes, please specify',
                                validator: (value) =>
                                    allergyController.text == "yes-allergy" &&
                                            value == ""
                                        ? "Please enter the specifics"
                                        : null,
                                onChanged: (value) => alergySpecificController
                                    .text = value.toString(),
                              ),
                              15.squareBox,
                              "Asthama".text.xl.make(),
                              10.squareBox,
                              "Do you suffer from asthma ?".text.medium.make(),
                              15.squareBox,
                              FastRadioGroup<String>(
                                  name: 'asthama',
                                  labelText: 'Asthama',
                                  options: const [
                                    FastRadioOption(
                                        text: 'Yes', value: 'yes-asthama'),
                                    FastRadioOption(
                                        text: 'No', value: 'no-asthama'),
                                  ],
                                  onChanged: (value) =>
                                      asthamaController.text = value.toString(),
                                  validator: (value) {
                                    if (asthamaController.text == "") {
                                      asthamaController.text = "yes-asthama";
                                    }
                                  }),
                              15.squareBox,
                              FastTextField(
                                name: 'asthama-specific',
                                labelText: 'If yes, please specify',
                                validator: (value) =>
                                    asthamaController.text == "yes-asthama" &&
                                            value == ""
                                        ? "Please enter the specifics"
                                        : null,
                                onChanged: (value) => asthamaSpecificController
                                    .text = value.toString(),
                              ),
                              15.squareBox,
                              "Diabetes".text.xl.make(),
                              10.squareBox,
                              "Do you have diabetes ?".text.medium.make(),
                              15.squareBox,
                              FastRadioGroup<String>(
                                  name: 'diabetes',
                                  labelText: 'Diabetes',
                                  options: const [
                                    FastRadioOption(
                                        text: 'Yes', value: 'yes-diabetes'),
                                    FastRadioOption(
                                        text: 'No', value: 'no-diabetes'),
                                  ],
                                  onChanged: (value) => diabetesController
                                      .text = value.toString(),
                                  validator: (value) {
                                    if (diabetesController.text == "") {
                                      diabetesController.text = "yes-diabetes";
                                    }
                                  }),
                              15.squareBox,
                              FastTextField(
                                name: 'diabetes-specific',
                                labelText: 'If yes, please specify',
                                validator: (value) =>
                                    asthamaController.text == "yes-diabetes" &&
                                            value == ""
                                        ? "Please enter the specifics"
                                        : null,
                                onChanged: (value) => asthamaSpecificController
                                    .text = value.toString(),
                              ),
                              15.squareBox,
                              "Seizures".text.xl.make(),
                              10.squareBox,
                              "Do you suffer from seizures ?"
                                  .text
                                  .medium
                                  .make(),
                              15.squareBox,
                              FastRadioGroup<String>(
                                  name: 'seizures',
                                  labelText: 'Seizures',
                                  options: const [
                                    FastRadioOption(
                                        text: 'Yes', value: 'yes-seizures'),
                                    FastRadioOption(
                                        text: 'No', value: 'no-seizures'),
                                  ],
                                  onChanged: (value) => seisurezController
                                      .text = value.toString(),
                                  validator: (value) {
                                    if (seisurezController.text == "") {
                                      seisurezController.text = "yes-seizures";
                                    }
                                  }),
                              15.squareBox,
                              FastTextField(
                                name: 'seizures-specific',
                                labelText: 'If yes, please specify',
                                validator: (value) =>
                                    seisurezController.text == "yes-seizures" &&
                                            value == ""
                                        ? "Please enter the specifics"
                                        : null,
                                onChanged: (value) => seisureSpecificController
                                    .text = value.toString(),
                              ),
                              15.squareBox,
                              FastTextField(
                                name: 'other-issues',
                                labelText: 'Any other health issues',
                                onChanged: (value) => otherIssuesController
                                    .text = value.toString(),
                              )
                            ],
                          ).p12()),
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
                          onTap: () => submit(),
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
                                      "Submit",
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

  void submit() {
    final isValid = _formKey.currentState!.validate();

    if (!isValid) return;

    if (!isValid) return;

    PatientHealthData healthdata = PatientHealthData(
        allergy: allergyController.text,
        allergy_specific: alergySpecificController.text,
        asthama: asthamaController.text,
        asthama_specific: asthamaSpecificController.text,
        diabetes: diabetesController.text,
        diabetes_specific: diabetesSpecificController.text,
        seizures: seisurezController.text,
        seizures_specific: seisureSpecificController.text,
        others: otherIssuesController.text);

    healthdata.submitData();

    Navigator.pushNamed(context, MyRoutes.patientsProfileRoute);

    // print(allergyController.text);
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

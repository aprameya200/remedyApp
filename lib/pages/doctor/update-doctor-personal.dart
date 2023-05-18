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

import '../../data/submit-doctor-data.dart';
import '../../utils/routes.dart';
import '../../widgets/singleton-widget.dart';
import '../../widgets/themes.dart';

class UpdateDoctorPersonalForm extends StatefulWidget {
  @override
  State<UpdateDoctorPersonalForm> createState() =>
      _UpdateDoctorPersonalFormState();
}

class _UpdateDoctorPersonalFormState extends State<UpdateDoctorPersonalForm> {
  List userList = [];

  @override
  initState() {
    super.initState();

    fnameController.text = userData[0]["first-name"];
    lnameController.text = userData[0]["last-name"];
    dateController.text = userData[0]["date-of-birth"];
    addressController.text = userData[0]["address"];
    phoneController.text = userData[0]["phone"];
    sexController.text = userData[0]["sex"];
    departmentController.text = userData[0]["department"];
    experienceController.text = userData[0]["experience"];
  }

  List userData = Singleton.userData;

  bool changedButton = false;

  final fnameController = new TextEditingController();
  final lnameController = new TextEditingController();
  final dateController = new TextEditingController();
  final addressController = new TextEditingController();
  final phoneController = new TextEditingController();
  final sexController = new TextEditingController();
  final departmentController = new TextEditingController();
  final experienceController = new TextEditingController();

  @override
  void dispose() {
    fnameController.dispose();
    lnameController.dispose();
    dateController.dispose();
    addressController.dispose();
    phoneController.dispose();
    departmentController.dispose();
    experienceController.dispose();
    sexController.dispose();

    super.dispose();
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
                      "Doctor Info".text.xl4.color(MyThemes.textColor).make(),
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
                            FastAutocomplete<String>(
                              initialValue: TextEditingValue(
                                  text: departmentController.text),
                              validator: (value) => value == null
                                  ? "Please select a speciality"
                                  : null,
                              onSelected: (option) =>
                                  departmentController.text = option.toString(),
                              name: 'speciality',
                              labelText: 'Speciality',
                              options: const [
                                'Pediatrician',
                                'Allergist',
                                'Dermatologist',
                                'Ophthalmologist',
                                'Gynecologist',
                                'Cardiologist',
                                'Endocrinologist',
                                'Gastroenterologist',
                                'Nephrologist',
                                'Urologist',
                                'Pulmonologist',
                                'Otolaryngologist',
                                'Neurologist',
                                'Psychiatrist',
                                'Oncologist',
                                'Radiologist',
                                'Rheumatologist',
                                'Anesthesiologist',
                              ],
                            ),
                            15.squareBox,
                            FastTextField(
                              initialValue: fnameController.text,
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
                              initialValue: lnameController.text,
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
                              initialValue: dateController.text.toDate(),
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
                              initialValue: addressController.text,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: (address) => address != null &&
                                      validate.validateAddress(address)
                                  ? "Enter a valid address"
                                  : null,
                              name: 'address',
                              labelText: 'Address',
                              onChanged: (value) =>
                                  addressController.text = value.toString(),
                            ),
                            15.squareBox,
                            FastTextField(
                              initialValue: phoneController.text,
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
                                  phoneController.text = value.toString(),
                            ),
                            15.squareBox,
                            FastRadioGroup<String>(
                              initialValue: sexController.text,
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
                              },
                            ),
                            15.squareBox,
                            FastTextField(
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: (exp) => exp != null &&
                                      validate.validateHeightandWeight(exp)
                                  ? "Enter a valid number"
                                  : null,
                              keyboardType: TextInputType.number,
                              name: 'experience',
                              labelText: 'Experience in years',
                              onChanged: (value) =>
                                  experienceController.text = value.toString(),
                              initialValue: phoneController.text,
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

  void updateData() {
    final isValid = _formKey.currentState!.validate();

    if (!isValid) return;

    SubmitDoctorData healthdata = SubmitDoctorData(
      fname: fnameController.text,
      lname: lnameController.text,
      dob: dateController.text,
      address: addressController.text,
      phone: phoneController.text,
      department: departmentController.text,
      sex: sexController.text,
      experience: experienceController.text,
    );

    healthdata.update();

    Navigator.pushNamed(context, MyRoutes.doctorDash);
  }

  /**
   * 
   * Form Submit and validation
   * 
   * 
   */
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

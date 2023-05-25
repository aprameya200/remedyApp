import 'package:animate_gradient/animate_gradient.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:remedy_app/pages/doctor/consultancy-report.dart';
import 'package:remedy_app/pages/patient/vitals.dart';
import 'package:social_login_buttons/social_login_buttons.dart';
import 'package:velocity_x/velocity_x.dart';

import 'package:remedy_app/pages/sign-up_page.dart';

//Calander
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../../widgets/get-reports.dart';
import '../../widgets/themes.dart';
import 'ehr-doctor-display.dart';

class ReportPage extends StatefulWidget {
  final dummy;

  const ReportPage({super.key, required this.dummy});

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  Map<String, dynamic> allConsultancyReports = {};

  int counter = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getConsultancy();
  }

  Future getConsultancy() async {
    GetReports consultancy = GetReports();

    await consultancy.getReports();

    setState(() {
      allConsultancyReports = consultancy.consultancyData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // bottomNavigationBar: Example(),
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: "Reports".text.xl3.black.make(),
        backgroundColor: Colors.white,
        elevation: 0.0,
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            height: 200,
            child: ListView.builder(
                itemCount: allConsultancyReports.length,
                itemBuilder: (BuildContext context, int index) {
                  int count = index + 1;
                  String title = "Consultancy-" + count.toString();
                  return ListTile(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EletronicHealthRecordForDoctor(
                            patientEmail: 'ludenstrky@gmail.com',
                          ),
                        ),
                      );
                    },
                    leading: Text(title),
                  ).pOnly(bottom: 20);
                }),
          ).p12(),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ConsultancyReport(),
                ),
              );
            },
            child: "Add Report".text.xl3.black.make(),
          )
        ],
      ),
    );
  }
}

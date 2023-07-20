import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:meddoc/Styles/applayout.dart';
import 'package:meddoc/Widgets/NotificationContainer.dart';
import 'package:meddoc/Widgets/TitlewithNavigation.dart';

import '../DoctorsModel.dart';
import '../Styles/styles.dart';
import '../Widgets/EmptyContainer.dart';
import '../Widgets/GreetingContainer.dart';
import '../Widgets/HeadingNavigation.dart';
import '../Widgets/MainNotificationContainer.dart';
import '../Widgets/NearbyDoctorContainer.dart';
import 'PatientNavigationBar.dart';

class PatientDashboard extends StatefulWidget {
  const PatientDashboard({Key? key}) : super(key: key);

  @override
  State<PatientDashboard> createState() => _PatientDashboardState();
}

class _PatientDashboardState extends State<PatientDashboard> {
  String name = "";
  String imgURL = "";

  @override
  Widget build(BuildContext context) {
    final size = AppLayout.getSize(context);
    return Scaffold(
      backgroundColor: Styles.bgColor,
      body: Column(
        children: [
          InkWell(
              onTap: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (builder) => PatientNavigationBar(
                              selectedindex: 4,
                            )),
                    (route) => false);
              },
              child: GreetingContainer(
                title: name,
                imageAsset: imgURL,
              )),
          Expanded(
            child: ListView(
              scrollDirection: Axis.vertical,
              children: [
                MainDoctorsContainer(),
                Gap(30),
                MainNotificationContainer(),
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  void initState() {
    getPatientInfo();
  }

  void getPatientInfo() {
    DatabaseReference reference = FirebaseDatabase.instance
        .ref("Users")
        .child("Patients")
        .child(FirebaseAuth.instance.currentUser!.uid);

    Stream<DatabaseEvent> stream = reference.onValue;
    stream.listen((event) {
      setState(() {
        name = event.snapshot.child("name").value.toString();
        imgURL = event.snapshot.child("imgURL").value.toString();
      });
    });
  }
}

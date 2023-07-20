import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meddoc/Screens/DoctorsBottomBar.dart';
import 'package:meddoc/Screens/DoctorsDashboard.dart';
import 'package:meddoc/Screens/PatientNavigationBar.dart';
import 'package:meddoc/Styles/applayout.dart';
import 'package:meddoc/Styles/styles.dart';
import 'package:meddoc/Widgets/LoadingContainer.dart';
import '../Widgets/AppointmentCalender.dart';
import '../Widgets/DoctorCostContainer.dart';

import '../Widgets/DoctorDescriptionContainer.dart';
import '../Widgets/SmallPrimaryButton.dart';
import '../Widgets/TitlewithNavigation.dart';

class DoctorAppointBooking extends StatefulWidget {
  String DoctorUID;
  DoctorAppointBooking({Key? key, required this.DoctorUID}) : super(key: key);

  @override
  State<DoctorAppointBooking> createState() => _DoctorAppointBookingState();
}

class _DoctorAppointBookingState extends State<DoctorAppointBooking> {
  bool appointPossible = true;
  bool loading = true;

  @override
  void initState() {
    getPossibility();
  }

  @override
  Widget build(BuildContext context) {
    final size = AppLayout.getSize(context);
    return Scaffold(
        backgroundColor: Styles.bgColor,
        appBar: AppBar(
          backgroundColor: Styles.primaryColor,
          title: Text(
            'APPOINTMENT',
            style: GoogleFonts.montserrat(color: Colors.white, fontSize: 18),
          ),
        ),
        body: Column(
          children: [
            // TitleNavigation( title: 'APPOINTMENT',),
            loading
                ? LoadingContainer()
                : Expanded(
                    child: ListView(
                      shrinkWrap: true,
                      children: [
                        DoctorDescriptionContainer(DoctorUID: widget.DoctorUID),
                        Gap(10),
                        DoctorCostContainer(DoctorUID: widget.DoctorUID),
                        Gap(10),
                        appointPossible
                            ? AppointmentCalender(DoctorUID: widget.DoctorUID)
                            : Column(
                                children: [
                                  Padding(
                                      padding: EdgeInsets.all(16),
                                      child: Column(
                                        children: [
                                          Text(
                                            "You can't book another booking if the appointment is not done or approved by the specialist",
                                            style: GoogleFonts.montserrat(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w400),
                                            textAlign: TextAlign.center,
                                          ),
                                          Gap(20),
                                          InkWell(
                                            child: SmallPrimaryButton(
                                              title: 'See Appointments',
                                            ),
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (builder) =>
                                                          PatientNavigationBar(
                                                            selectedindex: 3,
                                                          )));
                                            },
                                          )
                                        ],
                                      )),
                                ],
                              )
                      ],
                    ),
                  )
          ],
        ));
  }

  void getPossibility() {
    List<String> names = [];
    DatabaseReference ref = FirebaseDatabase.instance.ref("bookings");
    Query query = ref.orderByChild("doctorID").equalTo(widget.DoctorUID);

    Stream<DatabaseEvent> event = query.onValue;
    event.listen((event) {
      if (event.snapshot.exists) {
        for (DataSnapshot dataSnapshot in event.snapshot.children) {
          if (dataSnapshot.child("patientID").value.toString() ==
              FirebaseAuth.instance.currentUser!.uid) {
            names.add(dataSnapshot.child("patientID").value.toString());
          }
        }
        setState(() {
          if (names.isEmpty) {
            appointPossible = true;
          } else {
            appointPossible = false;
          }
          loading = false;
        });
      } else {
        setState(() {
          loading = false;
        });
      }
    });
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meddoc/Screens/NewSplashScreen.dart';
import 'package:meddoc/Widgets/MainReviewsContainer.dart';
import 'package:meddoc/Widgets/ReviewsContainer.dart';

import '../Styles/applayout.dart';
import '../Styles/styles.dart';
import '../Widgets/ButtonsContainer.dart';
import '../Widgets/LargeImage.dart';
import '../Widgets/ListPropertiesTile.dart';
import '../Widgets/ProfileContainer.dart';
import '../Widgets/ProfilePictureContainer.dart';
import '../Widgets/StatContainer.dart';

class DoctorsProfile extends StatefulWidget {
  String docID;
  bool doctor;
  DoctorsProfile({Key? key, required this.docID, required this.doctor})
      : super(key: key);

  @override
  State<DoctorsProfile> createState() => _DoctorsProfileState();
}

class _DoctorsProfileState extends State<DoctorsProfile> {
  String imgURL = "";
  String email = "";
  String speciality = "";
  String experience = "";
  String name = "";
  String surName = "";
  String firstName = "";
  String age = "";
  String gender = "";
  String hospitalAddress = "";
  String phoneNumber = "";

  @override
  void initState() {
    getDoctorInfo();
  }

  @override
  Widget build(BuildContext context) {
    final size = AppLayout.getSize(context);
    return Scaffold(
        backgroundColor: Styles.bgColor,
        body: Column(
          children: [
            Expanded(
              child: ListView(
                scrollDirection: Axis.vertical,
                children: [
                  Column(children: [
                    Container(
                        decoration: BoxDecoration(color: Styles.primaryColor),
                        child: ProfilePictureContainer(
                          name: name,
                          imageAsset: imgURL,
                          age: age,
                          clinicAddress: hospitalAddress,
                          phonenumber: phoneNumber,
                        )),
                    Container(
                      decoration: BoxDecoration(color: Styles.secondryColor),
                      child: StatContainer(
                        heading1: "Speciality",
                        description1: speciality,
                        heading2: "Experience",
                        description2: experience + " Years",
                        heading3: "Gender",
                        description3: gender,
                      ),
                    ),
                    ButtonsContainer(
                        doctor: widget.doctor, docID: widget.docID, name: name),
                    MainReviewsContainer(
                      doc: widget.doctor,
                      docID: widget.docID,
                    ),
                  ]),
                ],
              ),
            )
          ],
        ));
  }

  void getDoctorInfo() {
    DatabaseReference ref = FirebaseDatabase.instance
        .ref("Users")
        .child("Doctors")
        .child(widget.docID);

    Stream<DatabaseEvent> event = ref.onValue;
    event.listen((event) {
      if (event.snapshot.exists) {
        setState(() {
          name = event.snapshot.child("name").value.toString();
          speciality = event.snapshot.child("specialization").value.toString();
          experience = event.snapshot.child("experience").value.toString();
          email = event.snapshot.child("email").value.toString();
          imgURL = event.snapshot.child("imgURL").value.toString();
          age = event.snapshot.child("age").value.toString();
          phoneNumber = event.snapshot.child("phonenumber").value.toString();
          gender = event.snapshot.child("gender").value.toString();
          hospitalAddress =
              event.snapshot.child("hospitalAddress").value.toString();
        });
      }
    });
  }
}

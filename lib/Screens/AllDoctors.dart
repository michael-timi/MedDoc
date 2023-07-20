import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meddoc/Styles/styles.dart';
import 'package:meddoc/Widgets/TitlewithNavigation.dart';
import '../DoctorsModel.dart';
import '../Widgets/HeadingNavigation.dart';
import '../Widgets/LoadingContainer.dart';
import '../Widgets/NearbyDoctorContainer.dart';
import '../Widgets/NotFoundContainer.dart';
import 'DoctorsProfile.dart';

class AllDoctors extends StatefulWidget {
  const AllDoctors({Key? key}) : super(key: key);

  @override
  State<AllDoctors> createState() => _AllDoctorsState();
}

class _AllDoctorsState extends State<AllDoctors> {
  List<DoctorsModel> data = [];

  DatabaseReference reference =
      FirebaseDatabase.instance.ref("Users").child("Doctors");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Styles.bgColor,
      appBar: AppBar(
        backgroundColor: Styles.primaryColor,
        title: Text(
          'All Doctors',
          style: GoogleFonts.montserrat(color: Colors.white, fontSize: 18),
        ),
      ),
      body: Column(
        children: [
          // TitleNavigation(title: "All Doctors"),
          Expanded(
            child: StreamBuilder(
              stream: reference.onValue,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data!.snapshot.children.length < 1) {
                    return NotFoundContainer();
                  }
                  data.clear();
                  for (DataSnapshot dataSnap
                      in snapshot.data!.snapshot.children) {
                    if (dataSnap.child("scheduled").exists) {
                      data.add(DoctorsModel(
                          dataSnap.key.toString(),
                          dataSnap.child("address").value.toString(),
                          dataSnap.child("age").value.toString(),
                          dataSnap.child("email").value.toString(),
                          dataSnap.child("experience").value.toString(),
                          dataSnap.child("gender").value.toString(),
                          dataSnap.child("hospitalAddress").value.toString(),
                          dataSnap.child("imgURL").value.toString(),
                          dataSnap.child("name").value.toString(),
                          dataSnap.child("password").value.toString(),
                          dataSnap.child("specialization").value.toString(),
                          dataSnap.child("type").value.toString()));
                    }
                  }
                } else {
                  return LoadingContainer();
                }
                return ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: data.length,
                    itemBuilder: (BuildContext context, index) {
                      return GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (builder) => DoctorsProfile(
                                        docID: data.elementAt(index).UID,
                                        doctor: false)));
                          },
                          child: Padding(
                              padding: EdgeInsets.only(top: 5),
                              child: NearbyDoctorContainer(
                                UID: data.elementAt(index).UID,
                                name: data.elementAt(index).name,
                                specialization:
                                    data.elementAt(index).specialization,
                                gender: data.elementAt(index).gender,
                                experience: data.elementAt(index).experience,
                                imgURL: data.elementAt(index).imgURL,
                              )));
                    });
              },
            ),
          ),
        ],
      ),
    );
  }
}

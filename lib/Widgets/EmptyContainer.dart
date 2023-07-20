import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meddoc/DoctorsModel.dart';
import 'package:meddoc/Screens/DoctorsProfile.dart';
import 'package:meddoc/Widgets/HeadingNavigation.dart';
import 'package:meddoc/Widgets/NearbyDoctorContainer.dart';

import '../Screens/AllDoctors.dart';
import '../Styles/applayout.dart';
import 'LoadingContainer.dart';
import 'NotFoundContainer.dart';

class MainDoctorsContainer extends StatefulWidget {
  const MainDoctorsContainer({Key? key}) : super(key: key);

  @override
  State<MainDoctorsContainer> createState() => _MainDoctorsContainerState();
}

class _MainDoctorsContainerState extends State<MainDoctorsContainer> {
  List<DoctorsModel> data = [];

  DatabaseReference reference =
      FirebaseDatabase.instance.ref("Users").child("Doctors");
  @override
  Widget build(BuildContext context) {
    final size = AppLayout.getSize(context);
    return Container(
      width: size.width,
      height: size.height * 0.37,
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Column(children: [
          GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (builder) => AllDoctors()));
            },
            child: Padding(
                padding: EdgeInsets.all(10),
                child: HeadingNav(title: "Specialists")),
          ),
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
                    scrollDirection: Axis.horizontal,
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
                          child: NearbyDoctorContainer(
                            UID: data.elementAt(index).UID,
                            name: data.elementAt(index).name,
                            specialization:
                                data.elementAt(index).specialization,
                            gender: data.elementAt(index).gender,
                            experience: data.elementAt(index).experience,
                            imgURL: data.elementAt(index).imgURL,
                          ));
                    });
              },
            ),
          ),
        ]),
      ),
    );
  }
}

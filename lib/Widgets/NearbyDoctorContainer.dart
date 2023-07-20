import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meddoc/Widgets/Smallicon.dart';
import 'package:unicons/unicons.dart';

import '../Screens/ChatScreen.dart';
import '../Screens/DoctorAppointBooking.dart';
import '../Styles/applayout.dart';
import '../Styles/styles.dart';
import 'LargeImage.dart';
import 'SmallPrimaryButton.dart';

class NearbyDoctorContainer extends StatefulWidget {
  String UID, name, specialization, gender, experience, imgURL;
  NearbyDoctorContainer(
      {Key? key,
      required this.UID,
      required this.name,
      required this.specialization,
      required this.gender,
      required this.experience,
      required this.imgURL})
      : super(key: key);

  @override
  State<NearbyDoctorContainer> createState() => _NearbyDoctorContainerState();
}

class _NearbyDoctorContainerState extends State<NearbyDoctorContainer> {
  String price = "";
  String percentage = "0";

  @override
  void initState() {
    getPrice();
    getPercentageInfo();
  }

  @override
  Widget build(BuildContext context) {
    final size = AppLayout.getSize(context);
    return Container(
      width: size.width,
      height: size.height * 0.25,
      padding: EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Gap(1),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              LargeImage(
                imageAsset: widget.imgURL,
              ),
              Column(
                children: [
                  Text("Fee",
                      style: GoogleFonts.montserrat(
                          fontSize: 14,
                          color: Colors.black,
                          fontWeight: FontWeight.w500)),
                  Text("\NGN" + price,
                      style: GoogleFonts.montserrat(
                          fontSize: 14,
                          color: Colors.black,
                          fontWeight: FontWeight.w400)),
                ],
              )
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                widget.name,
                style: GoogleFonts.montserrat(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w500),
              ),
              Gap(5),
              SizedBox(
                  width: size.width * 0.5,
                  child: Text(
                    widget.specialization,
                    style: GoogleFonts.montserrat(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w400),
                    maxLines: 3,
                    textAlign: TextAlign.center,
                  )),
              Gap(5),
              Text(
                widget.gender,
                style: GoogleFonts.montserrat(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w400),
              ),
              Gap(10),
              Row(
                children: [
                  SmallIcon(
                      icon: Icons.work_outline_outlined,
                      bgColor: Styles.shadeColorPrimary,
                      iconColor: Styles.primaryColor),
                  Gap(5),
                  Text(
                    widget.experience + " years",
                    style: GoogleFonts.montserrat(
                      fontSize: 12,
                    ),
                  ),
                  Gap(10),
                  SmallIcon(
                      icon: Icons.thumb_up_alt_outlined,
                      bgColor: Styles.shadeColorPrimary,
                      iconColor: Styles.primaryColor),
                  Gap(5),
                  Text(
                    percentage + "%",
                    style: GoogleFonts.montserrat(
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
              Gap(15),
              GestureDetector(
                child: SmallPrimaryButton(
                  title: "Book Appointment",
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (builder) => DoctorAppointBooking(
                                DoctorUID: widget.UID,
                              )));
                },
              )
            ],
          ),
          Gap(1),
        ],
      ),
    );
  }

  Future<void> getPrice() async {
    DatabaseReference ref = FirebaseDatabase.instance
        .ref("Users")
        .child("sessions")
        .child(widget.UID);
    ref.once().then((value) => {
          setState(() {
            price = value.snapshot.child("price").value.toString();
          }),
        });
  }

  void getPercentageInfo() async {
    int totalCount = 0;
    DatabaseReference ref =
        FirebaseDatabase.instance.ref("Reviews").child(widget.UID);
    Stream<DatabaseEvent> event = ref.onValue;
    event.listen((event) {
      if (event.snapshot.exists) {
        totalCount = event.snapshot.children.length;
        List<int> fullStarCount = [];
        for (DataSnapshot snapshot in event.snapshot.children) {
          if (snapshot.child("stars").value.toString() == "5") {
            fullStarCount
                .add(int.parse(snapshot.child("stars").value.toString()));
          }
        }
        if (fullStarCount.isEmpty) {
          percentage = '0';
        } else {
          double finalRating = (fullStarCount.length / totalCount * 100);
          int finalStars = finalRating.toInt();
          percentage = finalStars.toString();
          setState(() {});
        }
      } else {
        setState(() {
          percentage = 'N/A';
        });
      }
    });
  }
}

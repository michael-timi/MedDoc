import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:meddoc/Screens/DoctorsBottomBar.dart';
import 'package:meddoc/Screens/PatientNavigationBar.dart';
import 'package:unicons/unicons.dart';

import '../Screens/ChatScreen.dart';
import '../Styles/applayout.dart';
import '../Styles/styles.dart';
import 'MediumIcon.dart';
import 'MediumImage.dart';
import '../Screens/PatientAppointments.dart';

import 'ReviewDialog.dart';
import 'Smallicon.dart';
import 'package:intl/intl.dart';

class DoctorAppointmentContainer extends StatefulWidget {
  String patientID, doctorID, appointID, date, start, end;
  bool doctor;
  bool appointed;
  DoctorAppointmentContainer(
      {Key? key,
      required this.doctor,
      required this.appointID,
      required this.date,
      required this.doctorID,
      required this.patientID,
      required this.start,
      required this.end,
      required this.appointed})
      : super(key: key);

  @override
  State<DoctorAppointmentContainer> createState() =>
      _DoctorAppointmentContainerState();
}

class _DoctorAppointmentContainerState
    extends State<DoctorAppointmentContainer> {
  String name = "";
  String specilization = "";
  String age = "";
  String address = "";
  String patienttoken = "";
  String docToken = "";
  String imgURL = "";
  String patientName="";
  String doctorName="";
  @override
  Widget build(BuildContext context) {
    final size = AppLayout.getSize(context);
    return Container(
      width: size.width,
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Row(
          children: [
            Gap(10),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                MediumImage(imageAsset: imgURL),
                Gap(10),
                Text(
                  DateTime.parse(widget.start).hour.toString() +
                      ":" +
                      DateTime.parse(widget.start).minute.toString() +
                      " to " +
                      DateTime.parse(widget.end).hour.toString() +
                      ":" +
                      DateTime.parse(widget.end).minute.toString() +
                      "\n" +
                      DateTime.parse(widget.date).day.toString() +
                      "-" +
                      DateTime.parse(widget.date).month.toString() +
                      "-" +
                      DateTime.parse(widget.date).year.toString(),
                  style: GoogleFonts.montserrat(fontSize: 12),
                  textAlign: TextAlign.center,
                )
              ],
            ),
            Gap(20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  name,
                  style: GoogleFonts.montserrat(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.black),
                ),
                Gap(5),
                SizedBox(
                    width: size.width * 0.5,
                    child: Text(
                      widget.doctor
                          ? "Age: " + age
                          : "Specialization: " + specilization,
                      style: GoogleFonts.montserrat(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Colors.black),
                      textAlign: TextAlign.start,
                      maxLines: 3,
                    )),
                Gap(5),
                SizedBox(
                  width: size.width*0.5,
                  child: Text(
                    "Clinic Address: " + address,
                    style: GoogleFonts.montserrat(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.black),
                  ),
                ),
                Gap(15),
                widget.appointed?Row(
                  children: [
                    widget.doctor
                        ? GestureDetector(
                            onTap: () {
                              DatabaseReference ref = FirebaseDatabase.instance
                                  .ref("bookings")
                                  .child(widget.appointID);
                              ref.remove().whenComplete(() => {
                                    sendNotification(
                                        'Doctor Marked your appointment Completed',
                                        'Appointment marked as Completed.'),
                                makeHistoryDoctor('Appointment','You marked appointment completed'),
                                makeHistoryPatient('Appointment','Doctor marked your appointment completed'),
                                  });
                            },
                            child: MediumIcon(
                              icon: Icons.check,
                              iconColor: Colors.black,
                              bgColor: Styles.shadeColorPrimary,
                            ))
                        : GestureDetector(
                            onTap: () {
                              showCupertinoDialog(
                                  context: context,
                                  builder: (builder) {
                                    return CupertinoAlertDialog(
                                      title: Text(
                                        "Leave a Review",
                                        style: GoogleFonts.montserrat(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      content: ReviewDialog(
                                        docID: widget.doctorID,
                                        patientID: widget.patientID,
                                        appointID: widget.appointID,
                                      ),
                                    );
                                  });
                            },
                            child: MediumIcon(
                              icon: Icons.check,
                              iconColor: Colors.black,
                              bgColor: Styles.shadeColorPrimary,
                            )),
                    Gap(10),
                    Text(
                      "Appoint.\nComplete",
                      style: GoogleFonts.montserrat(fontSize: 12),
                      textAlign: TextAlign.start,
                    ),
                    Gap(20),
                    GestureDetector(
                        onTap: () {
                          DatabaseReference ref = FirebaseDatabase.instance
                              .ref("bookings")
                              .child(widget.appointID);
                          ref.remove().whenComplete(() => {
                                widget.doctor
                                    ? sendNotification("from: " + name,
                                        "Appointment Cancelled")
                                    : sendNotificationtoDoctor("from: " + name,
                                        "Appointment Cancelled"),
                            makeHistoryPatient('Appointment', "Appointment Cancelled"),
                            makeHistoryDoctor('Appointment', "Appointment Cancelled"),
                              });
                        },
                        child: MediumIcon(
                          icon: Icons.delete_outline_outlined,
                          iconColor: Colors.black,
                          bgColor: Styles.shadeColorPrimary,
                        )),
                    Gap(10),
                    Text(
                      "Cancel\nAppoint.",
                      style: GoogleFonts.montserrat(fontSize: 12),
                      textAlign: TextAlign.start,
                    ),
                  ],
                ):!widget.doctor?Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Your Appointment is under approval\nPlease wait for Doctor Approval."),
                    Gap(15),
                    GestureDetector(
                        onTap: () {
                          DatabaseReference ref = FirebaseDatabase.instance
                              .ref("bookings")
                              .child(widget.appointID);
                          ref.remove().whenComplete(() => {
                            widget.doctor
                                ? sendNotification("from: " + name,
                                "Appointment Cancelled")
                                : sendNotificationtoDoctor("from: " + name,
                                "Appointment Cancelled"),
                            makeHistoryPatient("Appointment", "You deleted appointment request"),
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (builder)=>PatientNavigationBar(selectedindex: 3)))
                          });
                        },
                        child: MediumIcon(
                          icon: Icons.delete_outline_outlined,
                          iconColor: Colors.black,
                          bgColor: Styles.shadeColorPrimary,
                        )),
                  ],
                ):Row(children: [
                  GestureDetector(
                      onTap: () {
                        acceptit();
                      },
                      child: MediumIcon(
                        icon: Icons.check,
                        iconColor: Colors.black,
                        bgColor: Styles.shadeColorPrimary,
                      )),
                  Gap(10),
                  Text(
                    "Accept",
                    style: GoogleFonts.montserrat(fontSize: 12),
                    textAlign: TextAlign.start,
                  ),
                  Gap(20),
                  GestureDetector(
                      onTap: () {
                        declineIt();
                      },
                      child: MediumIcon(
                        icon: Icons.delete_outline_outlined,
                        iconColor: Colors.black,
                        bgColor: Styles.shadeColorPrimary,
                      )),
                  Gap(10),
                  Text(
                    "Decline",
                    style: GoogleFonts.montserrat(fontSize: 12),
                    textAlign: TextAlign.start,
                  ),

                ],)
              ],
            )
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    getInfo();
    getPatientName();
    getDoctorName();

  }

  void getInfo() {
    DatabaseReference reference;
    widget.doctor
        ? reference = FirebaseDatabase.instance
            .ref("Users")
            .child("Patients")
            .child(widget.patientID)
        : reference = FirebaseDatabase.instance
            .ref("Users")
            .child("Doctors")
            .child(widget.doctorID);
    Stream<DatabaseEvent> stream = reference.onValue;
    stream.listen((event) {
      setState(() {
        imgURL = event.snapshot.child("imgURL").value.toString();
        name = event.snapshot.child("name").value.toString();
        patienttoken = event.snapshot.child("token").value.toString();

        if (event.snapshot.child("hospitalAddress").exists) {
          address = event.snapshot.child("hospitalAddress").value.toString();
          docToken = event.snapshot.child("token").value.toString();
        } else {
          address = event.snapshot.child("address").value.toString();
        }
        if (event.snapshot.child("specialization").exists) {
          specilization =
              event.snapshot.child("specialization").value.toString();
        } else {
          age = event.snapshot.child("age").value.toString();
        }
      });
    });
  }

  Future<void> sendNotification(String body, String title) async {
    try {
      await post(Uri.parse('https://fcm.googleapis.com/fcm/send'),
          headers: <String, String>{
            'Content-Type': 'application/json',
            'Authorization':
                'key=AAAAfVecfvE:APA91bFLQDYmEYp6vFbBxdncTgeOwzZBd0NH83aK9sJi7TtNfdxFJDjviDKS3xFSaiXOYtFgQj3ZDQIFhIiPvz5aeHo3dzGQ0D3IMAXdBKLDZxEIbAQ6EJgUEI4M_RNxG4USHri3KLMD'
          },
          body: jsonEncode(
            <String, dynamic>{
              'priority': 'high',
              'data': <String, dynamic>{
                'click-action': 'FLUTTER_NOTIFICATION_CLICK',
                'status': 'done',
                'body': body,
                'title': title,
              },
              "notification": <String, dynamic>{
                'body': body,
                'title': title,
                "android_channel_id": 'mainChannel',
              },
              'to': patienttoken,
            },
          ));
    } catch (e) {
      print("Message Exception: " + e.toString());
    }
  }

  Future<void> sendNotificationtoDoctor(String body, String title) async {
    try {
      await post(Uri.parse('https://fcm.googleapis.com/fcm/send'),
          headers: <String, String>{
            'Content-Type': 'application/json',
            'Authorization':
                'key=AAAAfVecfvE:APA91bFLQDYmEYp6vFbBxdncTgeOwzZBd0NH83aK9sJi7TtNfdxFJDjviDKS3xFSaiXOYtFgQj3ZDQIFhIiPvz5aeHo3dzGQ0D3IMAXdBKLDZxEIbAQ6EJgUEI4M_RNxG4USHri3KLMD'
          },
          body: jsonEncode(
            <String, dynamic>{
              'priority': 'high',
              'data': <String, dynamic>{
                'click-action': 'FLUTTER_NOTIFICATION_CLICK',
                'status': 'done',
                'body': body,
                'title': title,
              },
              "notification": <String, dynamic>{
                'body': body,
                'title': title,
                "android_channel_id": 'mainChannel',
              },
              'to': docToken,
            },
          ));
    } catch (e) {
      print("Message Exception: " + e.toString());
    }
  }

  void acceptit() {
    DatabaseReference reference=FirebaseDatabase.instance.ref("bookings").child(widget.appointID);
    Map<String,Object> map={
      'accepted':true,
    };
    reference.update(map).then((value) => {
    sendNotification("Specialist Accepted Your Appointment", "Appointment Accepted"),
    makeHistoryDoctor("Appointment", "You have accepted your appointment"),
    makeHistoryPatient("Appointment", "Specialist have accepted your appointment"),


        Navigator.pushReplacement(context, MaterialPageRoute(builder: (builder)=>DoctorsNavigationBar(selectedIndex: 1)))
    });
    
  }

  void declineIt() {
    popMessageDialog();

  }

  makeHistoryDoctor(String s, String t) {
    DatabaseReference reference=FirebaseDatabase.instance.ref("history").child(widget.doctorID).push();
    Map<String,Object> map={
      'title':s,
      'description':t,
      'time':DateTime.now().toString(),
      'to':patientName,
      'from':"",
    };
    reference.update(map);
  }

  makeHistoryPatient(String s, String t) {
    // String path="";
    // widget.doctor?path="Doctors":path="Patients";
    DatabaseReference reference=FirebaseDatabase.instance.ref("history").child(widget.patientID).push();
    Map<String,Object> map={
      'title':s,
      'description':t,
      'time':DateTime.now().toString(),
      'to':"",
      'from':doctorName,
    };
    reference.update(map);
  }

  void getPatientName() {
    DatabaseReference myInfoRef=FirebaseDatabase.instance.ref("Users").child("Patients").child(widget.patientID);

    myInfoRef.once().then((value) => {

      patientName=value.snapshot.child("name").value.toString(),
    patienttoken = value.snapshot.child("token").value.toString(),

    });
  }

  void getDoctorName() {
    DatabaseReference myInfoRef=FirebaseDatabase.instance.ref("Users").child("Doctors").child(widget.doctorID);

    myInfoRef.once().then((value) => {

      doctorName=value.snapshot.child("name").value.toString(),
      docToken=value.snapshot.child("token").value.toString(),
    });
  }

  void popMessageDialog() {
    showCupertinoDialog(context: context,barrierDismissible: true, builder: (builder){

      return CupertinoAlertDialog(
        title: Text("Appointment Declined",style: GoogleFonts.montserrat(fontSize: 16,fontWeight: FontWeight.w400),),
        content: Text("discuss the reason of declining appointment\nStart Conversation",style: GoogleFonts.montserrat(fontSize: 16,fontWeight: FontWeight.w300),),
        actions: [
          CupertinoDialogAction(child: Text("Send Message",style: GoogleFonts.montserrat(fontSize: 16,fontWeight: FontWeight.w400),),isDefaultAction: true,onPressed: (){
            Navigator.pop(context);
            Navigator.push(context, MaterialPageRoute(builder: (builder)=>ChatScreen(doctor: false,receiverUID: widget.patientID,))).then((value) =>
            {
              deleteAppointment(),

            });
          },),
          
        ],

      );
    });
  }

  deleteAppointment() {
    DatabaseReference reference=FirebaseDatabase.instance.ref("bookings").child(widget.appointID);
    reference.remove().then((value)  async => {
      await sendNotification("Specialist Declined Your Appointment", "Appointment Declined"),
      makeHistoryPatient("Appointment", "Specialist Declined Your Appointment"),
      makeHistoryDoctor("Appointment", "You Declined Appointment"),
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (builder)=>DoctorsNavigationBar(selectedIndex: 1)))
    });
  }
}

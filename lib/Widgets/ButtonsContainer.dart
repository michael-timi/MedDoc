import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meddoc/Screens/ChatScreen.dart';
import 'package:meddoc/Screens/DoctorAppointBooking.dart';
import 'package:meddoc/Screens/SignIn.dart';

import '../Screens/CertificateScreen.dart';
import '../Screens/GoogleMapsScreen.dart';
import '../Screens/HistoryScreen.dart';
import '../Screens/NewSplashScreen.dart';
import '../Styles/applayout.dart';
import '../Styles/styles.dart';
import 'EditPatientProfileDialog.dart';
import 'LargeIcon.dart';
import 'MediumIcon.dart';

class ButtonsContainer extends StatefulWidget {
  bool doctor;
  String docID;
    String name;
    ButtonsContainer({Key? key,required this.doctor,required this.docID,required this.name}) : super(key: key);

  @override
  State<ButtonsContainer> createState() => _ButtonsContainerState();
}

class _ButtonsContainerState extends State<ButtonsContainer> {


  String address = "";
  String age = "";
  String name = "";
  String phonenumber = "";
  @override
  Widget build(BuildContext context) {
    final size=AppLayout.getSize(context);
    return Container(
      width: size.width,
      padding: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(22),bottomRight: Radius.circular(22)),
          color: Styles.secondryColor
      ),
      child: Row(
        children: [
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: widget.doctor?Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: (){
                      editProfileDialog();
                    },
                    child: Padding(
                      padding: EdgeInsets.only(left: 15,right: 15,top: 2),
                      child: Column(
                        children: [
                          LargeIcon(icon: Icons.edit_outlined,bgColor: Styles.shadeColorPrimary,iconColor: Styles.primaryColor,),
                          Gap(10),
                          Text("Edit Profile",style: GoogleFonts.montserrat(fontSize: 14,fontWeight: FontWeight.w400,color: Colors.white),),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (builder)=>MapsApiScreen(doctor:widget.doctor,docID:widget.docID,name:widget.name)));
                    },
                    child: Padding(
                      padding: EdgeInsets.only(left: 15,right: 15,top: 2),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            LargeIcon(bgColor: Colors.white,iconColor: Styles.primaryColor,icon: Icons.location_on_outlined,),
                            Gap(10),
                            Text("Location",style: GoogleFonts.montserrat(fontSize: 12,fontWeight: FontWeight.w500,color: Colors.white),)
                          ]
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (builder)=>HistoryScreen()));

                    },
                    child: Padding(
                      padding: EdgeInsets.only(left: 15,right: 15,top: 2),
                      child: Column(
                        children: [
                          LargeIcon(icon: Icons.history,bgColor: Styles.shadeColorPrimary,iconColor: Styles.primaryColor,),
                          Gap(10),
                          Text("History",style: GoogleFonts.montserrat(fontSize: 14,fontWeight: FontWeight.w400,color: Colors.white),),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (builder)=>CertificateScreen(docID: widget.docID,doctor: true,)));
                    },
                    child: Padding(
                      padding: EdgeInsets.only(left: 15,right: 15,top: 2),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            LargeIcon(bgColor: Colors.white,iconColor: Styles.primaryColor,icon: Icons.file_copy_outlined,),

                            Text("Upload\nCertificates",style: GoogleFonts.montserrat(fontSize: 12,fontWeight: FontWeight.w500,color: Colors.white),textAlign: TextAlign.center,)
                          ]
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: logout,
                    child: Padding(
                      padding: EdgeInsets.only(left: 15,right: 15,top: 2),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            LargeIcon(bgColor: Colors.white,iconColor: Colors.redAccent,icon: Icons.logout_outlined,),
                            Gap(10),
                            Text("Logout",style: GoogleFonts.montserrat(fontSize: 12,fontWeight: FontWeight.w500,color: Colors.white),)
                          ]
                      ),
                    ),
                  ),


                ],):
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (builder)=>MapsApiScreen(doctor:widget.doctor,docID:widget.docID,name:widget.name)));
                    },
                    child: Padding(
                      padding: EdgeInsets.only(left: 15,right: 15,top: 2),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            LargeIcon(bgColor: Colors.white,iconColor: Styles.primaryColor,icon: Icons.location_on_outlined,),
                            Gap(10),
                            Text("Location",style: GoogleFonts.montserrat(fontSize: 12,fontWeight: FontWeight.w500,color: Colors.white),)
                          ]
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (builder)=>CertificateScreen(docID: widget.docID,doctor: false,)));
                    },
                    child: Padding(
                      padding: EdgeInsets.only(left: 15,right: 15,top: 2),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            LargeIcon(bgColor: Colors.white,iconColor: Styles.primaryColor,icon: Icons.file_copy_outlined,),
                            Gap(10),
                            Text("Certificates",style: GoogleFonts.montserrat(fontSize: 12,fontWeight: FontWeight.w500,color: Colors.white),textAlign: TextAlign.center,)
                          ]
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (builder)=>ChatScreen(receiverUID: widget.docID, doctor: true)));
                    },
                    child: Padding(
                      padding: EdgeInsets.only(left: 15,right: 15,top: 2),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          LargeIcon(bgColor: Colors.white,iconColor: Styles.secondryColor,icon: CupertinoIcons.text_bubble,),
                          Gap(10),
                          Text("Message",style: GoogleFonts.montserrat(fontSize: 12,fontWeight: FontWeight.w500,color: Colors.white),)
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (builder)=>DoctorAppointBooking(DoctorUID: widget.docID)));

                    },
                    child: Padding(
                      padding: EdgeInsets.only(left: 15,right: 15,top: 2),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [

                          LargeIcon(bgColor: Colors.white,iconColor: Styles.secondryColor,icon: CupertinoIcons.calendar_badge_plus,),
                          Gap(10),
                          Text("Appointment",style: GoogleFonts.montserrat(fontSize: 12,fontWeight: FontWeight.w500,color: Colors.white),)
                        ],
                      ),
                    ),
                  ),

                ],
              ),
            ),
          )
        ],
      )
    );
  }

  Future<void> logout() async {
    if(FirebaseAuth.instance.currentUser!=null){
      DatabaseReference reference=FirebaseDatabase.instance.ref("Users").child("Doctors").child(FirebaseAuth.instance.currentUser!.uid).child("token");
      reference.remove();
      await FirebaseAuth.instance.signOut().then((value) => {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (builder)=>SignIn())),

      });
    }
  }
  void editProfileDialog() {
    showCupertinoDialog(context: context, builder: (builder){
      return CupertinoAlertDialog(
        title: Text("Edit Profile",style: GoogleFonts.montserrat(fontSize: 16,fontWeight: FontWeight.w400,color: Colors.black),),
        content: EditPatientProfileDialog(doctor:true,address: address,age: age,name: name,phonenumber: phonenumber,uid: FirebaseAuth.instance.currentUser!.uid,),
      );
    });
  }

  @override
  void initState() {
    getDoctorInfo();
  }

  void getDoctorInfo() {
    DatabaseReference ref = FirebaseDatabase.instance
        .ref("Users")
        .child("Doctors")
        .child(FirebaseAuth.instance.currentUser!.uid);

    Stream<DatabaseEvent> event = ref.onValue;
    event.listen((event) {
      if (event.snapshot.exists) {
        setState(() {
          name = event.snapshot.child("name").value.toString();
          age = event.snapshot.child("age").value.toString();
          phonenumber = event.snapshot.child("phonenumber").value.toString();
          address = event.snapshot.child("hospitalAddress").value.toString();
        });
      }
    });
  }
}

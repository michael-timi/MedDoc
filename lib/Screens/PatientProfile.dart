import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meddoc/Screens/NewSplashScreen.dart';

import '../Styles/applayout.dart';
import '../Styles/styles.dart';
import '../Widgets/ChangePasswordDialog.dart';
import '../Widgets/EditPatientProfileDialog.dart';
import '../Widgets/LargeIcon.dart';
import '../Widgets/LargeImage.dart';
import '../Widgets/ListPropertiesTile.dart';
import '../Widgets/ProfileContainer.dart';
import '../Widgets/StatContainer.dart';
import 'HistoryScreen.dart';
import 'SignIn.dart';

class PatientProfile extends StatefulWidget {
  const PatientProfile({Key? key}) : super(key: key);

  @override
  State<PatientProfile> createState() => _PatientProfileState();
}

class _PatientProfileState extends State<PatientProfile> {
  String imgURL = "";
  String email = "";
  String number = "";
  String address = "";
  String age = "";
  String name = "";
  String phonenumber = "";
  String gender = "";
  @override
  Widget build(BuildContext context) {
    final size = AppLayout.getSize(context);
    return Scaffold(
      backgroundColor: Styles.bgColor,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Container(
                  padding: EdgeInsets.only(left: 22,right: 22,top: 50),
                  width: size.width,
                  decoration: BoxDecoration(

                  ),
                  child: Column(
                    children: [
                      Column(
                        children: [
                          LargeImage(
                            imageAsset: imgURL,
                          ),
                          Gap(8),
                          Text(
                            name,
                            style: GoogleFonts.montserrat(
                                fontSize: 18, fontWeight: FontWeight.w500),
                          ),
                          Gap(2),
                          Text(
                            phonenumber,
                            style: GoogleFonts.montserrat(
                                fontSize: 14, fontWeight: FontWeight.w300),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Gap(20),
                Container(
                  width: size.width,
                  height: size.height*0.1,
                  margin: EdgeInsets.only(left: 22,right: 22),
                  padding: EdgeInsets.only(left: 22,right: 22),

                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(22),
                    color: Colors.white,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(age,style: GoogleFonts.montserrat(fontSize: 16,fontWeight: FontWeight.w500)),
                          Gap(5),
                          Text("Age",style: GoogleFonts.montserrat(fontSize: 14,fontWeight: FontWeight.w400,color: Colors.blueGrey)),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(gender,style: GoogleFonts.montserrat(fontSize: 16,fontWeight: FontWeight.w500)),
                          Gap(5),
                          Text("Gender",style: GoogleFonts.montserrat(fontSize: 14,fontWeight: FontWeight.w400,color: Colors.blueGrey)),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  width: size.width,
                  margin: EdgeInsets.only(left: 22,right: 22),
                  height: 1,
                  color: Colors.white,
                ),
              ],
            ),
            Gap(30),
            Container(
              width: size.width,
              margin: EdgeInsets.only(left: 22,right: 22),
              padding: EdgeInsets.only(left: 22,right: 22,top: 22,bottom: 22),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(22),
                  color: Colors.white
              ),
              child: Row(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,

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
                                  Text("Edit Profile",style: GoogleFonts.montserrat(fontSize: 14,fontWeight: FontWeight.w400,color: Colors.black),),
                                ],
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
                                  Text("History",style: GoogleFonts.montserrat(fontSize: 14,fontWeight: FontWeight.w400,color: Colors.black),),
                                ],
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                              editPasswordDialog();
                            },
                            child: Padding(
                              padding: EdgeInsets.only(left: 15,right: 15,top: 2),
                              child: Column(
                                children: [
                                  LargeIcon(icon: Icons.password_outlined,bgColor: Styles.shadeColorPrimary,iconColor: Styles.primaryColor,),
                                  Gap(10),
                                  Text("Change Password",style: GoogleFonts.montserrat(fontSize: 14,fontWeight: FontWeight.w400,color: Colors.black),),
                                ],
                              ),
                            ),
                          ),

                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Gap(30),
            Container(
              width: size.width,
              height: size.height*0.325000,
              margin: EdgeInsets.only(left: 22,right: 22),
              padding: EdgeInsets.only(left: 22,right: 22,top: 22),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(topRight: Radius.circular(26),topLeft:Radius.circular(26) ),
                  color: Colors.white
              ),
              child: Column(
                children: [
                  ListPropertiesTile(top: email, bottom: "Email",icon: Icons.email_outlined,),
                  ListPropertiesTile(top: address, bottom: "Address",icon: Icons.home_outlined,),
                  GestureDetector(
                    onTap: logout,
                      child: ListPropertiesTile(top: "Sign Out", bottom: "",icon: Icons.logout_outlined,)),
                ],
              ),
            )

          ],
        ),
      )
    );
  }

  Future<void> logout() async {
    if (FirebaseAuth.instance.currentUser != null) {
      DatabaseReference reference=FirebaseDatabase.instance.ref("Users").child("Patients").child(FirebaseAuth.instance.currentUser!.uid).child("token");
      reference.remove();
      await FirebaseAuth.instance.signOut().then((value) => {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (builder) => SignIn())),
          });
    }
  }

  @override
  void initState() {
    getPatientInfo();
  }

  void getPatientInfo() {
    DatabaseReference ref = FirebaseDatabase.instance
        .ref("Users")
        .child("Patients")
        .child(FirebaseAuth.instance.currentUser!.uid);

    Stream<DatabaseEvent> event = ref.onValue;
    event.listen((event) {
      if (event.snapshot.exists) {
        setState(() {
          name = event.snapshot.child("name").value.toString();
          age = event.snapshot.child("age").value.toString();
          number = event.snapshot.child("phonenumber").value.toString();
          email = event.snapshot.child("email").value.toString();
          imgURL = event.snapshot.child("imgURL").value.toString();
          phonenumber = event.snapshot.child("phonenumber").value.toString();
          gender = event.snapshot.child("gender").value.toString();
          address = event.snapshot.child("address").value.toString();
        });
      }
    });
  }

  void editProfileDialog() {
    showCupertinoDialog(context: context, builder: (builder){
      return CupertinoAlertDialog(
        title: Text("Edit Profile",style: GoogleFonts.montserrat(fontSize: 16,fontWeight: FontWeight.w400,color: Colors.black),),
        content: EditPatientProfileDialog(doctor:false,address: address,age: age,name: name,phonenumber: phonenumber,uid: FirebaseAuth.instance.currentUser!.uid,),
      );
    });
  }

  void editPasswordDialog() {
    showCupertinoDialog(context: context, builder: (builder){
      return CupertinoAlertDialog(
        title: Text("Edit Profile",style: GoogleFonts.montserrat(fontSize: 16,fontWeight: FontWeight.w400,color: Colors.black),),
        content: ChangePasswordDialog(uid: FirebaseAuth.instance.currentUser!.uid,),
      );
    });
  }
}

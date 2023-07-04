


import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meddoc/Styles/applayout.dart';

import '../Styles/styles.dart';
import 'LargeImage.dart';
import 'dart:core';
import 'LoadingContainer.dart';
import 'Smallicon.dart';

class DoctorDescriptionContainer extends StatefulWidget {
  String DoctorUID;
   DoctorDescriptionContainer({Key? key,required this.DoctorUID}) : super(key: key);

  @override
  State<DoctorDescriptionContainer> createState() => _DoctorDescriptionContainerState();
}

class _DoctorDescriptionContainerState extends State<DoctorDescriptionContainer> {
  String imgURL="";
  String name="";
  String experience="";
  String specialization="";
  String percentage="0";


  bool loading=true;


  @override
  void initState() {
    getDoctorInfo();
    getPercentageInfo();
  }

  @override
  Widget build(BuildContext context) {
    final size=AppLayout.getSize(context);
    return loading?LoadingContainer(): Container(
      width: size.width,
      padding: EdgeInsets.only(left: 25,right: 30,top: 20,bottom: 20),

      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Row(
        children: [
          LargeImage(imageAsset: imgURL,),
          Gap(30),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Gap(5),
              SizedBox(
                width: size.width*0.5,
                  child: Text(name,style: GoogleFonts.montserrat(color: Colors.black,fontSize: 18,fontWeight: FontWeight.w500),)),
              Gap(5),
              SizedBox(
                  width: size.width*0.5,
                  child: Text(specialization,style: GoogleFonts.montserrat(color: Colors.blueGrey,fontSize: 14,fontWeight: FontWeight.w500,),textAlign: TextAlign.start,maxLines: 3,)),
              Gap(5),
              Row(
                children: [
                  SmallIcon(icon: Icons.work_outline_outlined, bgColor: Styles.shadeColorPrimary, iconColor: Styles.primaryColor),
                  Gap(5),
                  Text(experience+" years",style: GoogleFonts.montserrat(fontSize: 12,),),
                  Gap(10),
                  SmallIcon(icon: Icons.thumb_up_alt_outlined, bgColor: Styles.shadeColorPrimary, iconColor: Styles.primaryColor),
                  Gap(5),
                  Text(percentage+"%",style: GoogleFonts.montserrat(fontSize: 12,),),

                ],
              ),


            ],
          ),







        ],
      ),
    );
  }

  void getDoctorInfo() {
    DatabaseReference sessionsURL=FirebaseDatabase.instance.ref("sessions").child(widget.DoctorUID);
    DatabaseReference profileURL=FirebaseDatabase.instance.ref("Users").child("Doctors").child(widget.DoctorUID);
    Stream<DatabaseEvent> event=profileURL.onValue;

    event.listen((event) {
      setState(() {
        imgURL=event.snapshot.child("imgURL").value.toString();
        name=event.snapshot.child("name").value.toString();
        experience=event.snapshot.child("experience").value.toString();
        specialization=event.snapshot.child("specialization").value.toString();
        loading=false;

      });

    });

  }
  void getPercentageInfo() async {
    int totalCount=0;
    DatabaseReference ref=FirebaseDatabase.instance.ref("Reviews").child(widget.DoctorUID);
    Stream<DatabaseEvent> event=ref.onValue;
    event.listen((event) {
      if(event.snapshot.exists){
        totalCount=event.snapshot.children.length;
        List<int> fullStarCount=[];
        for(DataSnapshot snapshot in event.snapshot.children){
          if(snapshot.child("stars").value.toString()=="5"){
            fullStarCount.add(int.parse(snapshot.child("stars").value.toString()));
          }
        }
        if(fullStarCount.isEmpty) {
          percentage = '0';
        }else{
          double finalRating=(fullStarCount.length/totalCount*100);
          int finalStars=finalRating.toInt();
          percentage=finalStars.toString();
          setState(() {

          });
        }

      }else{
        setState((){
          percentage='N/A';
        });
      }
    });



  }
}

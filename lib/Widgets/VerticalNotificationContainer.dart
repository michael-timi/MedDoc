import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Screens/FullNotificationCenter.dart';
import '../Styles/applayout.dart';
import '../Styles/styles.dart';
import 'LargeIcon.dart';
import 'MediumIcon.dart';

class VerticalNotificationContainer extends StatefulWidget {
  String type,time,from,notID;
   VerticalNotificationContainer({Key? key,required this.type,required this.notID,required this.time,required this.from}) : super(key: key);

  @override
  State<VerticalNotificationContainer> createState() => _VerticalNotificationContainerState();
}

class _VerticalNotificationContainerState extends State<VerticalNotificationContainer> {
  String day="";
  String year="";
  String hr="";
  String min="";
  @override
  void initState() {
    if(DateTime.parse(widget.time).weekday==DateTime.monday){
      day="Mon";
    }else if(DateTime.parse(widget.time).weekday==DateTime.tuesday){
      day="Tue";
    }else if(DateTime.parse(widget.time).weekday==DateTime.wednesday){
      day="Wed";
    }else if(DateTime.parse(widget.time).weekday==DateTime.thursday){
      day="Thurs";
    }else if(DateTime.parse(widget.time).weekday==DateTime.friday){
      day="Fri";
    }else if(DateTime.parse(widget.time).weekday==DateTime.saturday){
      day="Sat";
    }else if(DateTime.parse(widget.time).weekday==DateTime.sunday){
      day="Sun";
    }

    setState(() {
      year=DateTime.parse(widget.time).year.toString();
      hr=DateTime.parse(widget.time).hour.toString();
      min=DateTime.parse(widget.time).minute.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    final size=AppLayout.getSize(context);
    return Padding(
      padding: EdgeInsets.only(top: 1),
      child: Container(
        width: size.width,
        height: size.height*0.13,
        padding: EdgeInsets.all(22),
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    LargeIcon(icon: Icons.notifications_active_outlined,iconColor: Styles.primaryColor,bgColor: Styles.shadeColorPrimary,),
                  ],
                ),
                Gap(20),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(day+","+hr+":"+min,style: GoogleFonts.montserrat(fontSize: 12),),
                    Text(widget.type==""?widget.type:widget.type.length>17?widget.type.substring(0,13)+"....":widget.type,style: GoogleFonts.montserrat(fontSize: 14,fontWeight: FontWeight.w500)),
                    Text("From: "+widget.from,style: GoogleFonts.montserrat(fontSize: 12,fontWeight: FontWeight.w400)),
                  ],
                ),
              ],
            ),
            GestureDetector(
              onTap: (){
               DatabaseReference ref=FirebaseDatabase.instance.ref("PersonalNotifications").child(FirebaseAuth.instance.currentUser!.uid).child(widget.notID);
               ref.remove().then((value) => {
                 Navigator.pushReplacement(context, MaterialPageRoute(builder: (builder)=>FullNotificationCenter())),
               });
              },
                child:  MediumIcon(icon: CupertinoIcons.bin_xmark,iconColor: Colors.red,bgColor: Colors.white,))
          ],
        ),
      ),
    );
  }
}

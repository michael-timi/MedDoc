import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meddoc/Styles/applayout.dart';

import '../Styles/styles.dart';
import 'Smallicon.dart';

class NotificationContainer extends StatefulWidget {
  String type,time,from,notID;
  NotificationContainer({Key? key,required this.from,required this.type,required this.notID,required this.time}) : super(key: key);

  @override
  State<NotificationContainer> createState() => _NotificationContainerState();
}

class _NotificationContainerState extends State<NotificationContainer> {
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
      padding: EdgeInsets.only(right: 10),
      child: Container(
        padding: EdgeInsets.all(12),
        width: size.width*0.45,
        height: size.height*0.16,
        decoration: BoxDecoration(
          color: Styles.shadeColorPrimary,
          borderRadius: BorderRadius.circular(12)
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
         children: [
           Row(
             mainAxisAlignment: MainAxisAlignment.spaceBetween,
             children: [
              SmallIcon(icon: Icons.notifications_active_outlined,iconColor: Styles.primaryColor,bgColor: Colors.white,),
               Text(day+","+hr+":"+min,style: GoogleFonts.montserrat(fontSize: 12),)
             ],
           ),
           Gap(10),
           Text(widget.type==""?widget.type:widget.type.length>17?widget.type.substring(0,13)+"....":widget.type,style: GoogleFonts.montserrat(fontSize: 14,fontWeight: FontWeight.w500)),
           Gap(10),
           Text("From: "+widget.from,style: GoogleFonts.montserrat(fontSize: 12,fontWeight: FontWeight.w400))
         ],

        ),
      ),
    );
  }
}

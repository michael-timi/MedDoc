import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meddoc/Styles/applayout.dart';

import '../Styles/styles.dart';
import 'LargeIcon.dart';

class VerticalReviewsContainer extends StatefulWidget {
  String from,time,review,revID,stars;
   VerticalReviewsContainer({Key? key,required this.from,required this.time,required this.revID,required this.review,required this.stars}) : super(key: key);

  @override
  State<VerticalReviewsContainer> createState() => _VerticalReviewsContainerState();
}

class _VerticalReviewsContainerState extends State<VerticalReviewsContainer> {
  IconData iconStar=Icons.star;
  Color starColor=Styles.primaryColor;
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
    switch(int.parse(widget.stars)){
      case 0:
        setState(() {
          iconStar=Icons.sentiment_very_dissatisfied;
          starColor= Colors.red;

        });
        break;
      case 1:
        setState(() {
          iconStar=Icons.sentiment_dissatisfied;
          starColor= Colors.redAccent;
        });
        break;
      case 2:
        setState(() {
          iconStar=Icons.sentiment_neutral;
          starColor=Colors.amber;
        });
        break;
      case 3:
        setState(() {
          iconStar=Icons.sentiment_satisfied;
          starColor=Colors.lightGreen;
        });
        break;
      case 4:
        setState(() {
          iconStar=Icons.sentiment_very_satisfied;
          starColor=Colors.green;
        });
        break;

    }
  }

  @override
  Widget build(BuildContext context) {
    final size=AppLayout.getSize(context);
    return Padding(
      padding: EdgeInsets.only(top: 1),
      child: Container(
        width: size.width,
        padding: EdgeInsets.all(22),
        decoration: BoxDecoration(
          color: Colors.white,
        ),child: Row(
        children: [
          Row(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  LargeIcon(icon: iconStar,iconColor: starColor,bgColor: Styles.shadeColorPrimary,),
                ],
              ),
              Gap(10),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(day+","+hr+":"+min,style: GoogleFonts.montserrat(fontSize: 12),),
                  Gap(5),
               //   Text("From: "+widget.from,style: GoogleFonts.montserrat(fontSize: 12,fontWeight: FontWeight.w400)),
                  Padding(
                    padding: EdgeInsets.only(right: 22),

                      child: SizedBox(
                        width: size.width*0.658,
                        child: Text("'"+widget.review+"'",style: GoogleFonts.montserrat(fontSize: 14,fontWeight: FontWeight.w500),textAlign: TextAlign.start,
                          overflow: TextOverflow.ellipsis,maxLines: 9,),
                      ),),

                ],
              ),
            ],
          )
        ],
      ),

      ),
    );
  }
}

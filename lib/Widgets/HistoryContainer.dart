import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meddoc/Styles/applayout.dart';

import '../Styles/styles.dart';

class HistoryContainer extends StatefulWidget {
  String time,title,description,from,to;
   HistoryContainer({Key? key,required this.time,required this.from,required this.title,required this.description,required this.to}) : super(key: key);


  @override
  State<HistoryContainer> createState() => _HistoryContainerState();
}

class _HistoryContainerState extends State<HistoryContainer> {
  
  
 
  
  
  @override
  Widget build(BuildContext context) {
    final size=AppLayout.getSize(context);
    return Container(
      width: size.width,
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 45, horizontal: 20),
            decoration: BoxDecoration(
              color: Styles.secondryColor,
            ),
            child: SizedBox(
              width: size.width*0.32,
              child: Text(
                fixDate(widget.time),
                style: GoogleFonts.montserrat(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Colors.white),
              ),
            ),
          ),
          Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
            children: [
                Text(widget.title,style: GoogleFonts.montserrat(fontSize: 16,fontWeight: FontWeight.w400),),
                Gap(5),
                Text(widget.description,style: GoogleFonts.montserrat(fontSize: 14,fontWeight: FontWeight.w300),),
                Gap(5),
                widget.from==""?Text(widget.to,style: GoogleFonts.montserrat(fontSize: 14,fontWeight: FontWeight.w300),): Text(widget.from,style: GoogleFonts.montserrat(fontSize: 14,fontWeight: FontWeight.w300),),


            ],
          ),
              )),
        ],
      ),
    );
  }

  @override
  void initState() {
    
  }
  String fixDate(String time) {
    String day="";
    String year="";
    String hr="";
    String min="";


    if(DateTime.parse(time).weekday==DateTime.monday){
      day="Mon";
    }else if(DateTime.parse(time).weekday==DateTime.tuesday){
      day="Tue";
    }else if(DateTime.parse(time).weekday==DateTime.wednesday){
      day="Wed";
    }else if(DateTime.parse(time).weekday==DateTime.thursday){
      day="Thurs";
    }else if(DateTime.parse(time).weekday==DateTime.friday){
      day="Fri";
    }else if(DateTime.parse(time).weekday==DateTime.saturday){
      day="Sat";
    }else if(DateTime.parse(time).weekday==DateTime.sunday){
      day="Sun";
    }



    year=DateTime.parse(time).year.toString();
    hr=DateTime.parse(time).hour.toString();
    min=DateTime.parse(time).minute.toString();
    String month=DateTime.parse(time).month.toString();
    String mainTime=day+" "+month+" "+year+" "+hr+":"+min;
    return mainTime;
    

  }
}

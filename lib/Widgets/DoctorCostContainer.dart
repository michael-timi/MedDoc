import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meddoc/Styles/applayout.dart';

import '../Styles/styles.dart';
import 'LoadingContainer.dart';

class DoctorCostContainer extends StatefulWidget {
  String DoctorUID;
   DoctorCostContainer({Key? key,required this.DoctorUID}) : super(key: key);

  @override
  State<DoctorCostContainer> createState() => _DoctorCostContainerState();
}

class _DoctorCostContainerState extends State<DoctorCostContainer> {


  String pay="";
  String duration="";




  bool loading=true;
  @override
  Widget build(BuildContext context) {
    final size=AppLayout.getSize(context);
    return loading?LoadingContainer():Container(
      width: size.width,
      height: size.height*0.18,
      padding: EdgeInsets.only(left: 30,right: 30,top: 20,bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,

        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Total Cost",style: GoogleFonts.montserrat(fontSize: 16,fontWeight: FontWeight.w500),),
                  Text("Sessions Fee for "+duration+" minutes",style: GoogleFonts.montserrat(fontSize: 14,fontWeight: FontWeight.w400,color: Colors.blueGrey),),
                ],
              ),
              Text("\₱"+pay,style: GoogleFonts.montserrat(fontSize: 16,fontWeight: FontWeight.w500))

            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("To Pay",style: GoogleFonts.montserrat(fontSize: 16,fontWeight: FontWeight.w500),),
                ],
              ),
              Text("\₱"+pay,style: GoogleFonts.montserrat(fontSize: 16,fontWeight: FontWeight.w500))

            ],
          ),

        ],
      ),
    );
  }

  @override
  void initState() {
    getCost();
  }

  void getCost() {
    DatabaseReference ref=FirebaseDatabase.instance.ref("Users").child("sessions").child(widget.DoctorUID);
    Stream<DatabaseEvent> event=ref.onValue;
    event.listen((event) {
      setState(() {
        pay=event.snapshot.child("price").value.toString();
        duration=event.snapshot.child("duration").value.toString();

        loading=false;
      });

    });

  }
}

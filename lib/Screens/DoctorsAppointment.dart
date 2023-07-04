import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meddoc/Styles/applayout.dart';

import '../Models/AppointmentModel.dart';
import '../Styles/styles.dart';
import '../Widgets/DoctorAppointmentContainer.dart';
import '../Widgets/LoadingContainer.dart';
import '../Widgets/NotFoundContainer.dart';
import '../Widgets/TitleContainer.dart';

class DoctorsAppointment extends StatefulWidget {
  const DoctorsAppointment({Key? key}) : super(key: key);

  @override
  State<DoctorsAppointment> createState() => _DoctorsAppointmentState();
}

class _DoctorsAppointmentState extends State<DoctorsAppointment> {
  List<AppointmentModel> appointmentData=[];
  bool found=true;
  Query bookingQuery=FirebaseDatabase.instance.ref("bookings").orderByChild("doctorID").equalTo(FirebaseAuth.instance.currentUser!.uid);
  int selected=0;
  Color selectedColor=Styles.secondryColor;
  Color unselectedColor=Styles.secondryColor;
  Color selectedTextColor=Colors.white;
  Color unselectedTextColor=Colors.black;


  @override
  Widget build(BuildContext context) {
    final size=AppLayout.getSize(context);
    return Scaffold(
      backgroundColor: Styles.bgColor,
      body: Column(
        children: [
          TitleContainer(title: "Appointments",),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 22,),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: (){
                      setState((){
                        selected=0;
                      });

                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 16,horizontal: 22),
                      decoration: BoxDecoration(
                          color: selected==0?Styles.secondryColor:Colors.white,
                          borderRadius: BorderRadius.circular(22)
                      ),
                      child: Text("Upcoming",style: GoogleFonts.montserrat(fontSize: 14,fontWeight: FontWeight.w400,color: selected==0?Colors.white:Colors.black),),
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      setState((){
                        selected=1;
                      });

                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 16,horizontal: 22),
                      decoration: BoxDecoration(
                          color: selected==1?Styles.secondryColor:Colors.white,
                          borderRadius: BorderRadius.circular(22)
                      ),
                      child: Text("Pending",style: GoogleFonts.montserrat(fontSize: 14,fontWeight: FontWeight.w400,color: selected==1?Colors.white:Colors.black),),
                    ),
                  ),
                ],
              ),
            ),
           selected==0?Expanded(
              child: StreamBuilder(
                  stream: bookingQuery.onValue,
                  builder: (context,snapshot){
                    if(snapshot.hasData){
                      if(snapshot.data!.snapshot.children.length<1){
                        return NotFoundContainer();
                      }
                      appointmentData.clear();
                      for(DataSnapshot snapshot in snapshot.data!.snapshot.children){
                        if(snapshot.child("accepted").value.toString()=="true"){
                          AppointmentModel model=AppointmentModel(snapshot.child("end").value.toString(), snapshot.key!, snapshot.child("start").value.toString(), snapshot.child("end").value.toString(), snapshot.child("doctorID").value.toString(), snapshot.child("patientID").value.toString(),snapshot.child("completed").value.toString(),snapshot.child("accepted").value.toString(),);
                          appointmentData.add(model);
                        }
                      }
                    }else{
                      return LoadingContainer();
                    }
                    return ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: appointmentData.length,
                        itemBuilder: (BuildContext context, index){
                          return DoctorAppointmentContainer(doctor: true,date: appointmentData.elementAt(index).date,appointID: appointmentData.elementAt(index).appointID,doctorID: appointmentData.elementAt(index).docID,patientID: appointmentData.elementAt(index).patientID,end: appointmentData.elementAt(index).end,start: appointmentData.elementAt(index).start,appointed: true,);
                        }
                    );

                  }),

            ):Expanded(
             child: StreamBuilder(
                 stream: bookingQuery.onValue,
                 builder: (context,snapshot){
                   if(snapshot.hasData){
                     if(snapshot.data!.snapshot.children.length<1){
                       return NotFoundContainer();
                     }
                     appointmentData.clear();
                     for(DataSnapshot snapshot in snapshot.data!.snapshot.children){
                       if(snapshot.child("accepted").value.toString()=="false"){
                         AppointmentModel model=AppointmentModel(snapshot.child("end").value.toString(), snapshot.key!, snapshot.child("start").value.toString(), snapshot.child("end").value.toString(), snapshot.child("doctorID").value.toString(), snapshot.child("patientID").value.toString(),snapshot.child("completed").value.toString(),snapshot.child("accepted").value.toString(),);
                         appointmentData.add(model);
                       }


                     }
                   }else{
                     return LoadingContainer();
                   }
                   return ListView.builder(
                       scrollDirection: Axis.vertical,
                       itemCount: appointmentData.length,
                       itemBuilder: (BuildContext context, index){
                         return DoctorAppointmentContainer(doctor: true,date: appointmentData.elementAt(index).date,appointID: appointmentData.elementAt(index).appointID,doctorID: appointmentData.elementAt(index).docID,patientID: appointmentData.elementAt(index).patientID,end: appointmentData.elementAt(index).end,start: appointmentData.elementAt(index).start,appointed: false,);
                       }
                   );

                 }),

           ),
        ],
      ),
    );
  }
}

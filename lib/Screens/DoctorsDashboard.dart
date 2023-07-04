import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meddoc/Screens/DoctorsBottomBar.dart';
import 'package:meddoc/Styles/applayout.dart';
import 'package:meddoc/Widgets/TitlewithNavigation.dart';

import '../Styles/styles.dart';
import '../Widgets/DoctorMeetingDialog.dart';
import '../Widgets/ExtraSmallIcon.dart';
import '../Widgets/GreetingContainer.dart';
import '../Widgets/HeadingNavigation.dart';
import '../Widgets/MainNotificationContainer.dart';
import '../Widgets/MainReviewsContainer.dart';
import '../Widgets/NotificationContainer.dart';
import '../Widgets/ReviewsContainer.dart';

class DoctorsDashboard extends StatefulWidget {
  const DoctorsDashboard({Key? key}) : super(key: key);

  @override
  State<DoctorsDashboard> createState() => _DoctorsDashboardState();
}

class _DoctorsDashboardState extends State<DoctorsDashboard> {

  String name="";
  String imgURL="";


  //-------MeetingAttributes-------


  @override
  Widget build(BuildContext context) {
    final size=AppLayout.getSize(context);
    return Scaffold(
      backgroundColor: Styles.bgColor,
      body:Column(
        children: [
          InkWell(
              onTap: (){
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (builder)=>DoctorsNavigationBar(selectedIndex: 3,)), (route) => false);
              },
              child: GreetingContainer(title: name,imageAsset: imgURL,)),
          Expanded(
              child: ListView(
                scrollDirection: Axis.vertical,
                children: [
                  MainNotificationContainer(),
                  Gap(40),
                  MainReviewsContainer(docID: FirebaseAuth.instance.currentUser!.uid,doc: true,),

                ],
              )
          )
        ],
      )

    );
  }

  @override
  void initState() {
    getDoctorInfo();
    checkSeasionInfo();
  }

  void getDoctorInfo() {
    DatabaseReference reference = FirebaseDatabase.instance.ref("Users").child("Doctors").child(FirebaseAuth.instance.currentUser!.uid);

    Stream<DatabaseEvent> stream=reference.onValue;
    stream.listen((event) {
      setState(() {
        name=event.snapshot.child("name").value.toString();
        imgURL=event.snapshot.child("imgURL").value.toString();
      });

    });


  }

  void checkSeasionInfo() {
    DatabaseReference reference = FirebaseDatabase.instance.ref("Users").child("sessions").child(FirebaseAuth.instance.currentUser!.uid);
    reference.once().then((value) => {
      if(value.snapshot.exists){
        
      }else{
       showCaution(),
      }
    });
    

  }

  void showMeetingDialog() {
    showCupertinoDialog(context: context, builder: (builder){
      return CupertinoAlertDialog(
        title: Text("Meeting Details",style: GoogleFonts.montserrat(fontSize: 16,fontWeight: FontWeight.w500),),
        content: DoctorMeetingDialog(),
        actions: [


        ],
      );
    });
  }

  showCaution() {
    showCupertinoDialog(context: context, builder: (BuildContext context){
      return CupertinoAlertDialog(
        title: Text("Setup Meeting Details",style: GoogleFonts.montserrat(fontSize: 16,fontWeight: FontWeight.w500)),
        content: Text("Set your meeting details so that patients can easily book appointments.",style: GoogleFonts.montserrat(fontSize: 14,fontWeight: FontWeight.w400)),
        actions: [
           TextButton(
            child: Text("Next",style: GoogleFonts.montserrat(fontSize: 16,fontWeight: FontWeight.w400,color: Styles.secondryColor)),
            onPressed: (){
              showMeetingDialog();



            },
              ),

        ],


      );
    });
  }

  void processData() {
    addDataintoList();
    if(validateData()){
     // DatabaseReference reference = FirebaseDatabase.instance.ref("Users").child("sessions").child(FirebaseAuth.instance.currentUser!.uid);
     // Map<String,Object> map={
     //   'startHr':_startHr,
     //   'startMin':_startMin,
     //   'endHr':_endHr,
     //   'endMin':_endMin,
     //   'duration':_duration,
     //   'price':_price,
     //   'weekends':weekends
     //
     // };
     // reference.update(map).then((value) => (){
     //   Navigator.of(context).pop();
     // });


    }else{

    }
  }
  void showMessage(String s) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(s)),
    );
  }
  bool validateData() {

    return true;
  }

  void addDataintoList() {
    // if(monday){
    //   weekends.add(DateTime.monday);
    // }else if(tuesday){
    //   weekends.add(DateTime.tuesday);
    // }else if(wednesday){
    //   weekends.add(DateTime.wednesday);
    // }else if(thursday){
    //   weekends.add(DateTime.thursday);
    // }else if(friday){
    //   weekends.add(DateTime.friday);
    // }else if(saturday){
    //   weekends.add(DateTime.saturday);
    // }else if(sunday){
    //   weekends.add(DateTime.sunday);
    // }
  }
}

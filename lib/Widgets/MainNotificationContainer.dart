import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Models/NotificationModel.dart';
import '../Screens/FullNotificationCenter.dart';
import '../Styles/applayout.dart';
import 'HeadingNavigation.dart';
import 'LoadingContainer.dart';
import 'NotFoundContainer.dart';
import 'NotificationContainer.dart';

class MainNotificationContainer extends StatefulWidget {
  const MainNotificationContainer({Key? key}) : super(key: key);

  @override
  State<MainNotificationContainer> createState() => _MainNotificationContainerState();
}

class _MainNotificationContainerState extends State<MainNotificationContainer> {
  List<NotificationModel> notData = [];
  bool found = true;
  int totalCount = 0;
  DatabaseReference ref = FirebaseDatabase.instance.ref("PersonalNotifications")
      .child(FirebaseAuth.instance.currentUser!.uid);
  String mainTime="";
  @override
  Widget build(BuildContext context) {
    final size = AppLayout.getSize(context);
    return Container(
      width: size.width,
      height: size.height * 0.275,
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Padding(
        padding: EdgeInsets.all(26),
        child: Column(
          children: [
            GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(
                      builder: (builder) => FullNotificationCenter()));
                },
              child: totalCount==0?HeadingNav(title: "NOTIFICATIONS"):HeadingNav(title: totalCount.toString()+' New Notifications',),),
            Gap(20),
            Expanded(
                child: StreamBuilder(
                    stream: ref.onValue, builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data!.snapshot.children.length < 1) {
                      return NotFoundContainer();
                    }
                    notData.clear();
                    for (DataSnapshot dataSnapshot in snapshot.data!.snapshot
                        .children) {
                      NotificationModel model = NotificationModel(dataSnapshot
                          .child("time")
                          .value
                          .toString(), dataSnapshot
                          .child("type")
                          .value
                          .toString(), dataSnapshot
                          .child("from")
                          .value
                          .toString(), dataSnapshot
                          .child("notID")
                          .value
                          .toString());
                      notData.add(model);
                    }
                  } else {
                    return Center(child: LoadingContainer());
                  }
                  return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: notData.length,
                      itemBuilder: (BuildContext context, index) {
                        return InkWell(
                          onTap: (){
                            fixDate(notData.elementAt(index).time);

                            popDialog(notData.elementAt(index).from,notData.elementAt(index).type,notData.elementAt(index).time,notData.elementAt(index).notID);

                          },
                          child: NotificationContainer(from: notData
                              .elementAt(index)
                              .from, type: notData
                              .elementAt(index)
                              .type, time: notData
                              .elementAt(index)
                              .time, notID: notData
                              .elementAt(index)
                              .notID,),
                        );
                      });
                }
                )
            )


          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    getNotifications();
  }

  void getNotifications() {
    DatabaseReference ref = FirebaseDatabase.instance.ref(
        "PersonalNotifications").child(FirebaseAuth.instance.currentUser!.uid);
    Stream<DatabaseEvent> event = ref.onValue;
    event.listen((event) {
      setState(() {
        totalCount = int.parse(event.snapshot.children.length.toString());
      });
    });
  }

  void popDialog(String from, String type, String time, String notID) {
    showDialog(context: context, builder: (builder){
      return CupertinoAlertDialog(
        title: Text("Notification",style: GoogleFonts.montserrat(fontSize: 16,fontWeight: FontWeight.w400),),
        content: Column(
          children: [
            Gap(10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text("FROM:",style: GoogleFonts.montserrat(fontSize: 14,fontWeight: FontWeight.w300),),
                Text(from,style: GoogleFonts.montserrat(fontSize: 14,fontWeight: FontWeight.w400),),
              ],
            ),
            Gap(10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(type=="New Appointment"?"TYPE":"Message",style: GoogleFonts.montserrat(fontSize: 14,fontWeight: FontWeight.w300),),
                Text(type==""?type:type.length>17?type.substring(0,13)+"....":type,style: GoogleFonts.montserrat(fontSize: 14,fontWeight: FontWeight.w400),),
              ],
            ),
            Gap(10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text("TIME:",style: GoogleFonts.montserrat(fontSize: 14,fontWeight: FontWeight.w300),),
                Text(mainTime,style: GoogleFonts.montserrat(fontSize: 14,fontWeight: FontWeight.w400),),
              ],
            ),
          ],
        ),
        actions: [
          CupertinoDialogAction(child: Text("Done",style: GoogleFonts.montserrat(fontSize: 16,fontWeight: FontWeight.w500),),isDestructiveAction: true,onPressed: ()  {
            DatabaseReference ref=FirebaseDatabase.instance.ref("PersonalNotifications").child(FirebaseAuth.instance.currentUser!.uid).child(notID);
             ref.remove();
             Navigator.pop(context);
             setState(() {

             });

          },
          ),
        ],
      );
    });
  }

  void fixDate(String time) {
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
      mainTime=day+","+hr+":"+min;

  }
}

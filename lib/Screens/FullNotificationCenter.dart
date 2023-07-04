import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meddoc/Widgets/TitlewithNavigation.dart';

import '../Models/NotificationModel.dart';
import '../Styles/styles.dart';
import '../Widgets/LoadingContainer.dart';
import '../Widgets/NotFoundContainer.dart';
import '../Widgets/NotificationContainer.dart';
import '../Widgets/VerticalNotificationContainer.dart';

class FullNotificationCenter extends StatefulWidget {
  const FullNotificationCenter({Key? key}) : super(key: key);

  @override
  State<FullNotificationCenter> createState() => _FullNotificationCenterState();
}

class _FullNotificationCenterState extends State<FullNotificationCenter> {
  DatabaseReference ref=FirebaseDatabase.instance.ref("PersonalNotifications").child(FirebaseAuth.instance.currentUser!.uid);
  List<NotificationModel> notData=[];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Styles.bgColor,
      body: Column(
        children: [
          TitleNavigation(title: "All Notifications"),
          Expanded(
            child: StreamBuilder(stream:ref.onValue,builder: (context,snapshot){
              if(snapshot.hasData){
                if(snapshot.data!.snapshot.children.length<1){
                  return NotFoundContainer();
                }
                notData.clear();

                for(DataSnapshot dataSnapshot in snapshot.data!.snapshot.children){
                  NotificationModel model=NotificationModel(dataSnapshot.child("time").value.toString(), dataSnapshot.child("type").value.toString(), dataSnapshot.child("from").value.toString(), dataSnapshot.child("notID").value.toString());
                  notData.add(model);
                }

              }else{
                return LoadingContainer();
              }
              return ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: notData.length,
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (BuildContext context,index){
                    return VerticalNotificationContainer(from: notData.elementAt(index).from,type: notData.elementAt(index).type,time: notData.elementAt(index).time,notID: notData.elementAt(index).notID,);

                  });

            }
            ),

          ),


        ],
      ),

    );
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Styles/styles.dart';
import '../Widgets/HistoryContainer.dart';
import '../Widgets/HistoryModel.dart';
import '../Widgets/LoadingContainer.dart';
import '../Widgets/NotFoundContainer.dart';
import '../Widgets/TitlewithNavigation.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {

  List<HistoryModel> data=[];
  List<HistoryModel> reverseddata=[];
  DatabaseReference ref=FirebaseDatabase.instance.ref("history").child(FirebaseAuth.instance.currentUser!.uid);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Styles.bgColor,
      body: Column(
        children: [
          TitleNavigation(title: 'History',),
          Expanded(child: StreamBuilder(stream:ref!.onValue,builder: (context,snapshot){
            if(snapshot.hasData){
              if(snapshot.data!.snapshot.children.length<1){
                return NotFoundContainer();
              }
              data.clear();
              for(DataSnapshot dataSnapshot in snapshot.data!.snapshot.children){
                HistoryModel model=HistoryModel(dataSnapshot.child("time").value.toString(),dataSnapshot.child("title").value.toString(),dataSnapshot.child("description").value.toString(),dataSnapshot.child("from").value.toString(), dataSnapshot.child("to").value.toString(),);
                data.add(model);
              }
              reverseddata=new List.from(data.reversed);
            }else{
              return LoadingContainer();
            }
            return ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: data.length,
                itemBuilder: (BuildContext context,index){
                  return Padding(
                    padding: EdgeInsets.only(top: 1),
                    child: HistoryContainer(time: reverseddata.elementAt(index).date,title:reverseddata.elementAt(index).title, from: reverseddata.elementAt(index).from,description: reverseddata.elementAt(index).description,to:reverseddata.elementAt(index).to),
                  );

                });

          }
          ),)

        ],
      ),
    );
  }
}

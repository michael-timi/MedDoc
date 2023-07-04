import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../Models/ChatList.dart';
import '../Models/CommonUserModel.dart';
import '../Styles/applayout.dart';
import '../Styles/styles.dart';
import '../Widgets/ConversationContainer.dart';
import '../Widgets/LoadingContainer.dart';
import '../Widgets/NotFoundContainer.dart';
import '../Widgets/TitleContainer.dart';

class DoctorsMessages extends StatefulWidget {
  const DoctorsMessages({Key? key}) : super(key: key);

  @override
  State<DoctorsMessages> createState() => _DoctorsMessagesState();
}

class _DoctorsMessagesState extends State<DoctorsMessages> {
  List<CommonUserModel> usersData=[];
  List<ChatList> chatListData=[];
  bool found=false;
  DatabaseReference userRef=FirebaseDatabase.instance.ref("Users").child("Patients");

  @override
  void initState() {
    getChatList();

  }

  @override
  Widget build(BuildContext context) {
    final size=AppLayout.getSize(context);
    return Scaffold(
      backgroundColor: Styles.bgColor,
      body: Column(
        children: [
          TitleContainer(title: "Messages",),
          Expanded(
            child: found?StreamBuilder(
                 stream: userRef.onValue,
                builder: (context,snapshot){
                   if(snapshot.hasData){
                     usersData.clear();
                     for(DataSnapshot dataSnap in snapshot.data!.snapshot.children){
                       String userID=dataSnap.key.toString();
                       String email=dataSnap.child("email").value.toString();
                       String image=dataSnap.child("imgURL").value.toString();
                       String name=dataSnap.child("name").value.toString();
                       CommonUserModel user = new CommonUserModel(userID,email,image,name);
                       for (ChatList chatlist in chatListData){
                         if (user!= null && user.userID!=null && chatlist!=null && chatlist.id!= null &&
                             user.userID==chatlist.id){
                           usersData.add(user);
                         }
                       }
                     }
                   }
                   else{
                     return LoadingContainer();
                   }
                   return ListView.builder(
                       scrollDirection: Axis.vertical,
                       itemCount: usersData.length,
                       itemBuilder: (BuildContext context,index){
                        return ConversationContainer(userKey: usersData.elementAt(index).userID,name: usersData.elementAt(index).name,imgURL: usersData.elementAt(index).image,doctor: false,);

                       });
                }
            )
                :
            Center(child: NotFoundContainer(),),
          ),




        ],


      ),

    );
  }

  void getChatList() {
    chatListData.clear();
    DatabaseReference reference = FirebaseDatabase.instance.ref("Chatlist").child(FirebaseAuth.instance.currentUser!.uid);

    Stream<DatabaseEvent> stream = reference.onValue;
    stream.listen((DatabaseEvent event) {

      for(DataSnapshot snapshot in event.snapshot.children){
        ChatList chatList=ChatList(snapshot.child("id").value.toString());
        chatListData.add(chatList);
      }
      if(chatListData.isEmpty){
        setState(() {
          found=false;
        });
      }else{
        setState(() {
          found=true;
        });
      }


    });


  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Models/Chat.dart';
import '../Screens/ChatScreen.dart';
import '../Styles/applayout.dart';
import '../Styles/styles.dart';
import 'MediumIcon.dart';
import 'MediumImage.dart';

class ConversationContainer extends StatefulWidget {
  String imgURL,name,userKey;
  bool doctor;
   ConversationContainer({Key? key,required this.imgURL,required this.name,required this.userKey,required this.doctor}) : super(key: key);

  @override
  State<ConversationContainer> createState() => _ConversationContainerState();
}

class _ConversationContainerState extends State<ConversationContainer> {


String theLastMessage="";
  @override
  Widget build(BuildContext context) {
    final size=AppLayout.getSize(context);
    return GestureDetector(
      onTap:() {
    Navigator.push(context, MaterialPageRoute(builder: (builder)=>ChatScreen(doctor:widget.doctor,receiverUID: widget.userKey,)));
    },
      child: Container(
        width: size.width,
        height: size.height*0.10,
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Padding(
          padding: EdgeInsets.all(12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(

                children: [
                  Gap(5),
                 MediumImage(imageAsset: widget.imgURL,),
                  Gap(20),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                        Text(widget.name,style: GoogleFonts.montserrat(fontSize: 16,color: Colors.black,fontWeight: FontWeight.w500),),
                        Gap(1),
                        Text(theLastMessage==""?theLastMessage:theLastMessage.length>30?theLastMessage.substring(0,30)+"...":theLastMessage,style: GoogleFonts.montserrat(fontSize: 12,color: Colors.black,fontWeight: FontWeight.w400),)
                    ],
                  ),
                ],
              ),






            ],
          ),
        ),
      ),
    );
  }

@override
  void initState() {
    getLastMessage();
//
  }

  void getLastMessage() {

    User? user=FirebaseAuth.instance.currentUser;
    DatabaseReference reference = FirebaseDatabase.instance.ref("Chats");


    Stream<DatabaseEvent> event=reference.onValue;

    event.listen((event) {

      for (DataSnapshot snapshot in event.snapshot.children){
      Chat chat = Chat(snapshot.child("sender").value.toString(),snapshot.child("receiver").value.toString(),snapshot.child("message").value.toString(),snapshot.child("isseen").value.toString(),snapshot.child("time").value.toString());
          if (user != null && chat != null) {
                 if (chat.receiver==user.uid && chat.sender==widget.userKey ||
                      chat.receiver==widget.userKey && chat.sender==user.uid) {
                   setState(() {
                     theLastMessage=chat.message;
                   });
                   }
              }
      }

      switch (theLastMessage){
        case  "default":
          setState(() {
            theLastMessage="No Message";
          });
          break;

        default:
          setState(() {
            theLastMessage=theLastMessage;
          });
          break;
      }









    });



  }
}

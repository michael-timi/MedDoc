import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:unicons/unicons.dart';

import '../Styles/applayout.dart';
import '../Styles/styles.dart';
import 'MediumIcon.dart';

class MessageSender extends StatefulWidget {
  String receiverID;
  String myID;
  bool doctor;
   MessageSender({Key? key,required this.receiverID,required this.myID,required this.doctor}) : super(key: key);


  @override
  State<MessageSender> createState() => _MessageSenderState();
}

class _MessageSenderState extends State<MessageSender> {
  String getusername="";
  String token="";
  final _messageController = TextEditingController();

  @override
  void initState() {
    getInfo();
    getmyInfo();
  }

  @override
  Widget build(BuildContext context) {
    final size = AppLayout.getSize(context);
    return Container(
      width: size.width,
      height: size.height * 0.13,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: size.width*0.780,
            height: size.height,
            child: TextField(
              controller: _messageController,
              textInputAction: TextInputAction.newline,
              autofocus: true,
              autocorrect: false,
              keyboardType: TextInputType.multiline,
              minLines: 1,
              maxLines: 8,
              decoration: InputDecoration(

                labelStyle: GoogleFonts.montserrat(
                    fontSize: 16, fontWeight: FontWeight.w400),
                hintStyle: GoogleFonts.montserrat(
                    fontSize: 16, fontWeight: FontWeight.w400),
                hintText: "Type your Message",
                fillColor: Colors.white,
                filled: true,

                focusedBorder: OutlineInputBorder(
                    borderSide:
                    BorderSide(color: Colors.white, width: 1.0),
                    borderRadius: BorderRadius.circular(1.0)),

              ),

            ),
          ),
          Gap(5),
          GestureDetector(
            child: MediumIcon(icon: Icons.send,
              iconColor: Styles.primaryColor,
              bgColor: Styles.shadeColorPrimary,),
            onTap: ()  {
              if(_messageController.text.isEmpty){
                setState(() {
                  showMessage("Cannot send empty message");

                });
              }else{
                String msg=_messageController.text;
                sendMessage(msg);
                _messageController.clear();

              }

            },
          )

        ],

      ),

    );
  }

  @override
  void dispose() {
    _messageController.dispose();
  }

  Future<void> sendMessage(String msgnew) async {
    DatabaseReference reference = FirebaseDatabase.instance.ref();
    String datetime = DateTime.now().toString();

    Map<String, Object> hashMap = {
      "sender": widget.myID,
      "receiver": widget.receiverID,
      "message": msgnew,
      "isseen": "false",
      "time": datetime
    };
    
    
    reference.child("Chats").push().set(hashMap);

    final DatabaseReference chatRef = FirebaseDatabase.instance.ref("Chatlist")
        .child(widget.myID)
        .child(widget.receiverID);
    final snapshot = await chatRef.get();
    if (!snapshot.exists) {
      chatRef.child("id").set(widget.receiverID);
    }
    final DatabaseReference chatRefReceiver = FirebaseDatabase.instance.ref(
        "Chatlist")
        .child(widget.receiverID)
        .child(widget.myID);
    chatRefReceiver.child("id").set(widget.myID);



    addNotification(getusername,msgnew,datetime,widget.receiverID);
    sendNotification('From: '+getusername,'New Message');

    print("username:"+getusername);




  }

  Future<void> sendNotification(String body, String title) async {

    try{
      await post(Uri.parse('https://fcm.googleapis.com/fcm/send'),headers: <String,String>{
        'Content-Type':'application/json',
        'Authorization':'key=AAAAfVecfvE:APA91bFLQDYmEYp6vFbBxdncTgeOwzZBd0NH83aK9sJi7TtNfdxFJDjviDKS3xFSaiXOYtFgQj3ZDQIFhIiPvz5aeHo3dzGQ0D3IMAXdBKLDZxEIbAQ6EJgUEI4M_RNxG4USHri3KLMD'

      },
          body: jsonEncode(
            <String,dynamic>{
              'priority':'high',
              'data': <String, dynamic>{
                'click-action':'FLUTTER_NOTIFICATION_CLICK',
                'status':'done',
                'body':body,
                'title':title,
              },
              "notification": <String,dynamic>{
                'body':body,
                'title':title,
                "android_channel_id":'mainChannel',
              },
              'to': token,
            },
          )
      );
    }catch(e){
      print("Message Exception: "+e.toString());

    }

  }
  void showMessage(String s) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(s)),
    );
  }

  void addNotification(String getusername, String type, String datetime, String receiverID)  {
    DatabaseReference ref=FirebaseDatabase.instance.ref("PersonalNotifications").child(receiverID).push();
    Map<String,Object> map={
      'time':datetime,
      'from':getusername,
    'userID':FirebaseAuth.instance.currentUser!.uid,
    'type':type,
      'notID':ref.key!
    };
     ref.update(map);

  }
  void getInfo() {
    late String root;
    widget.doctor?root="Patients":root="Doctors";
    DatabaseReference reference = FirebaseDatabase.instance.ref("Users").child(root).child(widget.receiverID);
    print("root:" +root);
    print("receiver ID:" +widget.receiverID);

    reference.once().then((value) => {
      setState((){
        token=value.snapshot.child("token").value.toString();
        print("token from getinfo: "+token);
      }),
    });

  }  void getmyInfo() {

    late String root;
    widget.doctor?root="Doctors":root="Patients";
    DatabaseReference reference = FirebaseDatabase.instance.ref("Users").child(root).child(FirebaseAuth.instance.currentUser!.uid);
    print("root:" +root);

    reference.once().then((value) => {
      setState((){
        getusername=value.snapshot.child("name").value.toString();
        print("haan wai:"+getusername);
      }),
    });


  }
}

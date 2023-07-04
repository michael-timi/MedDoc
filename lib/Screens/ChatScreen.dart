import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meddoc/Widgets/TitlewithNavigation.dart';

import '../Models/Chat.dart';
import '../Styles/applayout.dart';
import '../Styles/styles.dart';
import '../Widgets/LoadingContainer.dart';
import '../Widgets/MessageSender.dart';
import '../Widgets/SingleMessage.dart';

class ChatScreen extends StatefulWidget {
  String receiverUID;
  bool doctor;
   ChatScreen({Key? key,required this.receiverUID,required this.doctor}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  DatabaseReference chatRef=FirebaseDatabase.instance.ref("Chats");
  List<Chat> chatList=[];
  List<Chat> data=[];
  String receiverName="";
  String myid="";



  @override
  Widget build(BuildContext context) {
    final size=AppLayout.getSize(context);
    return Scaffold(
      backgroundColor: Styles.bgColor,
      body: Column(
        children: [
          InkWell(child: TitleNavigation(title: receiverName,),onTap: (){
            Navigator.pop(context);
          },),
          Expanded(child: Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Styles.bgColor,
            ),
            child: StreamBuilder(
              stream: chatRef.onValue,
              builder: (context,snapshot){
                if(snapshot.hasData){
                  chatList.clear();
                  for(DataSnapshot dataSnap in snapshot.data!.snapshot.children){
                    Chat chat=Chat(dataSnap.child("sender").value.toString(),dataSnap.child("receiver").value.toString(),
                        dataSnap.child("message").value.toString(),dataSnap.child("isseen").value.toString(),
                        dataSnap.child("time").value.toString());

                    if (chat.receiver==myid && chat.sender==widget.receiverUID || chat.receiver==widget.receiverUID && chat.sender==myid){
                      chatList.add(chat);
                    }
                  }
                  data = new List.from(chatList.reversed);


                }else{
                  return LoadingContainer();
                }
                return ListView.builder(
                    scrollDirection: Axis.vertical,
                    reverse: true,

                    itemCount: data.length,
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (BuildContext context,index){
                      bool isMe=myid==data.elementAt(index).sender;
                      return SingleMessage(message: data.elementAt(index).message,isMe: isMe,);



                    });
              },

            ),


          ),
          ),
      MessageSender(receiverID: widget.receiverUID, myID: myid,doctor:!widget.doctor),
        ],
      ),
    );
  }

  @override
  void initState() {
    getReceiverInfo();
  }

  Future<void> getReceiverInfo() async {
    DatabaseReference reference;
    late String root;
    widget.doctor?root="Doctors":root="Patients";
    reference = FirebaseDatabase.instance.ref("Users").child(root).child(widget.receiverUID);

    final snapshot = await reference.get();
    if (snapshot.exists) {
      setState(() {
        receiverName=snapshot.child("name").value.toString();
        myid=FirebaseAuth.instance.currentUser!.uid;

      });


    }else{
    }
  }
}

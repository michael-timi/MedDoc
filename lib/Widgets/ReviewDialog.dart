import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:lottie/lottie.dart';
import 'package:meddoc/Widgets/PrimaryButton.dart';
import 'package:unicons/unicons.dart';

import '../Styles/applayout.dart';
import '../Styles/styles.dart';

class ReviewDialog extends StatefulWidget {
  String docID,patientID,appointID;
   ReviewDialog({Key? key,required this.docID,required this.patientID,required this.appointID}) : super(key: key);

  @override
  State<ReviewDialog> createState() => _ReviewDialogState();
}

class _ReviewDialogState extends State<ReviewDialog> {


  bool visible=false;
  double finalRating=3.0;
  String myName="";
  String token="";
  int number=0;
    String docName='';

  late int textsize=0;
  final _controllerRating=TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size=AppLayout.getSize(context);
    return Column(
      children: [
        Gap(10),
        Lottie.asset("animations/rating.json",
            width: 250, height: 180, repeat: false),
        Gap(10),
        Card(
            color: Colors.transparent,
            elevation: 0.0,
            child: Column(
              children: <Widget>[
                TextField(
                  controller: _controllerRating,
                  keyboardType: TextInputType.multiline,
                  maxLength: 500,

                  onChanged: (value){
                    textsize=value.length;

                  },
                  decoration: InputDecoration(
                      labelText: "Wrtie your review here",
                      filled: true,
                      border: OutlineInputBorder(
                        gapPadding: 2,
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                      fillColor: Colors.white),
                ),
              ],
            )
        ),
        Gap(10),
        RatingBar.builder(
          initialRating: 3,
          itemCount: 5,
          itemBuilder: (context, index) {
            switch (index) {
              case 0:
                return Icon(
                  Icons.sentiment_very_dissatisfied,
                  color: Colors.red,
                );
              case 1:
                return Icon(
                  Icons.sentiment_dissatisfied,
                  color: Colors.redAccent,
                );
              case 2:
                return Icon(
                  Icons.sentiment_neutral,
                  color: Colors.amber,
                );
              case 3:
                return Icon(
                  Icons.sentiment_satisfied,
                  color: Colors.lightGreen,
                );
              case 4:
                return Icon(
                  Icons.sentiment_very_satisfied,
                  color: Colors.green,
                );
              default:
                return Icon(
                  Icons.sentiment_very_satisfied,
                  color: Colors.green,
                );
            }
          },
          onRatingUpdate: (rating) {
            setState(() {
              finalRating=rating;
            });
          },
        ),
        Gap(10),
        CupertinoButton(
            child: Text("Send",style: GoogleFonts.montserrat(fontSize: 16,fontWeight: FontWeight.w400),),
            onPressed: (){
              if(textsize>0){
                print(widget.docID);
                DatabaseReference ref=FirebaseDatabase.instance.ref("Reviews").child(widget.docID).push();
                Map<String,Object> map={
                  'patientID':widget.patientID,
                  'doctorID':widget.docID,
                  'date':DateTime.now().toString(),
                  'from':myName,
                  'stars':finalRating,
                  'review':_controllerRating.text,
                  'revKey':ref.key!,
                };
                ref.update(map).whenComplete(() => {
                  sendNotification("Stars: "+finalRating.toString(), "Got a new Review!!"),
                  dellUser(),
                  makeHistoryPatient('Review','You have sent a review'),
                  makeHistoryDoctor('Review','You have received a review'),


                });
              }else{
                showMessage("Please write something..");
              }
        }),


      ],
    );
  }
  void showMessage(String s) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(s)),
    );
  }

  @override
  void dispose() {
    _controllerRating.dispose();
  }

  @override
  void initState() {
    getmyInfo();
  }

  void getmyInfo() {
    DatabaseReference ref=FirebaseDatabase.instance.ref("Users").child("Patients").child(widget.patientID);
    ref.once().then((value) => {
      myName=value.snapshot.child("name").value.toString(),
    });
    DatabaseReference ref2=FirebaseDatabase.instance.ref("Users").child("Doctors").child(widget.docID);
    ref2.once().then((value) => {
      token=value.snapshot.child("token").value.toString(),
      docName=value.snapshot.child("name").value.toString(),


    });

  }

  dellUser() {
    DatabaseReference reference=FirebaseDatabase.instance.ref("bookings").child(widget.appointID);
    reference.remove().whenComplete(() => {

      Navigator.of(context).pop(),

    });
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

    makeHistoryPatient(String s, String t) {
      DatabaseReference reference=FirebaseDatabase.instance.ref("history").child(widget.patientID).push();
      Map<String,Object> map={
        'title':s,
        'description':t,
        'time':DateTime.now().toString(),
        'to':docName,
        'from':"",
      };
      reference.update(map);
    }

    makeHistoryDoctor(String s, String t) {
      DatabaseReference reference=FirebaseDatabase.instance.ref("history").child(widget.docID).push();
      Map<String,Object> map={
        'title':s,
        'description':t,
        'time':DateTime.now().toString(),
        'to':"",
        'from':myName,
      };
      reference.update(map);
    }


}

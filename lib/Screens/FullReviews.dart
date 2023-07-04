import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Models/ReviewsModel.dart';
import '../Styles/styles.dart';
import '../Widgets/NotFoundContainer.dart';
import '../Widgets/ReviewsContainer.dart';
import '../Widgets/TitlewithNavigation.dart';
import '../Widgets/VerticalReviewsContainer.dart';

class FullReviews extends StatefulWidget {
  String docID;
   FullReviews({Key? key,required this.docID}) : super(key: key);

  @override
  State<FullReviews> createState() => _FullReviewsState();
}

class _FullReviewsState extends State<FullReviews> {
  List<ReviewsModel> revData=[];
  DatabaseReference? ref;

  @override
  void initState() {
    super.initState();
    setState((){
      ref=FirebaseDatabase.instance.ref("Reviews").child(widget.docID);

    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Styles.bgColor,
      body: Column(
        children: [
          TitleNavigation(title: "All Reviews"),
          Expanded(
            child: StreamBuilder(stream:ref!.onValue,builder: (context,snapshot){
              if(snapshot.hasData){
                if(snapshot.data!.snapshot.children.length<1){
                  return NotFoundContainer();
                }
                revData.clear();

                for(DataSnapshot dataSnapshot in snapshot.data!.snapshot.children){
                  ReviewsModel model=ReviewsModel(dataSnapshot.child("date").value.toString(), dataSnapshot.child("review").value.toString(), dataSnapshot.child("from").value.toString(), dataSnapshot.child("revKey").value.toString(),dataSnapshot.child("stars").value.toString());
                  revData.add(model);
                }

              }else{
                return CircularProgressIndicator();
              }
              return ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: snapshot.data!.snapshot.children.length,
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (BuildContext context,index){
                    return  VerticalReviewsContainer(from: revData.elementAt(index).from,review: revData.elementAt(index).review,time: revData.elementAt(index).time,revID: revData.elementAt(index).revID,stars: revData.elementAt(index).stars,);


                  });

            }
            ),

          ),


        ],
      ),

    );
  }
}

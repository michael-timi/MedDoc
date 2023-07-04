import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Models/ReviewsModel.dart';
import '../Screens/FullReviews.dart';
import '../Styles/applayout.dart';
import 'HeadingNavigation.dart';
import 'LoadingContainer.dart';
import 'NotFoundContainer.dart';
import 'ReviewsContainer.dart';

class MainReviewsContainer extends StatefulWidget {
  String docID;
  bool doc;
   MainReviewsContainer({Key? key, required this.docID,required this.doc}) : super(key: key);

  @override
  State<MainReviewsContainer> createState() => _MainReviewsContainerState();
}

class _MainReviewsContainerState extends State<MainReviewsContainer> {
  List<ReviewsModel> revData=[];
  bool found=false;
  DatabaseReference? ref;

  @override
  Widget build(BuildContext context) {
    final size=AppLayout.getSize(context);
    return Container(
      width: size.width,
      height: size.height*0.275,
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Padding(
        padding: EdgeInsets.all(26),
        child: Column(
          children: [
            GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (builder)=>FullReviews(docID: widget.docID,)));

                },
                child: HeadingNav(title: "REVIEWS")),
            Gap(20),
            Expanded(child: StreamBuilder(stream:ref!.onValue,builder: (context,snapshot){
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
                return LoadingContainer();
              }
              return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: revData.length,
                  itemBuilder: (BuildContext context,index){
                    return Padding(
                      padding: EdgeInsets.only(right: 10),
                        child: ReviewsContainer(from: revData.elementAt(index).from,review: revData.elementAt(index).review,time: revData.elementAt(index).time,revID: revData.elementAt(index).revID,stars: revData.elementAt(index).stars,));

                  });

            }
            ),

            ),
          ],
        ),
      ),

    );
  }

  @override
  void initState() {
    super.initState();
    setState((){
      ref=FirebaseDatabase.instance.ref("Reviews").child(widget.docID);

    });

  getReviews();
  }

  void getReviews() {
    // revData.clear();
    //
    // DatabaseReference ref=FirebaseDatabase.instance.ref("Reviews").child(FirebaseAuth.instance.currentUser!.uid);
    // Stream<DatabaseEvent> event=ref.onValue;
    // event.listen((event) {
    //
    //   if(event.snapshot.exists){
    //
    //     setState(() {
    //       found=true;
    //     });
    //
    //
    //
    //
    //
    //   }else{
    //     setState(() {
    //       found=false;
    //     });
    //   }
    //
    //
    //
    // });

  }
}

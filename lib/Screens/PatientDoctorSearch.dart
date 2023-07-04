import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meddoc/Screens/DoctorsProfile.dart';
import 'package:meddoc/Styles/applayout.dart';
import 'package:meddoc/Widgets/TitleContainer.dart';
import 'package:unicons/unicons.dart';

import '../DoctorsModel.dart';
import '../Styles/styles.dart';
import '../Widgets/LoadingContainer.dart';
import '../Widgets/NearbyDoctorContainer.dart';
import '../Widgets/NotFoundContainer.dart';
import 'TitleSearchContainer.dart';



class PatientDoctorSearch extends StatefulWidget {
  const PatientDoctorSearch({Key? key}) : super(key: key);

  @override
  State<PatientDoctorSearch> createState() => _PatientDoctorSearchState();
}

class _PatientDoctorSearchState extends State<PatientDoctorSearch> {
  List<DoctorsModel> data=[];
  List<DoctorsModel> filterData=[];
  String searchText="";
  DatabaseReference reference=FirebaseDatabase.instance.ref("Users").child("Doctors");

final _searchController=TextEditingController();
  @override
  void dispose() {

  }

  @override
  Widget build(BuildContext context) {
    final size=AppLayout.getSize(context);
    return Scaffold(
      backgroundColor: Styles.bgColor,
      body: Column(
        children: [
          Container(
            width: size.width,
            height: size.height*0.2,
            decoration: BoxDecoration(
              color: Styles.primaryColor,
            ),
            child:Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(padding: EdgeInsets.all(26),
                    child: Column(
                      children: [
                        Gap(15),
                        Row(
                          children: [
                            Text("Search Specialist",style: GoogleFonts.montserrat(fontSize: 18,color: Colors.white,fontWeight: FontWeight.w500),),
                          ],
                        ),
                        Gap(15),
                        TextField(
                            style: GoogleFonts.montserrat(fontSize: 16,color: Colors.black),
                            keyboardType: TextInputType.name,
                            controller: _searchController,
                            enableSuggestions: true,
                            onChanged: (value){
                              searchText=value;
                              addDataToSearch(value);
                              if(value.length>1){
                                setState(() {

                                });
                              }else{
                                setState(() {

                                });
                              }
                            },
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              contentPadding:
                              EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                              prefixIcon: Icon(UniconsLine.search,color: Colors.black),
                              prefixIconColor: Colors.white,
                              hintText: "Search Doctor",
                              border: OutlineInputBorder(
                                  borderSide:
                                  BorderSide(color: Colors.white, width: 32.0),
                                  borderRadius: BorderRadius.circular(15.0)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide:
                                  BorderSide(color: Colors.white, width: 32.0),
                                  borderRadius: BorderRadius.circular(20.0)),
                              disabledBorder: OutlineInputBorder(
                                  borderSide:
                                  BorderSide(color: Colors.white, width: 32.0),
                                  borderRadius: BorderRadius.circular(25.0)
                              ),

                            )
                        ),

                      ],
                    )
                ),
              ],
            ),

          ),
          Expanded(
            child: StreamBuilder(
              stream: reference.onValue,
              builder: (context,snapshot){
                if(snapshot.hasData){
                  if(snapshot.data!.snapshot.children.length<1){
                    return NotFoundContainer();
                  }
                  data.clear();
                  for(DataSnapshot dataSnap in snapshot.data!.snapshot.children){
                    if(dataSnap.child("scheduled").exists){
                      data.add(DoctorsModel(dataSnap.key.toString(),dataSnap.child("address").value.toString(), dataSnap.child("age").value.toString(), dataSnap.child("email").value.toString(), dataSnap.child("experience").value.toString(), dataSnap.child("gender").value.toString(), dataSnap.child("hospitalAddress").value.toString(), dataSnap.child("imgURL").value.toString(), dataSnap.child("name").value.toString(), dataSnap.child("password").value.toString(), dataSnap.child("specialization").value.toString(), dataSnap.child("type").value.toString()));
                    }
                  }
                } else{
                  return LoadingContainer();
                }
                return searchText.length>0?ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: filterData.length,
                    itemBuilder: (BuildContext context,index){
                      return GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (builder)=>DoctorsProfile(docID: filterData.elementAt(index).UID, doctor: false,)));
                        },
                        child: Padding(
                            padding: EdgeInsets.only(top: 1),
                            child: NearbyDoctorContainer(UID:filterData.elementAt(index).UID,name: filterData.elementAt(index).name,specialization: filterData.elementAt(index).specialization,gender: filterData.elementAt(index).gender,experience: filterData.elementAt(index).experience,imgURL:filterData.elementAt(index).imgURL)),
                      );
                    }):ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: data.length,
                    itemBuilder: (BuildContext context,index){
                      return GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (builder)=>DoctorsProfile(docID: data.elementAt(index).UID, doctor: false,)));
                        },
                        child: Padding(
                          padding: EdgeInsets.only(top: 1),
                            child: NearbyDoctorContainer(UID:data.elementAt(index).UID,name: data.elementAt(index).name,specialization: data.elementAt(index).specialization,gender: data.elementAt(index).gender,experience: data.elementAt(index).experience,imgURL:data.elementAt(index).imgURL)),
                      );
                    });
              },
            ),
          )

        ],
      )
    );
  }

  void addDataToSearch(String value) {
    filterData.clear();

    for (DoctorsModel item in data) {
      if (item.name.toLowerCase().contains(value.toLowerCase())) {
        filterData.add(item);
      }else if(item.specialization.toLowerCase().contains(value.toLowerCase())){
        filterData.add(item);
      }
    }
  }
}

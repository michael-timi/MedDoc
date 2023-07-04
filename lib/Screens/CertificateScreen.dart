import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meddoc/Styles/applayout.dart';
import 'package:meddoc/Widgets/LargeIcon.dart';
import 'package:meddoc/Widgets/TitlewithNavigation.dart';
import 'dart:io';
import 'package:uuid/uuid.dart';

import '../Models/CertificateModel.dart';
import '../Styles/styles.dart';
import '../Widgets/CertificateContainer.dart';
import '../Widgets/NotFoundContainer.dart';

class CertificateScreen extends StatefulWidget {
  String docID;

  bool doctor;

  CertificateScreen({Key? key,required this.docID,required this.doctor}) : super(key: key);

  @override
  State<CertificateScreen> createState() => _CertificateScreenState();
}

class _CertificateScreenState extends State<CertificateScreen> {
  bool loading=false;
  bool selected=false;
  bool imagesLoading=true;
  bool imagesFound=false;
  int size=0;
  var uuid = Uuid();

  List<CertificateModel> listData=[];

  @override
  void initState() {
    getImages();
  }

  List<String> paths=[];
  @override
  Widget build(BuildContext context) {
    final size=AppLayout.getSize(context);
    return Scaffold(
      backgroundColor: Styles.bgColor,
      body: Column(
        children: [
          TitleNavigation(title: 'Certificates'),
          Expanded(child:
          ListView(
            scrollDirection: Axis.vertical,
            children: [
             widget.doctor? Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 22,right: 22,),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("You can upload your",style: GoogleFonts.montserrat(fontSize: 16,fontWeight: FontWeight.w400),),
                        Gap(2),
                        Text("Doctor Certificates",style: GoogleFonts.montserrat(fontSize: 18,fontWeight: FontWeight.w500),),
                        Gap(2),
                        Text("that can be used to enhance your doctor profile.",style: GoogleFonts.montserrat(fontSize: 14,fontWeight: FontWeight.w300),),
                        Container(

                        )
                      ],
                    ),
                  ),
                  Gap(20),
                  loading?CircularProgressIndicator():
                  GestureDetector(
                    onTap: showMethods,
                    child: Container(
                      width: size.width*0.5,
                      height: size.height*0.08,
                      decoration: BoxDecoration(
                        color: Styles.primaryColor,
                        borderRadius: BorderRadius.circular(22),
                      ),
                      child: Center(
                        child: Text("Upload",style: GoogleFonts.montserrat(fontSize: 16,color: Colors.white),),
                      ),
                    ),
                  ),
                 Gap(20),
                 imagesFound? CarouselSlider.builder(
                    itemCount: listData.length,

                    options: CarouselOptions(
                      autoPlay: false,
                      height: size.height,
                      reverse: false,
                      enableInfiniteScroll: false,



                    ),
                    itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) =>
                        Padding(padding: EdgeInsets.only(left: 12,right: 12,top: 12,bottom: 12),
                            child: Column(
                              children: [
                                CertificateContainer(value: listData.elementAt(itemIndex).value,id: listData.elementAt(itemIndex).id,),
                                Gap(20),
                                GestureDetector(
                                  onTap: (){
                                    deleteItem(itemIndex);
                                  },

                                    child: LargeIcon(icon: Icons.delete_outline_outlined, bgColor: Colors.white, iconColor: Styles.primaryColor)),

                              ],
                            )
                        )
                  ):NotFoundContainer(),



                ],
              ):Column(
               children: [
                 imagesFound? CarouselSlider.builder(
                     itemCount: listData.length,
                     options: CarouselOptions(
                       autoPlay: false,
                       height: size.height,
                       reverse: false,

                     ),
                     itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) =>
                         Padding(padding: EdgeInsets.only(left: 12,right: 12,top: 12,bottom: 12),
                             child: CertificateContainer(value: listData.elementAt(itemIndex).value,id: listData.elementAt(itemIndex).id,))
                 ):NotFoundContainer(),


               ],
             ),


            ],
          ),
          )
        ],
      ),
    );
  }

  showMethods() {
    showCupertinoModalPopup(context: context, builder: (builder){
      return CupertinoActionSheet(
        title: Text("Select any",style: GoogleFonts.montserrat(fontSize: 16,fontWeight: FontWeight.w500),),
        actions: <Widget>[
          CupertinoActionSheetAction(
            child: Text("Open Gallery",style:GoogleFonts.montserrat(fontSize: 16,fontWeight: FontWeight.w400)),
            isDefaultAction: true,
            onPressed: () async {
              final ImagePicker _picker = ImagePicker();

              final List<XFile>? images = await _picker.pickMultiImage();
              setState(() {
                paths.clear();
                Navigator.pop(context);
                loading=true;
                for(int i=0;i<images!.length;i++){
                  paths.add(images.elementAt(i).path);
                }
                



              });
              uploadImages();
            },
          ),

          CupertinoActionSheetAction(
            child: Text("Reset",style:GoogleFonts.montserrat(fontSize: 16,fontWeight: FontWeight.w400)),
            isDestructiveAction: true,
            onPressed: ()  {
              Navigator.pop(context);
              paths.clear();
              setState(() {

              });
            },
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
          child: Text("Cancel",style: GoogleFonts.montserrat(fontSize: 16,fontWeight: FontWeight.w400)),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      );
    });
  }
  Future<void> uploadImages() async {
    int count=0;
    for(int i=0;i<paths.length;i++){
      final storageRef = FirebaseStorage.instance.ref("Certificates").child(widget.docID).child(uuid.v1());
      count++;
      File file = File(paths.elementAt(i));

      await storageRef.putFile(file).whenComplete(() => {
        storageRef.getDownloadURL().then((value) => {
            updateinDatabase(widget.docID,value),
        }).catchError((onError){
          setState(() {
            loading=false;
          });
        }),

      });
      if(i==paths.length-1){
        setState(() {
          loading=false;
        });
      }


    }




  }

  void updateinDatabase(String docID, String value) {
    DatabaseReference ref=FirebaseDatabase.instance.ref("Certificates").child(docID);
    Map<String,Object> map={
      uuid.v1():value,
    };
    ref.update(map);

  }

  void getImages() {
    listData.clear();
    DatabaseReference reference=FirebaseDatabase.instance.ref("Certificates").child(widget.docID);
    Stream<DatabaseEvent> event=reference.onValue;
    event.listen((event) {
      for(DataSnapshot snapshot in event.snapshot.children){
        CertificateModel model=CertificateModel(snapshot.key!, snapshot.value.toString());
        listData.add(model);
      }
      if(listData.isEmpty){
        imagesFound=false;
      }else{
        imagesFound=true;
      }
      setState(() {
        imagesLoading=false;

      });
    });

  }

  void deleteItem(int itemIndex) async {
    DatabaseReference ref=FirebaseDatabase.instance.ref("Certificates").child(widget.docID).child(listData.elementAt(itemIndex).id);
    await ref.remove().then((value) => {
      initState(),

    });
  }
}

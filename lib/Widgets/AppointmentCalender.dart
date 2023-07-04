import 'dart:convert';

import 'package:booking_calendar/booking_calendar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:lottie/lottie.dart';
import 'package:meddoc/Styles/applayout.dart';

import '../Models/BookingModel.dart';
import 'LoadingContainer.dart';

class AppointmentCalender extends StatefulWidget {
  String DoctorUID;
   AppointmentCalender({Key? key,required this.DoctorUID}) : super(key: key);

  @override
  State<AppointmentCalender> createState() => _AppointmentCalenderState();
}

class _AppointmentCalenderState extends State<AppointmentCalender> {
  String duration="";
  String endHr="";
  bool possible=true;
  String myName="";
  String docName="";
  String endMin="";
  String startHr="";
  String startMin="";
  String token="";
  List<BookingModel> bookedTimes=[];
  String docToken="";
  bool loading=true;
  String myID="";
  List<int> disabledDays=[];
  bool bookingcomplete=false;


  bool disableday=false;

  final now = DateTime.now();

  Stream<dynamic>? getBookingStreamMock(
      {required DateTime end, required DateTime start}) {

    DatabaseReference ref=FirebaseDatabase.instance.ref("books");
    Query query=ref.orderByChild("doctorID").equalTo(widget.DoctorUID);
    Stream stream=query.onValue;

    return stream;
  }



  Future<dynamic> uploadBookingMock(
      {required BookingService newBooking}) async {
    await Future.delayed(const Duration(seconds: 1));


    for(BookingModel s in bookedTimes){
      DateTime gotTimeStart=DateTime.parse(s.startTime);
      DateTime gotTimeEnd=DateTime.parse(s.lastTime);
      print("gotTimeStart: "+gotTimeStart.toString());
      print("bookingTimeStart: "+newBooking.bookingStart.toString());

      int daydiffer=newBooking.bookingStart.difference(gotTimeStart).inDays;
      print("daydiffer "+daydiffer.toString());
      if(daydiffer==0){
        int difference=newBooking.bookingStart.difference(gotTimeStart).inMinutes;
        int difference2=newBooking.bookingEnd.difference(gotTimeEnd).inMinutes;
        print("start Difference: "+difference.toString());
        print("end Difference: "+difference2.toString());
        if(difference<=40||difference2<=40){
          setState(() {
            possible=false;
          });
          print("false here");
        }
      }


    }

    if(!possible){
      showMessage("You have already appointment on same date and time or near it");
      converted.add(DateTimeRange(
          start: newBooking.bookingStart, end: newBooking.bookingEnd));
      converted.removeLast();
      setState(() {
        possible=true;
      });
    }else{
      DatabaseReference ref=FirebaseDatabase.instance.ref("bookings").push();

      converted.add(DateTimeRange(
          start: newBooking.bookingStart, end: newBooking.bookingEnd));
      Map<String,dynamic> map={
        'patientID':myID,
        'doctorID':widget.DoctorUID,
        'accepted':false,
        'completed':false,
        'start':newBooking.bookingStart.toString(),
        'end':newBooking.bookingEnd.toString(),
      };
      ref.update(map).whenComplete(() async => {
        await postJob(),
        showMessage("Booking Completed...")
      });
    }



  }

  List<DateTimeRange> converted = [];



  List<DateTimeRange> getResults({required dynamic streamResult}){



    return converted;

  }

  @override
  Widget build(BuildContext context) {
    final size=AppLayout.getSize(context);
    return bookingcomplete?Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Lottie.asset("animations/appointcomplete.json",repeat: false),
      ],
    ):Container(
      width: size.width,
      height: size.height,
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: loading?LoadingContainer():BookingCalendar(
            bookingService: BookingService(
                serviceName: 'Doctor Appointment',
                serviceDuration: int.parse(duration),
                bookingEnd: DateTime(now.year, now.month, now.day, int.parse(endHr), int.parse(endMin)),
                bookingStart: DateTime(now.year, now.month, now.day, int.parse(startHr), int.parse(startMin))),
            convertStreamResultToDateTimeRanges: getResults,
            getBookingStream: getBookingStreamMock,
            uploadBooking: uploadBookingMock,
            hideBreakTime: true,
            loadingWidget: const Text('Fetching data...'),
            uploadingWidget: const LoadingContainer(),
            locale: 'en_US',

            startingDayOfWeek: StartingDayOfWeek.monday,
            disabledDays: disableday?disabledDays:[],

          ),
        );
  }

  @override
  void initState() {
    getAppointData();
    getbooked();
    getDocName();
    getBookedTimes();

  }

  void getAppointData() {
    DatabaseReference myInfoRef=FirebaseDatabase.instance.ref("Users").child("Patients").child(FirebaseAuth.instance.currentUser!.uid);

    myInfoRef.once().then((value) => {

      myName=value.snapshot.child("name").value.toString(),
      token=value.snapshot.child("token").value.toString(),
    });






    myID=FirebaseAuth.instance.currentUser!.uid;
    DatabaseReference ref=FirebaseDatabase.instance.ref("Users").child("sessions").child(widget.DoctorUID);
    Stream<DatabaseEvent> event=ref.onValue;
    event.listen((event) {
      setState(() {
        duration=event.snapshot.child("duration").value.toString();
        endHr=event.snapshot.child("endHr").value.toString();
        endMin=event.snapshot.child("endMin").value.toString();
        startHr=event.snapshot.child("startHr").value.toString();
        startMin=event.snapshot.child("startMin").value.toString();


        loading=false;
      });
      if(event.snapshot.child("weekends").exists){
        var obj;
         obj=event.snapshot.child("weekends").value;
        for(var single in obj){
          disabledDays.add(int.parse(single.toString()));
        }
        setState(() {
          disableday=true;
        });

      }

    });
  }

  void getbooked() {
    DatabaseReference ref=FirebaseDatabase.instance.ref("bookings");
    Query query=ref.orderByChild("doctorID").equalTo(widget.DoctorUID);
    Stream<DatabaseEvent> stream=query.onValue;
    stream.listen((event) {
      for(DataSnapshot snapshot in event.snapshot.children){
        String start=snapshot.child("start").value.toString();
        String end=snapshot.child("end").value.toString();
        DateTime startDate=DateTime.parse(start);
        DateTime endDate=DateTime.parse(end);
        print(start);
        converted.add(DateTimeRange(start: startDate, end: endDate));
        if(snapshot.child("patientID").value.toString()==FirebaseAuth.instance.currentUser!.uid){

        }

      }

    });
  }

  postJob() async {

    sendNotification();
    postJobAgain();

    setState(() {
      bookingcomplete=true;
    });

    Future.delayed(Duration(seconds: 4)).whenComplete(() => {
      setState((){
    bookingcomplete=false;
      }),
    });




  }

  Future<void> sendNotification() async {
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
      'body':'From '+myName,
      'title':'New Appointment',
      },
      "notification": <String,dynamic>{
        'body':'From '+myName,
        'title':'New Appointment',
      "android_channel_id":'mainChannel',
      },
      'to': docToken,
      },
      )
    );
    }catch(e){
    print("Message Exception: "+e.toString());

    }

  }

  Future<void> makeHistorypatient() async {
    DatabaseReference reference=FirebaseDatabase.instance.ref("history").child(FirebaseAuth.instance.currentUser!.uid).push();
    Map<String,Object> map={
      'title':"Appointment",
      'description':"You have sent appointment request",
      'time':DateTime.now().toString(),
      'to':docName,
      'from':""
    };
   await reference.update(map);
  }

  void getDocName() {
    DatabaseReference myInfoRef=FirebaseDatabase.instance.ref("Users").child("Doctors").child(widget.DoctorUID);

    myInfoRef.once().then((value) => {

      docName=value.snapshot.child("name").value.toString(),
      docToken=value.snapshot.child("token").value.toString(),
    });
  }

  Future<void> makeHistoryDoctor() async {
    DatabaseReference reference=FirebaseDatabase.instance.ref("history").child(widget.DoctorUID).push();
    Map<String,Object> map={
      'title':"Appointment",
      'description':"You have received appointment request",
      'time':DateTime.now().toString(),
      'to':"",
      'from':myName,
    };
    await reference.update(map);
  }

  void getBookedTimes() {
    bookedTimes.clear();
    DatabaseReference ref=FirebaseDatabase.instance.ref("bookings");
    Query query=ref.orderByChild("patientID").equalTo(FirebaseAuth.instance.currentUser!.uid);
    Stream<DatabaseEvent> event=query.onValue;
    event.listen((event) { 
      if(event.snapshot.exists){
        for(DataSnapshot dataSnapshot in event.snapshot.children){
          BookingModel model=BookingModel(dataSnapshot.child("start").value.toString(), dataSnapshot.child("end").value.toString());
          bookedTimes.add(model);
        }



      }
      
    });


    

  }
  void showMessage(String s) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(s)),
    );
  }

  Future<void> postJobAgain() async {

    DatabaseReference ref=FirebaseDatabase.instance.ref("PersonalNotifications").child(widget.DoctorUID).push();
    Map<String,Object> map={
      'from':myName,
      'userID':FirebaseAuth.instance.currentUser!.uid,
      'notID':ref.key!,
      'time':DateTime.now().toString(),
      'type':"New Appointment",
    };

    await  ref.update(map);
    print("yaar:"+widget.DoctorUID);

    await   makeHistorypatient();
    await makeHistoryDoctor();
  }
}

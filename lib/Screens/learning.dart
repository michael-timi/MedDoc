import 'package:booking_calendar/booking_calendar.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class Learning extends StatefulWidget {
  const Learning({Key? key}) : super(key: key);

  @override
  State<Learning> createState() => _LearningState();
}

class _LearningState extends State<Learning> {
  final now = DateTime.now();

  Stream<dynamic>? getBookingStreamMock(
      {required DateTime end, required DateTime start}) {
    DatabaseReference ref=FirebaseDatabase.instance.ref("bookings");
    Stream<DatabaseEvent> stream=ref.onValue;

    return stream;
  }



  Future<dynamic> uploadBookingMock(
      {required BookingService newBooking}) async {
    await Future.delayed(const Duration(seconds: 1));

    DatabaseReference ref=FirebaseDatabase.instance.ref("bookings").push();

    converted.add(DateTimeRange(
        start: newBooking.bookingStart, end: newBooking.bookingEnd));
    Map<String,dynamic> map={
      'start':newBooking.bookingStart.toString(),
      'end':newBooking.bookingEnd.toString(),
    };
    ref.update(map);
    print('${newBooking.toJson()} has been uploaded');
  }

  List<DateTimeRange> converted = [];
  List<DateTimeRange> getResults({required dynamic streamResult}){

    DatabaseReference ref=FirebaseDatabase.instance.ref("bookings");
    Stream<DatabaseEvent> stream=ref.onValue;
    stream.listen((event) {
      for(DataSnapshot snapshot in event.snapshot.children){


        String start=snapshot.child("start").value.toString();
        String end=snapshot.child("end").value.toString();
        DateTime startDate=DateTime.parse(start);
        DateTime endDate=DateTime.parse(end);

        converted.add(DateTimeRange(start: startDate, end: endDate));

      }



    });
    return converted;
  }

  List<DateTimeRange> convertStreamResultMock({required dynamic streamResult}) {




    //here you can parse the streamresult and convert to [List<DateTimeRange>]
    ///take care this is only mock, so if you add today as disabledDays it will still be visible on the first load
    ///disabledDays will properly work with real data


    return converted;
  }

  List<DateTimeRange> generatePauseSlots() {
    return [
      DateTimeRange(
          start: DateTime(now.year, now.month, now.day, 12, 0),
          end: DateTime(now.year, now.month, now.day, 13, 0))
    ];
  }

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting('en_US,', null);
    return MaterialApp(
        title: 'Booking Calendar Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Scaffold(
          appBar: AppBar(
            title: const Text('Booking Calendar Demo'),
          ),
          body: Center(
            child: BookingCalendar(
              bookingService: BookingService(
              serviceName: 'Mock Service',
              serviceDuration: 30,
               bookingEnd: DateTime(now.year, now.month, now.day, 18, 0),
                  bookingStart: DateTime(now.year, now.month, now.day, 10, 0)),
              convertStreamResultToDateTimeRanges: getResults,
              getBookingStream: getBookingStreamMock,
              uploadBooking: uploadBookingMock,
              hideBreakTime: false,
              loadingWidget: const Text('Fetching data...'),
              uploadingWidget: const CircularProgressIndicator(),
              locale: 'en_US',
              startingDayOfWeek: StartingDayOfWeek.monday,
              disabledDays: const [6, 7],

            ),
          ),
        ));

}
}

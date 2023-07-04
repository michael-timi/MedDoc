import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_places_for_flutter/google_places_for_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:meddoc/Styles/applayout.dart';
import 'package:geocoder2/geocoder2.dart';

import '../Styles/styles.dart';
import '../Widgets/Smallicon.dart';
import '../Widgets/TitlewithNavigation.dart';

class MapsApiScreen extends StatefulWidget {
  bool doctor;
  String docID;
  String name;
   MapsApiScreen({Key? key,required this.docID,required this.doctor,required this.name}) : super(key: key);

  @override
  State<MapsApiScreen> createState() => _MapsApiScreenState();
}

class _MapsApiScreenState extends State<MapsApiScreen> {
  Completer<GoogleMapController> _controller = Completer();
  Set<Marker> alreadyMarkers = Set();
  Set<Marker> newMarkers = Set();
  bool firstRun=true;
  String title="Clinic Location";
  bool loading=false;
  late BitmapDescriptor myIcon;

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(15.0594, 120.6567),
    zoom: 15.4746,
  );


  @override
  void initState() {
    if(widget.doctor){
      requestPermissions();
    }

    getAlreadyMarkers();

    BitmapDescriptor.fromAssetImage(
        ImageConfiguration(size: Size(50, 50)), 'assets/images/mapmarker.png')
        .then((onValue) {
      myIcon = onValue;
    });

  }

  @override
  Widget build(BuildContext context)  {
    final size=AppLayout.getSize(context);
    return Scaffold(
      body: Column(
        children: [
          TitleNavigation(title: widget.doctor?"My Location":title,),
          Expanded(child: Stack(
            children: [
              GoogleMap(
                onTap: (LatLng){
                 if(widget.doctor){
                   newMarkers.clear();
                   setState(() {
                     newMarkers.add(
                       Marker(
                         markerId: MarkerId(LatLng.toString()),
                         draggable: true,
                         position: LatLng,
                         infoWindow: InfoWindow( //popup info
                           title: 'My Location',
                         ),
                       ),
                     );
                   });
                 }
                },

                mapType: MapType.normal,
                markers: alreadyMarkers.union(newMarkers),
                myLocationEnabled: widget.doctor?true:false,
                myLocationButtonEnabled: widget.doctor?true:false,
                initialCameraPosition: _kGooglePlex,
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                },
              ),
              newMarkers.length>0&&widget.doctor?Positioned(
                  top: size.height*0.75,
                  left: 20,
                  child: InkWell(
                    onTap: (){
                      setState(()   {

                        if(newMarkers.length>=1){
                          loading=true;
                          String longitude=newMarkers.elementAt(0).position.longitude.toString();
                          String lattitude=newMarkers.elementAt(0).position.latitude.toString();
                          Map<String,Object> map={
                            'longitude':longitude,
                            'lattitude':lattitude,
                          };
                          DatabaseReference ref=FirebaseDatabase.instance.ref("Locations").child(FirebaseAuth.instance.currentUser!.uid);
                          getLocation(longitude,lattitude);



                          ref.update(map).whenComplete(() => {

                            setState(() {
                          loading=false;
                          newMarkers.clear();
                            }),

                          });

                        }
                      });

                    },
                    child: Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                          color: Styles.primaryColor,
                          borderRadius: BorderRadius.circular(22)
                      ),
                      child: loading?CircularProgressIndicator(color: Colors.white,):Row(
                        children: [
                          SmallIcon(icon: Icons.check, bgColor: Styles.primaryColor, iconColor: Colors.white),
                          Text("Set My Location",style: GoogleFonts.montserrat(fontSize: 16,fontWeight: FontWeight.w400,color: Colors.white),),
                        ],
                      ),
                    ),
                  )
              ):SizedBox.shrink(),
             widget.doctor? Positioned(
                top: size.height*0.08,
                left: size.width*0.05,

                child: SearchGooglePlacesWidget(
                  apiKey: 'AIzaSyAOBrfLdICtoGlHvgxL7tnGPF9lXpX3jjM',
                  language: 'en',
                  location: LatLng(15.0594, 120.6567),
                  radius: 30000,
                  onSelected: (Place place) async {
                    final geolocation = await place.geolocation;
                    final GoogleMapController controller = await _controller.future;
                    controller.animateCamera(CameraUpdate.newLatLng(geolocation!.coordinates));
                    controller.animateCamera(CameraUpdate.newLatLngBounds(geolocation.bounds, 0,));
                    newMarkers.clear();
                    setState(() {
                      newMarkers.add(
                        Marker(
                          markerId: MarkerId(geolocation.coordinates.toString()),
                          draggable: true,
                          position: geolocation.coordinates,
                          infoWindow: InfoWindow( //popup info
                            title: 'My Location',
                          ),
                        ),
                      );
                    });




                  }, onSearch: (Place place) {

                },
                ),
              ):SizedBox.shrink(),

            ],
          ),)

        ],
      )

    );
  }

  Future<void> requestPermissions() async {
   if(await Permission.location.serviceStatus.isEnabled){
     print("Location Services Acquired");
     var status=await Permission.location.status;
     if(status.isGranted){

       print("Location Permissions Granted");
     }else if(status.isPermanentlyDenied){
      openAppSettings();
     }
     else{
       Map<Permission,PermissionStatus> status=await [Permission.location,].request();
     }
   }else{
     print("Location Services Not Supported");

   }
   setState(() {

   });

  }

  void getAlreadyMarkers() {
    DatabaseReference ref=FirebaseDatabase.instance.ref("Locations").child(widget.docID);
    Stream<DatabaseEvent> event=ref.onValue;
    event.listen((event) async {
      if(event.snapshot.exists){
        alreadyMarkers.clear();
        String longitude=event.snapshot.child("longitude").value.toString();
        String lattitude=event.snapshot.child("lattitude").value.toString();

        LatLng newLong=LatLng(double.parse(lattitude), double.parse(longitude));
        alreadyMarkers.add(
          Marker(
              markerId: MarkerId(newLong.toString()),
              position: newLong,
            infoWindow: InfoWindow( //popup info
              title: widget.name,
            ),
            icon:myIcon,
          )
        );

        if(!widget.doctor&&alreadyMarkers.length>0){
          final GoogleMapController controller = await _controller.future;
          controller.animateCamera(CameraUpdate.newLatLng(newLong));
        }


        setState(()  {

        });
      }else{
        setState(() {
          title="No Location Added Yet...!";
        });
      }
    });
    
    
    
  }
  void showMessage(String s) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(s)),
    );
  }

  Future<void> getLocation(String longitude, String lattitude) async {
    GeoData data = await Geocoder2.getDataFromCoordinates(
        latitude: double.parse(lattitude),
        longitude: double.parse(longitude),
        googleMapApiKey: "AIzaSyAOBrfLdICtoGlHvgxL7tnGPF9lXpX3jjM");
    DatabaseReference profile=FirebaseDatabase.instance.ref("Users").child("Doctors").child(FirebaseAuth.instance.currentUser!.uid);
    Map<String,Object> map={
      'hospitalAddress':data.address,
    };
    profile.update(map);


  }

}

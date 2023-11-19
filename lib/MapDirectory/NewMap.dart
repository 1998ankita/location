import 'dart:async';

import 'package:flutter/material.dart';
// import 'package:geocoding/geocoding.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_routes/google_maps_routes.dart';
import 'package:locat/MapDirectory/packages/lib/widget/search_widget.dart';
import 'package:locat/MapDirectory/packages/location.dart';

import 'package:location/location.dart';
class NewMap extends StatefulWidget {
  const NewMap({super.key});

  @override
  State<NewMap> createState() => _NewMapState();
}

class _NewMapState extends State<NewMap> {
  final Completer<GoogleMapController> _controller=Completer();
  static  LatLng sourceLocation=LatLng(currentLat!, currentLong!);
  static  LatLng destinationLocation=LatLng(22.0323,74.8996);
  List<LatLng> polylineCoordinates=[];
  LocationData? currentLocation;
  List<LatLng> points = [];
  List addAddress=[];
  MapsRoutes route = new MapsRoutes();
  Set<Marker> _markers = {};
  GoogleMapController? mapController;
  static late List placemarkaddress;
  TextEditingController searchlocationController =TextEditingController();
  TextEditingController addressController =TextEditingController();
  // getPolyline()async{
  //   PolylinePoints polylinePoints = PolylinePoints();
  //   PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
  //       googleApiKey,
  //       PointLatLng(sourceLocation.latitude, sourceLocation.longitude),
  //       PointLatLng(destinationLocation.latitude, destinationLocation.longitude),
  //       );
  //   if(result.points.isNotEmpty){
  //     result.points.forEach((element) { (PointLatLng point) =>
  //         polylineCoordinates.add(LatLng(point.latitude, point.longitude));});
  //     setState(() {
  //
  //     });
  //   }
  //   setState(() {
  //
  //   });
  // }
  getCurrentLocation()async{
  Location location=Location();
    location.getLocation().then((location) {
      currentLocation = location;
      print("location---------------$location");
    });
    location.onLocationChanged.listen((newloc) {
      currentLocation=newloc;
      if(points.length>0){
        points![0].latitude!=currentLocation!.latitude;
        points![0].longitude!=currentLocation!.longitude;
       setState(() {

       });
        // createPloyline();
      }

      setState(() {

      });
    });
  }
  createPloyline() async {
    print("createPloyline---------------------");
    if (points.length >= 2) {
      print("createPloyline  1");
      route = new MapsRoutes();
      await route.drawRoute(points, 'Test routes', Colors.blue, googleApiKey,
          travelMode: TravelModes.driving);
      // _markers.add(Marker(
      //     markerId: const MarkerId('SomeId'),
      //     position: LatLng(points.first.latitude, points.first.longitude),
      //     infoWindow: const InfoWindow(title: 'The title of the marker')));
      // _markers.add(Marker(
      //     markerId: const MarkerId('SomeId2'),
      //     position: LatLng(points.last.latitude, points.last.longitude),
      //     infoWindow: const InfoWindow(title: 'The title of the marker')));

      setState(() {

      });
    } else {
      print("createPloyline  else");
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    // getPolyline();
    // Timer.periodic(const Duration(seconds: 1), (timer) {
    //   print(timer.tick);
      getCurrentLocation();

    // });

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:currentLocation==null?Center(child: CircularProgressIndicator(),): Stack(
        children: [
          GoogleMap(
        mapToolbarEnabled: false,
            initialCameraPosition: CameraPosition(
            target: LatLng(currentLocation!.latitude!,currentLocation!.longitude!),
            zoom: 13.5
          ),
          markers: _markers,
          // markers: {
          //   Marker(markerId: MarkerId("route"),position: LatLng(currentLocation!.latitude!,currentLocation!.longitude!)),
          //   // Marker(markerId: MarkerId("source"),position: sourceLocation),
          //   Marker(markerId: MarkerId("destination"),position: destinationLocation),
          // },
            onMapCreated: (mapController){
            _controller.complete(mapController);
            },
            polylines: route.routes,

          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width - 120,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30)),
                        padding: EdgeInsets.only(
                            left: 0, right: 0, top: 0, bottom: 0),

                      ),
                    ),
                    InkWell(
                      onTap: () {
                      },
                      child: SizedBox(
                          height: 50,
                          child: Container(
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8)
                              ),
                              child: Icon(Icons.close))),
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(top: 20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.white),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text("From",style: TextStyle(color: Colors.grey, fontSize: 12),),
                      ),
                      // SizedBox(height: 10,),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text("${currentAddress}",style: TextStyle(color: Colors.black,
                            fontSize: 14),),
                      ),
                      Divider(thickness: 1,color: Colors.grey,),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text("To",style: TextStyle(color: Colors.grey,
                            fontSize: 12),),
                      ),
                      SearchLocation(

                        // darkMode: true,
                        controller: searchlocationController,
                        // key: MyGlobalKeys.searchLocationKey,
                        apiKey:googleApiKey,
                        onSelected: (value) async {
                          selectedCurrentLat=0;
                          selectedCurrentLong=0;
                          var temp = await value.geolocation;
                          if (temp != null)
                            print('ghehehedhdhdfbn' +
                                temp.coordinates.longitude.toString());
                          print('ghehehedhdhdfbn123');
                          print('ghehehedhdhdfbn456');
                          if (temp != null) {
                            dynamic l = temp.coordinates;

                            print('ghehehedhdhdfbn789');
                            String p = value.placeId;
                            selectedCurrentLat = l.latitude;
                            selectedCurrentLong = l.longitude;
                            points = [];
                            points.add(LatLng(currentLat, currentLong));
                            points.add(LatLng(selectedCurrentLat, selectedCurrentLong));
                            // points.add(LatLng(22.7196, 75.8577));

                            createPloyline();
                            // searchlocationController.text=await getCurrentAddressbylatlong(selectedCurrentLat, selectedCurrentLong);

                            searchlocationController.text =
                                value.description;
                            selectedAddress = value.description;
                            destinationLocation=LatLng(selectedCurrentLat, selectedCurrentLong);
                            setState(() {

                            });
                          }

                          LatLng newlatlang = LatLng(selectedCurrentLat, selectedCurrentLong);
                          print('current--lat--long---${newlatlang}');
                          mapController?.animateCamera(
                              CameraUpdate.newCameraPosition(CameraPosition(
                                  target: newlatlang, zoom: 12)
                                //17 is new zoom level
                              ));
                          _markers.clear();
                          for(int i=0;i<points.length;i++){
                            print("points------${points[i].latitude}  ");
                            _markers.add(Marker(
                                markerId: MarkerId('${_markers.length + 1}'),
                                position: LatLng(points[i].latitude, points[i].longitude),
                                // position: LatLng(latlng.latitude,  latlng.longitude ),
                                draggable: true,
                                onDrag: (value) async {
                                  // latlng = value;
                                  // placemarks = await placemarkFromCoordinates(latlng.latitude, latlng.longitude);
                                }));
                          }
                          // _markers.add(Marker(
                          //     markerId: MarkerId('${_markers.length + 1}'),
                          //     position: LatLng(selectedCurrentLat, selectedCurrentLong),
                          //     // position: LatLng(latlng.latitude,  latlng.longitude ),
                          //     draggable: true,
                          //     onDrag: (value) async {
                          //       // latlng = value;
                          //       // placemarks = await placemarkFromCoordinates(latlng.latitude, latlng.longitude);
                          //     }));
                          // setState(() {});
                          // setState(() {});
                        },
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(padding: EdgeInsets.all(8),
          child: TextButton(child: Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(12)
            ),
              child: Text("Add Stop",style: TextStyle(color: Colors.white),)),onPressed: ()async{
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text('Add Stop'),
                    content:  Container(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SearchLocation(

                            // darkMode: true,
                            controller: addressController,
                            // key: MyGlobalKeys.searchLocationKey,
                            apiKey:googleApiKey,
                            onSelected: (value) async {
                              var temp = await value.geolocation;
                              if (temp != null)
                                print('ghehehedhdhdfbn' +
                                    temp.coordinates.longitude.toString());
                              print('ghehehedhdhdfbn123');
                              print('ghehehedhdhdfbn456');
                              if (temp != null) {
                                dynamic l = temp.coordinates;

                                // print('ghehehedhdhdfbn789');
                                // String p = value.placeId;
                                // selectedCurrentLat = l.latitude;
                                // selectedCurrentLong = l.longitude;
                                // points = [];
                                // points.add(LatLng(currentLat, currentLong));
                                points.add(LatLng(l.latitude, l.longitude));
                                // points.add(LatLng(22.7196, 75.8577));

                                createPloyline();
                                // searchlocationController.text=await getCurrentAddressbylatlong(selectedCurrentLat, selectedCurrentLong);

                                addressController.text =
                                    value.description;
                                selectedAddress = value.description;
                                addAddress.add(addressController.text);
                                // destinationLocation=LatLng(selectedCurrentLat, selectedCurrentLong);
                                setState(() {

                                });
                              }

                              LatLng newlatlang = LatLng(selectedCurrentLat, selectedCurrentLong);
                              print('current--lat--long---${newlatlang}');
                              mapController?.animateCamera(
                                  CameraUpdate.newCameraPosition(CameraPosition(
                                      target: newlatlang, zoom: 12)
                                    //17 is new zoom level
                                  ));
                              _markers.clear();
                              for(int i=0;i<points.length;i++){
                                print("points------${points[i].latitude}  ");
                                _markers.add(Marker(
                                    markerId: MarkerId('${_markers.length + 1}'),
                                    position: LatLng(points[i].latitude, points[i].longitude),
                                    // position: LatLng(latlng.latitude,  latlng.longitude ),
                                    draggable: true,
                                    onDrag: (value) async {
                                      // latlng = value;
                                      // placemarks = await placemarkFromCoordinates(latlng.latitude, latlng.longitude);
                                    }));
                              }
                              addressController.text='';
                              Navigator.pop(context);
                              // _markers.add(Marker(
                              //     markerId: MarkerId('${_markers.length + 1}'),
                              //     position: LatLng(selectedCurrentLat, selectedCurrentLong),
                              //     // position: LatLng(latlng.latitude,  latlng.longitude ),
                              //     draggable: true,
                              //     onDrag: (value) async {
                              //       // latlng = value;
                              //       // placemarks = await placemarkFromCoordinates(latlng.latitude, latlng.longitude);
                              //     }));
                              // setState(() {});
                              // setState(() {});
                            },
                          ),
                          if(addAddress.length>0)
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Added Stop"),
                          ),
                          if(addAddress.length>0)
                          for(int i=0;i<addAddress.length;i++)
                          Padding(padding: EdgeInsets.all(16),child: Text("${addAddress[i]}"),)
                        ],
                      ),
                    ),
                  );
                });
          },),)
        ],
      ),
    );
  }
}

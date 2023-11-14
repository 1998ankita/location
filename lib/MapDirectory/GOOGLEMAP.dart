// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:google_maps_routes/google_maps_routes.dart';
// import 'package:locat/MapDirectory/packages/lib/widget/search_widget.dart';
//
//
//
// class MapSample extends StatefulWidget {
//   final bool? isSearch;
//   MapSample({Key? key,  this.isSearch}) : super(key: key);
//   @override
//   State<MapSample> createState() => MapSampleState();
// }
//
// class MapSampleState extends State<MapSample> {
//   initState() {
//       get();
//     getmap();
//   }
//    get()async{
//     // await getCurrentLocation();
//     // print("123456789-----------${currentlat} ${currentlong}") ;
//      _markers.add(Marker(
//          markerId: MarkerId('${_markers.length + 1}'),
//          position: LatLng(currentlat, currentlong),
//          // position: LatLng(latlng.latitude,  latlng.longitude ),
//          draggable: true,
//          onDrag: (value) async {
//            // latlng = value;
//            // placemarks = await placemarkFromCoordinates(latlng.latitude, latlng.longitude);
//          }));
//     // showLocation = LatLng(currentLat, currentLong);
//      setState(() {
//
//      });
//    }
//   GoogleMapController? mapController; //contrller for Google map
//   LatLng startLocation = LatLng(22.7196, 75.8577);
//   // String? lat;
//   // String? long;
//   static late double lat;
//   static late double long;
//   static late double currentlat;
//   static late double currentlong;
//   static late List placemarkaddress;
//
//   getmap() async {
//     Position position = await _getGeoLocationPosition();
//     print('position--------${position},');
//     currentlat = position.latitude;
//     currentlong = position.longitude;
//     print('position--------${position.latitude},${position.longitude}');
//     print('currentlatlong--------${currentlat},${currentlong}');
//   }
//
//   String location = 'Null, Press Button';
//   String AAddress = '';
//   List<dynamic> Addresslist = [];
//   List<dynamic> placemarks = [];
//   String Address = '';
//   String city = '';
//   String state = '';
//   String country = '';
//   String zip = '';
//   String lng = '';
//   String latt = '';
//   Set<Marker> _markers = {};
//   TextEditingController codeController = TextEditingController();
//   TextEditingController firstnameController = TextEditingController();
//   TextEditingController lastnameController = TextEditingController();
//   TextEditingController emailController = TextEditingController();
//   TextEditingController passwordController = TextEditingController();
//   TextEditingController addressController = TextEditingController();
//   TextEditingController apartmentController = TextEditingController();
//   TextEditingController cityController = TextEditingController();
//   TextEditingController stateController = TextEditingController();
//   TextEditingController countryController = TextEditingController();
//   TextEditingController zipcodeController = TextEditingController();
//   TextEditingController specialController = TextEditingController();
//   TextEditingController phonenoController = TextEditingController();
//   TextEditingController _textEditingController = TextEditingController();
//   TextEditingController searchlocationController = TextEditingController();
//
//   Future<Position> _getGeoLocationPosition() async {
//     bool serviceEnabled;
//     LocationPermission permission;
//
//     // Test if location services are enabled.
//     serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!serviceEnabled) {
//       // Location services are not enabled don't continue
//       // accessing the position and request users of the
//       // App to enable the location services.
//       await Geolocator.openLocationSettings();
//       return Future.error('Location services are disabled.');
//     }
//
//     permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       if (permission == LocationPermission.denied) {
//         // Permissions are denied, next time you could try
//         // requesting permissions again (this is also where
//         // Android's shouldShowRequestPermissionRationale
//         // returned true. According to Android guidelines
//         // your App should show an explanatory UI now.
//         return Future.error('Location permissions are denied');
//       }
//     }
//
//     if (permission == LocationPermission.deniedForever) {
//       // Permissions are denied forever, handle appropriately.
//       return Future.error(
//           'Location permissions are permanently denied, we cannot request permissions.');
//     }
//
//     // When we reach here, permissions are granted and we can
//     // continue accessing the position of the device.
//     return await Geolocator.getCurrentPosition(
//         desiredAccuracy: LocationAccuracy.high);
//   }
//
//   Future<void> GetAddressFromLatLong(Position position) async {
//     List<Placemark> placemarks =
//         await placemarkFromCoordinates(position.latitude, position.longitude);
//     print('placemarks-----${placemarks}');
//     placemarkaddress = placemarks;
//     print('placemarkaddress-----${placemarkaddress}');
//     Placemark place = placemarks[0];
//     print('placemarks0-----${placemarks[0]}');
//
//     AAddress =
//         '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';
//     cityController.text = place.locality.toString();
//     countryController.text = place.country.toString();
//     stateController.text = place.administrativeArea.toString();
//     zipcodeController.text = place.postalCode.toString();
//     // "city": cityController.text,
//     // "state": stateController.text,
//     // "country":countryController.text,
//     // "pincode":zipcodeController.text,
//
//     print('Currentaddress------${AAddress}');
//     setState(() {});
//   }
//
//   Completer<GoogleMapController> _controller = Completer();
//
//   static final CameraPosition _kGooglePlex = CameraPosition(
//     target: LatLng(37.42796133580664, -122.085749655962),
//     zoom: 14.4746,
//   );
//
//   static final CameraPosition _kLake = CameraPosition(
//       bearing: 192.8334901395799,
//       target: LatLng(currentlat, currentlong),
//       tilt: 59.440717697143555,
//       zoom: 19.151926040649414);
//   int value = 0;
//   List<LatLng> points = [];
//   MapsRoutes route = new MapsRoutes();
//   DistanceCalculator distanceCalculator = new DistanceCalculator();
//   createPloyline()async{
//     print("createPloyline---------------------") ;
//     if (points.length >= 2) {
//       print("createPloyline  1") ;
//
//       await route.drawRoute(
//           points,
//           'Test routes',
//           Colors.blue,
//           "AIzaSyAHtsdxULNcLUBccEx2FZa4tMSuw1kgoso",
//           travelMode: TravelModes.driving);
//       _markers.add(Marker(
//           markerId: const MarkerId('SomeId'),
//           position: LatLng(
//               points.first.latitude,
//               points.first.longitude),
//           infoWindow: const InfoWindow(
//               title:
//               'The title of the marker')));
//       _markers.add(Marker(
//           markerId: const MarkerId('SomeId2'),
//           position: LatLng(points.last.latitude,
//               points.last.longitude),
//           infoWindow: const InfoWindow(
//               title:
//               'The title of the marker')));
//
//
//       setState(() {
//         var totalDistance1 = distanceCalculator.calculateRouteDistance(points,
//             decimals: 1);
//
//
//       });
//     }
//     else{
//       print("createPloyline  else") ;
//
//     }
//   }
//   LatLng showLocation = LatLng(22.7196, 75.8577);
//   @override
//   void dispose() {
//     // TODO: implement dispose
//     mapController?.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       floatingActionButton: FloatingActionButton(
//         child: Icon(
//           Icons.my_location_outlined,
//         ),
//         backgroundColor: Colors.red,
//         onPressed: () async {
//           print('youtappedoncurrrentlocationbutton--');
//           LatLng newlatlang = LatLng(currentlat, currentlong);
//           // LatLng newlatlang = LatLng(lat,long);
//           print('current--lat--long---${newlatlang}');
//           mapController?.animateCamera(CameraUpdate.newCameraPosition(
//               CameraPosition(target: newlatlang, zoom: 17)
//               //17 is new zoom level
//               ));
//           Position position = await _getGeoLocationPosition();
//           location = 'Lat: ${position.latitude} , Long: ${position.longitude}';
//           print('thislatlonggoneonbillingpage---${location}');
//           lat = position.latitude;
//           long = position.longitude;
//
//           await GetAddressFromLatLong(position);
//           print('Currentaddress2------${AAddress}');
//           searchlocationController.text = AAddress;
//           print('Currentaddress3------${searchlocationController.text}');
//           // await MyGlobalKeys.searchLocationKey.currentState?.updateTextField(AAddress);
//           _markers.clear();
//           _markers.add(Marker(
//               markerId: MarkerId('${_markers.length + 1}'),
//               position: LatLng(currentlat, currentlong),
//               // position: LatLng(latlng.latitude,  latlng.longitude ),
//               draggable: true,
//               onDrag: (value) async {
//                 // latlng = value;
//                 // placemarks = await placemarkFromCoordinates(latlng.latitude, latlng.longitude);
//               }));
//           setState(() {});
//
//           // print('placemarkaddress2-----${placemarkaddress}');
//           //
//           // Navigator.pop(context,placemarkaddress);
//         },
//       ),
//       body: Container(
//         child: Stack(
//           // alignment: Alignment.center,
//           children: [
//             // if(currentlat!=null)
//             GoogleMap(
//
//                 polylines: route.routes,
//                 mapType: MapType.normal,
//                 initialCameraPosition: CameraPosition(
//                   target: showLocation, //initial position
//                   zoom: 6, //initial zoom level
//                 ),
//                 onMapCreated: (GoogleMapController controller) {
//                   _controller.complete(controller);
//                   setState(() {
//                     mapController = controller;
//                   });
//                 },
//                 markers: _markers,
//                 onTap: (LatLng latlng) async {
//                   List<Placemark> placemarks = await placemarkFromCoordinates(
//                       latlng.latitude, latlng.longitude);
//                   placemarkaddress = placemarks;
//                   // String address ='';
//                   print('placemarks----------${placemarks}');
//                   var address =
//                       '${placemarks[0].street.toString()},${placemarks[0].name.toString()},${placemarks[0].locality.toString()},${placemarks[0].country.toString()},${placemarks[0].postalCode.toString()}';
//                   print('entireaddress----${address}');
//                   print(
//                       'placemarkscountry----------${placemarks[0].country.toString()},');
//                   print(
//                       'placemarkscountry----------${placemarks[0].country.toString()}');
//                   print('tappedlatitude----------${latlng.latitude}');
//                   print('tappedlongitude----------${latlng.longitude}');
//
//                   // addressController.text = value.description;
//                   // addressController.text= address.toString();
//                   lat = latlng.latitude;
//                   long = latlng.longitude;
//                   searchlocationController.text = address.toString();
//                   countryController.text = placemarks[0].country.toString();
//                   stateController.text =
//                       placemarks[0].administrativeArea.toString();
//                   cityController.text = placemarks[0].locality.toString();
//                   zipcodeController.text = placemarks[0].postalCode.toString();
//                   // MyGlobalKeys.searchLocationKey.currentState?.updateTextField(address);
//                   _markers.clear();
//                   _markers.add(Marker(
//                       markerId: MarkerId('${_markers.length + 1}'),
//                       // position: LatLng(currentlat,  currentlong ),
//                       position: LatLng(latlng.latitude, latlng.longitude),
//                       draggable: true,
//                       onDrag: (value) async {
//                         latlng = value;
//                         placemarks = await placemarkFromCoordinates(
//                             latlng.latitude, latlng.longitude);
//                         var address =
//                             '${placemarks[0].street.toString()},${placemarks[0].name.toString()},${placemarks[0].locality.toString()},${placemarks[0].country.toString()},${placemarks[0].postalCode.toString()}';
//                         // MyGlobalKeys.searchLocationKey.currentState?.updateTextField(address);
//                       }));
//                   setState(() {});
//                 }),
//             Positioned(
//               bottom: 20,
//               left: 20,
//               child: ElevatedButton(
//                 onPressed: () async {
//                   print('AddAddresstaped----');
//                   // print('placemarkaddress2-----${placemarkaddress}');
//                   //  placemarkaddress[0]['searchfield']=searchlocationController.text;
//                   Map<String, dynamic> address1 = {
//                     "address": searchlocationController.text,
//                     "lat": lat.toString(),
//                     "lon": long.toString(),
//                     "city": cityController.text,
//                     "state": stateController.text,
//                     "country": countryController.text,
//                     "pincode": zipcodeController.text,
//                     // "user_id": await getCurrentUserId()
//                   };
//
//                   print('address1-----${address1}');
//                   Navigator.pop(context, address1);
//                 },
//                 child: Text('Done'),
//                 style: ElevatedButton.styleFrom(
//                   shape: StadiumBorder(),
//                   primary: Colors.red,
//                 ),
//               ),
//             ),
//             if(widget.isSearch!)
//             Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//
//                   Padding(
//                     padding: const EdgeInsets.all(0.0),
//                     child: Container(
//                       // margin: EdgeInsets.only(top: 45),
//
//                       // height: 48,
//                       width: MediaQuery.of(context).size.width-120,
//                       // margin: EdgeInsets.symmetric(
//                       //     horizontal:16 ,vertical:8 ),
//                       decoration: BoxDecoration(
//                           color: Colors.white,
//                           border: Border.all(color: Colors.red),
//                           borderRadius: BorderRadius.circular(30)),
//                       padding:
//                           EdgeInsets.only(left: 0, right: 0, top: 0, bottom: 0),
//                       child: SearchLocation(
//                         controller: searchlocationController,
//                         // key: MyGlobalKeys.searchLocationKey,
//                         apiKey: "AIzaSyAHtsdxULNcLUBccEx2FZa4tMSuw1kgoso",
//                         onSelected: (value) async {
//                           var temp = await value.geolocation;
//                           if (temp != null)
//                             print('ghehehedhdhdfbn' +
//                                 temp.coordinates.longitude.toString());
//                           print('ghehehedhdhdfbn123');
//                           // addressController.text = value.description;
//                           print('addressController-----${addressController.text}');
//                           print('ghehehedhdhdfbn456');
//                           if (temp != null) {
//                             dynamic l = temp.coordinates;
//
//                             print('ghehehedhdhdfbn789');
//                             String p = value.placeId;
//                             print("value from country   ${temp!.coordinates}");
//                             print('ghehehedhdhdfbn2');
//
//                             print("value from country   ${l.longitude}");
//                             print("value from place   ${p.toString()}");
//                             // print("value from state   }");
//                             print("value from city   ${value.description}");
//                             // print("lat   ${l.latitude.toString()}");
//                             // print("long   ${l.longitude.toString()}");
//                             lat = l.latitude;
//                             long = l.longitude;
//                             // selectedCurrentLat=lat;
//                             // selectedCurrentLong=long;
//                             points=[];
//                             points.add(LatLng(22.7196, 75.8577));
//                             points.add(LatLng(lat,long));
//                             createPloyline();
//                             print("latlocal   ${lat}");
//                             print("longlocal   ${long}");
//                             List<Placemark> placemarks =
//                                 await placemarkFromCoordinates(
//                                     l.latitude, l.longitude);
//                             placemarkaddress = placemarks;
//                             print("placemarksmapsearch   ${placemarks}");
//
//                             print("placemarks   ${placemarks[0].administrativeArea}");
//                             searchlocationController.text = value.description;
//                             // selectedAddress = value.description;
//                             countryController.text = placemarks[0].country.toString();
//                             stateController.text =
//                                 placemarks[0].administrativeArea.toString();
//                             cityController.text = placemarks[0].locality.toString();
//                             zipcodeController.text =
//                                 placemarks[0].postalCode.toString();
//                           }
//
//                           LatLng newlatlang = LatLng(lat, long);
//                           print('current--lat--long---${newlatlang}');
//                           mapController?.animateCamera(CameraUpdate.newCameraPosition(
//                               CameraPosition(target: newlatlang, zoom: 17)
//                               //17 is new zoom level
//                               ));
//                           _markers.clear();
//                           _markers.add(Marker(
//                               markerId: MarkerId('${_markers.length + 1}'),
//                               position: LatLng(lat, long),
//                               // position: LatLng(latlng.latitude,  latlng.longitude ),
//                               draggable: true,
//                               onDrag: (value) async {
//                                 // latlng = value;
//                                 // placemarks = await placemarkFromCoordinates(latlng.latitude, latlng.longitude);
//                               }));
//                           setState(() {});
//                         },
//                       ),
//                     ),
//                   ),
//
//                 ],
//               ),
//             ),
//           ],
//         ),
//
//
//       ),
//
//     );
//   }
//
// }

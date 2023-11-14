import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';


double currentLat = 0;
double currentLong = 0;
double selectedCurrentLat = 0;
double selectedCurrentLong = 0;
Position? _currentPosition;
String currentAddress='';
String selectedAddress="";

String googleApiKey='AIzaSyAHtsdxULNcLUBccEx2FZa4tMSuw1kgoso';
// String ggogleApiKey='AIzaSyDelK1ssiGk5L1dF3YUuieDKRXe-DHDO8s';

Future<bool> handleLocationPermission(BuildContext context) async {
  bool serviceEnabled;
  LocationPermission permission;

  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    print("!serviceEnabled");
    // getCurrentLatLong();
    return false;
  }
  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Location permissions are denied')));
      return false;
    }
  }
  if (permission == LocationPermission.deniedForever) {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
            'Location permissions are permanently denied, we cannot request permissions.')));
    return false;
  }
  return true;
}

Future<bool> requestPermission() async {
  LocationPermission permission = await Geolocator.requestPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return false;
    }
  }
  return true;
}

Future<Position> getCurrentLocation() async {
  print("getCurrentLocation called-------");
  bool isPermissionGranted = await requestPermission();
  print(isPermissionGranted);
  if (isPermissionGranted) {
    // setState(() async{
    _currentPosition = await Geolocator.getCurrentPosition();
    print("fhjdgrsfjkd"+ '${_currentPosition!.latitude}');
    currentLat = _currentPosition!.latitude;
    currentLong = _currentPosition!.longitude;
    print("object");
    await getCurrentAddress();
    // });
    return _currentPosition!;
  } else {
    throw requestPermission();
  }
}

// getCurrentLatLong() async {
//   var position = await Geolocator.getCurrentPosition();
//   print('position--------${position.latitude}');
//   currentLat = position.latitude;
//   currentLong = position.longitude;
//   print('currentLat--------${currentLong}');
// }

//
// double lat1 = 37.7749; // latitude of point 1
// double lon1 = -122.4194; // longitude of point 1
// double lat2 = 34.0522; // latitude of point 2
// double lon2 = -118.2437; // longitude of point 2
//
getDistance(lat1, lon1, lat2, lon2) async {
  double distanceInMeters = await Geolocator.distanceBetween(
      double.parse(lat1.toString()),
      double.parse(lon1.toString()),
      double.parse(lat2.toString()),
      double.parse(lon2.toString()));
  double distanceInKilometers = distanceInMeters / 1000;
  print(
      "distanceInKilometers.round().toString()---------${distanceInKilometers.round().toString()}");
  var distance = await distanceInKilometers.round().toString();
  return distance;
}
getCurrentAddress()async{
  // await getCurrentLocation();
  List<Placemark> placemarks =
  await placemarkFromCoordinates(
      currentLat,currentLong);
  var placemarkaddress = placemarks;
  print("placemarksmapsearch   ${placemarks}");
  print("placemarks   ${placemarks[0].administrativeArea}");
  currentAddress='${placemarks[0].street??""}, ${placemarks[0].name??""} '
      '${placemarks[0].subLocality??""} ,${placemarks[0].locality??""}';
  print(currentAddress);
  return currentAddress;
  //
  // countryController.text = placemarks[0].country.toString();
  // stateController.text =
  //     placemarks[0].administrativeArea.toString();
  // cityController.text = placemarks[0].locality.toString();
  // zipcodeController.text =
  //     placemarks[0].postalCode.toString();

}
getCurrentAddressbylatlong(lat,long)async{
  // await getCurrentLocation();
  List<Placemark> placemarks =
  await placemarkFromCoordinates(
      lat,long);
  var placemarkaddress = placemarks;
  print("placemarksmapsearch   ${placemarks}");
  print("placemarks   ${placemarks[0].administrativeArea}");
  // currentAddress='${placemarks[0].street??""}, ${placemarks[0].name??""} '
  //     '${placemarks[0].subLocality??""} ,${placemarks[0].locality??""}';
  // print(currentAddress);
  return '${placemarks[0].street??""}, ${placemarks[0].name??""} '
      '${placemarks[0].subLocality??""} ,${placemarks[0].locality??""}';;
  //
  // countryController.text = placemarks[0].country.toString();
  // stateController.text =
  //     placemarks[0].administrativeArea.toString();
  // cityController.text = placemarks[0].locality.toString();
  // zipcodeController.text =
  //     placemarks[0].postalCode.toString();

}

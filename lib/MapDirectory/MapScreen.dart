import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_routes/google_maps_routes.dart';
import 'package:locat/MapDirectory/packages/lib/widget/search_widget.dart';
import 'package:locat/MapDirectory/packages/location.dart';


class MapScreen extends StatefulWidget {
  final bool? isSearch;
  final Function()? onNext;
  MapScreen({Key? key, this.isSearch, this.onNext}) : super(key: key);
  @override
  State<MapScreen> createState() => MapScreenState();
}
final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
class MapScreenState extends State<MapScreen> {
  initState() {

    get();
    getmap();
  }

  get() async {
    await getCurrentLocation();
     print("123456789-----------${currentlat} ${currentlong}") ;
    _markers.add(Marker(
        markerId: MarkerId('${_markers.length + 1}'),
        position: LatLng(currentlat, currentlong),
        // position: LatLng(latlng.latitude,  latlng.longitude ),
        draggable: true,
        onDrag: (value) async {
          // latlng = value;
          // placemarks = await placemarkFromCoordinates(latlng.latitude, latlng.longitude);
        }));
     showLocation = LatLng(currentLat, currentLong);
    setState(() {

    });
  }

  GoogleMapController? mapController; //contrller for Google map
  LatLng startLocation = LatLng(currentLat, currentLong);
  // String? lat;
  // String? long;
  static late double lat;
  static late double long;
  static late double currentlat;
  static late double currentlong;
  static late List placemarkaddress;

  getmap() async {
    Position position = await _getGeoLocationPosition();
    print('position--------${position},');
    currentlat = position.latitude;
    currentlong = position.longitude;
    print('position--------${position.latitude},${position.longitude}');
    print('currentlatlong--------${currentlat},${currentlong}');
    showLocation = LatLng(currentlat, currentlong);

  }

  String location = 'Null, Press Button';
  String AAddress = '';
  List<dynamic> Addresslist = [];
  List<dynamic> placemarks = [];
  String Address = '';
  String city = '';
  String state = '';
  String country = '';
  String zip = '';
  String lng = '';
  String latt = '';
  Set<Marker> _markers = {};
  TextEditingController codeController = TextEditingController();
  TextEditingController firstnameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController apartmentController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController zipcodeController = TextEditingController();
  TextEditingController specialController = TextEditingController();
  TextEditingController phonenoController = TextEditingController();
  TextEditingController _textEditingController = TextEditingController();
  TextEditingController searchlocationController = TextEditingController();

  Future<Position> _getGeoLocationPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  Future<void> GetAddressFromLatLong(Position position) async {
    List<Placemark> placemarks =
    await placemarkFromCoordinates(position.latitude, position.longitude);
    print('placemarks-----${placemarks}');
    placemarkaddress = placemarks;
    print('placemarkaddress-----${placemarkaddress}');
    Placemark place = placemarks[0];
    print('placemarks0-----${placemarks[0]}');

    AAddress =
    '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';
    cityController.text = place.locality.toString();
    countryController.text = place.country.toString();
    stateController.text = place.administrativeArea.toString();
    zipcodeController.text = place.postalCode.toString();

    print('Currentaddress------${AAddress}');
    setState(() {});
  }

  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  static final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(currentlat, currentlong),
      tilt: 59.440717697143555,
      zoom: 12);
  int value = 0;
  List<LatLng> points = [];
  MapsRoutes route = new MapsRoutes();
  DistanceCalculator distanceCalculator = new DistanceCalculator();
  createPloyline() async {
    print("createPloyline--------------pointssss-------");
    print("createPloyline--------------pointssss-------"+points.toString());
    if (points.length >= 2) {
      print("createPloyline  1");

      await route.drawRoute(points, 'Test routes', Colors.blue, googleApiKey,
          travelMode: TravelModes.driving);
      _markers.add(Marker(
          markerId: const MarkerId('SomeId'),
          position: LatLng(points.first.latitude, points.first.longitude),
          infoWindow: const InfoWindow(title: 'The title of the marker')));
      _markers.add(Marker(
          markerId: const MarkerId('SomeId2'),
          position: LatLng(points.last.latitude, points.last.longitude),
          infoWindow: const InfoWindow(title: 'The title of the marker')));

      setState(() {

      });
    } else {
      print("createPloyline  else");
    }
  }

  LatLng showLocation = LatLng(currentLat, currentLong);
  @override
  void dispose() {
    // TODO: implement dispose
    mapController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
     print("-------------------- $showLocation");
    return Scaffold(
      body: Container(
        child: Stack(
          // alignment: Alignment.center,
          children: [
            // if(currentlat!=null)
            GoogleMap(
                polylines: route.routes,
                mapType: MapType.normal,
                initialCameraPosition: CameraPosition(
                  target: showLocation, //initial position
                  zoom: 21, //initial zoom level
                ),
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                  setState(() {
                    mapController = controller;
                  });
                },
                markers: _markers,

                ),

            if(widget.isSearch!)

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
                            // margin: EdgeInsets.only(top: 45),

                            // height: 48,
                            width: MediaQuery.of(context).size.width - 120,
                            // margin: EdgeInsets.symmetric(
                            //     horizontal:16 ,vertical:8 ),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                // border: Border.all(color: MyColors.primaryColor),
                                borderRadius: BorderRadius.circular(30)),
                            padding: EdgeInsets.only(
                                left: 0, right: 0, top: 0, bottom: 0),

                          ),
                        ),
                        InkWell(
                          onTap: () {
                            // push(context: context, screen: Call_Screen());
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
                            apiKey: googleApiKey,
                            onSelected: (value) async {
                              var temp = await value.geolocation;
                              if (temp != null)
                                print('ghehehedhdhdfbn' +
                                    temp.coordinates.longitude.toString());
                              print('ghehehedhdhdfbn123');
                              // addressController.text = value.description;
                              print(
                                  'addressController-----${addressController.text}');
                              print('ghehehedhdhdfbn456');
                              if (temp != null) {
                                dynamic l = temp.coordinates;

                                print('ghehehedhdhdfbn789');
                                String p = value.placeId;
                                print(
                                    "value from country   ${temp!.coordinates}");
                                print('ghehehedhdhdfbn2');

                                print("value from country   ${l.longitude}");
                                print("value from place   ${p.toString()}");
                                // print("value from state   }");
                                print("value from city   ${value.description}");
                                // print("lat   ${l.latitude.toString()}");
                                // print("long   ${l.longitude.toString()}");
                                lat = l.latitude;
                                long = l.longitude;
                                selectedCurrentLat = lat;
                                selectedCurrentLong = long;
                                points = [];
                                points.add(LatLng(currentLat, currentLong));
                                points.add(LatLng(selectedCurrentLat, selectedCurrentLong));
                                points.add(LatLng(22.7196, 75.8577));
                                // createPloyline();
                                print("latlocal   ${lat}");
                                print("longlocal   ${long}");
                                List<Placemark> placemarks =
                                await placemarkFromCoordinates(
                                    l.latitude, l.longitude);
                                placemarkaddress = placemarks;
                                print("placemarksmapsearch   ${placemarks}");

                                print(
                                    "placemarks   ${placemarks[0].administrativeArea}");
                                searchlocationController.text =
                                    value.description;
                                selectedAddress = value.description;
                                countryController.text =
                                    placemarks[0].country.toString();
                                stateController.text =
                                    placemarks[0].administrativeArea.toString();
                                cityController.text =
                                    placemarks[0].locality.toString();
                                zipcodeController.text =
                                    placemarks[0].postalCode.toString();
                              }

                              LatLng newlatlang = LatLng(lat, long);
                              print('current--lat--long---${newlatlang}');
                              mapController?.animateCamera(
                                  CameraUpdate.newCameraPosition(CameraPosition(
                                      target: newlatlang, zoom: 12)
                                    //17 is new zoom level
                                  ));
                              _markers.clear();
                              _markers.add(Marker(
                                  markerId: MarkerId('${_markers.length + 1}'),
                                  position: LatLng(lat, long),
                                  // position: LatLng(latlng.latitude,  latlng.longitude ),
                                  draggable: true,
                                  onDrag: (value) async {
                                    // latlng = value;
                                    // placemarks = await placemarkFromCoordinates(latlng.latitude, latlng.longitude);
                                  }));
                              // setState(() {});
                            },
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}

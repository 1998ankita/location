import 'dart:async';

import 'package:flutter/material.dart';
import 'package:locat/MapDirectory/MapScreen.dart';
import 'package:locat/MapDirectory/NewMap.dart';
import 'package:locat/MapDirectory/packages/location.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  bool isSearch=true;
  bool loader=false;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  getData()async{
    setState(() {
      // loader=true;
    });
    await getCurrentLocation();
   currentAddress= await getCurrentAddress();
   setState(() {
     // loader=false;
   });
  }
  @override
  void initState() {

    getData();
    // TODO: implement initState
    // print("objectobjectobjectobject---------${selectedCurrentLat}");
    // getCar();
    super.initState();

  }
  Timer? timer;
  List carList=[];
  bool loading=false;
  String selectedCar='';
  bool searchDriver=false;
  String showPopup="";
  Map driverData={};
  getCar()async{
    setState(() {

      loading=true;
    });

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // drawer:  My_Drawer(),
      // key: _scaffoldKey,
      body:SafeArea(
        child: loader?Center(child: CircularProgressIndicator(),):Stack(
          children: [
            if(currentLat!=0)
             NewMap()


            // MapScreen(isSearch: isSearch,
            //     onNext:(){
            //
            // }),


           
          ],
        ),
      ),
    );
  }

}

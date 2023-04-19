import 'dart:async';
import 'dart:typed_data';

import 'package:dante/utility/app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hive/hive.dart';
import 'package:iconly/iconly.dart';

import '../../utility/app_bar.dart';
import '../../utility/app_colors.dart';

class LocationMap extends StatefulWidget {
  const LocationMap({Key? key}) : super(key: key);

  @override
  State<LocationMap> createState() => _LocationMapState();
}

class _LocationMapState extends State<LocationMap> {

  final Completer<GoogleMapController> _controller =
  Completer<GoogleMapController>();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );


  static const CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  final Set<Marker> markers = new Set();

  Future showMarker({double lat = 37.42796133580664, double lng = -122.085749655962}) async {
    String imgurl = "https://gcdnb.pbrd.co/images/7nLfarqebz8M.png?o=1";
    Uint8List bytes = (await NetworkAssetBundle(Uri.parse(imgurl))
        .load(imgurl))
        .buffer
        .asUint8List();
    markers.add(
        Marker( //add first marker
          markerId: MarkerId("showLocation.toString()"),
          position: LatLng(lat, lng ), //position of marker
          infoWindow: InfoWindow( //popup info
            title: 'Car Location',
            snippet: 'Location ',
          ),
          icon: BitmapDescriptor.fromBytes(bytes), //Icon for Marker
        )
    );
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    showMarker();
  }


  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body:  Container(
        width: size.width,
        height: size.height,
        child: Stack(
          children: [
            GoogleMap(
              mapType: MapType.normal,
              initialCameraPosition: _kGooglePlex,
              markers: markers,
              myLocationEnabled: true,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
              onTap: (latLng)async{
                markers.clear();
                final GoogleMapController controller = await _controller.future;
                controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
                showMarker(lat: 37.43296265331129, lng: -122.08832357078792);
              },
            ),

            //top section
            Container(
              width: size.width,
              height: 60,
              margin: EdgeInsets.all(30),
              decoration: BoxDecoration(

              ),
              child: AppTopBar(
                  size: size,
                  title: "Search Location",
                  isRightSideBar: false,
                  onBack: ()=>Get.back(),
                  onClickRight: (){}
              ),
            ),

            Positioned(
              top: size.height*.07,
              child: Container(
                width: size.width*.85,

                margin: EdgeInsets.all(30),
                child: TextFormField(
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(left: 15, right: 15, top: 15, bottom: 15),
                    fillColor: AppColors.bgColor,
                    filled: true,
                    prefixIcon: Icon(Icons.search_outlined, size: 25,),
                    hintText: "Search",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none
                    )
                  ),
                ),
              ),
            ),


            //bottom bar
            Positioned(
              bottom: 0,
              child: Container(
                width: size.width,
                height: size.height*0.24,
                padding: EdgeInsets.all(30),
                decoration: BoxDecoration(
                  color: AppColors.bgColor
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                            padding:  EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: AppColors.blue,
                              borderRadius: BorderRadius.circular(100)
                            ),
                            child: Icon(IconlyLight.location, color: Colors.white,)),
                        SizedBox(width: 10,),
                        Text("Location Address",
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                              fontSize: 18
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 5,),
                    Padding(
                      padding: const EdgeInsets.only(left: 35),
                      child: Text("Bruce Cafe\n123 Selville Road, Atlanta.",
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                            fontSize: 15
                        ),
                      ),
                    ),

                    SizedBox(height: 25,),
                    Container(
                        margin: EdgeInsets.only(left: 30, right: 30),
                        child: AppButton(size: size, child: Center(child: Text("Set Location", style: TextStyle(fontWeight: FontWeight.w600, color: AppColors.white),),), onClick: ()=>Get.back()))
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

}

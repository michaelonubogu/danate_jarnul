import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:dante/config/app_config.dart';
import 'package:dante/utility/app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hive/hive.dart';
import 'package:iconly/iconly.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utility/app_bar.dart';
import '../../utility/app_colors.dart';

class LocationMap extends StatefulWidget {
  const LocationMap({Key? key}) : super(key: key);

  @override
  State<LocationMap> createState() => _LocationMapState();
}

class _LocationMapState extends State<LocationMap> {


  //get current location possition
  var lat, lng;
  Future<Position> _getCurrentLocation()async{
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
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
    return await Geolocator.getCurrentPosition();

  }

  //initli possition
  late CameraPosition _kLake;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _getCurrentLocation().then((value) {
      isLocation = true;
      print("this is current location lat === ${value}");
      lat = value.latitude;
      lng = value.longitude;
      _kLake = CameraPosition(
          bearing: 192.8334901395799,
          target: LatLng(value.latitude, value.longitude),
          tilt: 59.440717697143555,
          zoom: 14.151926040649414);

      showMarker(lat: value.latitude, lng: value.longitude);
      getAddressFromLatLng(context, value.latitude, value.longitude);

      isLocation = false;
    });
  }



  //map controller
  final Completer<GoogleMapController> _controller =
  Completer<GoogleMapController>();


  //marker list
  final Set<Marker> markers = new Set();

  //marker method
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
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body:  Container(
        width: size.width,
        height: size.height,
        child: Stack(
          children: [
            lat==null
                ? Center(child: CircularProgressIndicator(color: AppColors.blue,),)
                : GoogleMap(
              mapType: MapType.normal,
              initialCameraPosition: _kLake,
              markers: markers,
              myLocationEnabled: true,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
              onTap: (value)async{
                markers.clear();
                final CameraPosition _kLake = CameraPosition(
                    bearing: 192.8334901395799,
                    target: LatLng(value.latitude, value.longitude),
                    tilt: 59.440717697143555,
                    zoom: 19.151926040649414);

                //google map
                CameraPosition cameraPosition = CameraPosition(
                  target: LatLng(value.latitude, value.longitude),
                  zoom: 19.4746,
                );
                final GoogleMapController controller = await _controller.future;
                controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
                showMarker(lat: value.latitude, lng: value.longitude);
                getAddressFromLatLng(context, value.latitude, value.longitude);

                setState(() {});

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

            ///TODO: search location and show the suggested.
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
                height: size.height*0.25,
                padding: EdgeInsets.all(30),
                decoration: BoxDecoration(
                  color: AppColors.bgColor
                ),
                child: location.isEmpty ? Center(child: CircularProgressIndicator(color: AppColors.blue,),) : Column(
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
                      child: Text("$location",
                        maxLines: 2,
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
                        child: AppButton(size: size, child: Center(child: Text("Set Location", style: TextStyle(fontWeight: FontWeight.w600, color: AppColors.white),),), onClick: ()=>Navigator.pop(context, selectedLocation)))
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }


  var selectedLocation;
bool isLocation = false;
  String location = "";
  getAddressFromLatLng(context, double lat, double lng) async {
    setState(() {
      isLocation = true;
    });
    print(lat,);
    String _host = 'https://maps.google.com/maps/api/geocode/json';
    final url = '$_host?key=${AppConfig.GOOGLE_MAP}&language=en&latlng=$lat,$lng';
    if(lat != null && lng != null){
      var response = await http.get(Uri.parse(url));
      if(response.statusCode == 200) {
        Map data = jsonDecode(response.body);
        String _formattedAddress = data["results"][0]["formatted_address"];
        setState(() {
          isLocation = false;
          location = _formattedAddress;
          selectedLocation = {
            "location" : location,
            "lat" : lat,
            "lng" : lng
          };
        });
        SharedPreferences localStore = await SharedPreferences.getInstance();
        localStore.setString("lat", "$lat");
        localStore.setString("lng", "$lng");
        localStore.setString("full_address", "$_formattedAddress");

        return _formattedAddress;
      } else return null;
    } else return null;
  }


}

import 'dart:async';
import 'dart:typed_data';

import 'package:dante/model/dates_model/dates_screen_model.dart';
import 'package:dante/utility/app_bar.dart';
import 'package:dante/utility/app_colors.dart';
import 'package:dante/view/dates/edit_dates.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hive/hive.dart';

class SingleDates extends StatefulWidget {
  final DatesModel datesModel;
  const SingleDates({Key? key, required this.datesModel}) : super(key: key);

  @override
  State<SingleDates> createState() => _SingleDatesState();
}

class _SingleDatesState extends State<SingleDates> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("==== this is single dates ==== ${LatLng(widget.datesModel.location["lat"], widget.datesModel.location["lng"])}");

    showMarker(lat: widget.datesModel.location["lat"], lng: widget.datesModel.location["lng"]);
  }


  late CameraPosition _kLake;

  //map controller
  final Completer<GoogleMapController> _controller =
  Completer<GoogleMapController>();

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
          icon: BitmapDescriptor.fromBytes(bytes), //Icon for Marker
        )
    );
    setState(() {});
  }



  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size; 
    return Container(
      color: AppColors.bgColor,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: AppColors.bgColor,
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: AppTopBar(
                    size: size,
                    title: "Date Details",
                    isRightSideBar: true,
                    onBack: ()=>Get.back(),
                    onClickRight: ()=>Get.to(EditDates(datesModel: widget.datesModel))
                ),
              ),
              Divider(height: 1, color: Colors.grey,),
              SizedBox(height: 10,),
              Container(
                height: size.height-110,
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Image.memory(widget.datesModel.admirer["profile"], height: 45, width: 45, fit: BoxFit.cover,),
                          ),
                          SizedBox(width: 15,),
                          Text("${widget.datesModel.admirer["name"]}",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: AppColors.blue
                            ),
                          )

                        ],
                      ),

                      SizedBox(height: 20,),
                      Text("${widget.datesModel.title}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 25,
                        ),
                      ),
                      SizedBox(height: 10,),
                      Row(
                        children: [
                          Row(
                            children: [
                              Image.asset("assets/icons/bs_1.png", height: 30, width: 30,),
                              SizedBox(width: 5.0),
                              Text("${widget.datesModel.date}", style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.w600)),
                            ],
                          ),
                          SizedBox(width: 20,),
                          Row(
                            children: [
                              //Image.asset("assets/images/pin.png", height: 18, width: 18,),
                              Icon(Icons.watch_later_outlined, color: AppColors.mainColor, size: 30,),
                              SizedBox(width: 5.0),
                              Text("${widget.datesModel.time}", style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.w600)),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 30,),
                      Text("Date Description",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                          fontSize: 20,
                        ),
                      ),
                      SizedBox(height: 10,),
                      Text("${widget.datesModel.description}",
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(height: 30,),
                      Container(
                        width: size.width,
                        height: 170,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10)
                        ),
                        child: getLocation(),
                      ),
                      SizedBox(height: 30,),

                      //today's outfit
                      Text("Today's Outfit",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                          fontSize: 20,
                        ),
                      ),
                      SizedBox(height: 15,),
                      SizedBox(
                        height: 180,
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: widget.datesModel.outfit.length,
                          itemBuilder: (_, index){
                            return Container(
                              width: 130,
                              height: 180,
                              margin: EdgeInsets.only(right: 10),
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(5),
                                    child: Image.memory(widget.datesModel.outfit[index]["outfit_image"], height: 130, width: 130, fit: BoxFit.cover,),
                                  ),
                                  SizedBox(height: 10,),
                                  Text("${widget.datesModel.outfit[index]["outfit_name"]}",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12
                                    ),
                                  )
                                ],
                              ),
                            );
                          },
                        ),
                      ),


                      SizedBox(height: 30,),

                      //today's outfit
                      Text("All Reminder's",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                          fontSize: 20,
                        ),
                      ),
                      SizedBox(height: 15,),
                      SizedBox(
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: widget.datesModel.reminders.length,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index){
                            return Container(
                              width: size.width,
                              padding: EdgeInsets.all(15),
                              margin: EdgeInsets.only(bottom: 10),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10)
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(width: size.width*.60,
                                        child: Text("${widget.datesModel.reminders[index]["reminder_name"]}",
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.black
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: size.width*.20,
                                        child: Text("${widget.datesModel.reminders[index]["reminder_time"]}",
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.grey
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(height: 10,),
                                  Text("${widget.datesModel.reminders[index]["reminder_text"]}",
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.grey
                                    ),
                                  )
                                ],
                              ),
                            );
                          },
                        ),
                      ), 

                      SizedBox(height: 30,),

                      //Purse Check outfit
                      Text("Purse Check",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                          fontSize: 20,
                        ),
                      ),
                      SizedBox(height: 15,),
                      ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: widget.datesModel.purses.length,
                          itemBuilder: (context, index) {
                            return Container(
                              width: size.width,
                              height: 50,
                              margin: EdgeInsets.only(bottom: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    width: 50,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: AppColors.blue.withOpacity(0.3),
                                    ),
                                    child: Center(
                                      child: Text("${index+1}",
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.blue
                                        ),
                                      ),),
                                  ),

                                  SizedBox(width: 10,),
                                  Text("${widget.datesModel.purses[index]["name"]}",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black54
                                    ),
                                  )
                                ],
                              ),
                            );
                          }
                      ),
                      SizedBox(height: 40,),

                    ],

                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  getLocation(){
    return widget.datesModel.location["lat"]==null
        ? Center(child: CircularProgressIndicator(color: AppColors.blue,),)
        : GoogleMap(
      mapType: MapType.normal,
      initialCameraPosition: CameraPosition(
          bearing: 192.8334901395799,
          target: LatLng(widget.datesModel.location["lat"], widget.datesModel.location["lng"]),
          tilt: 59.440717697143555,
          zoom: 14.151926040649414),
      markers: markers,
      myLocationEnabled: true,
      onMapCreated: (GoogleMapController controller) {
        _controller.complete(controller);
      },
      onTap: (value)async{
        markers.clear();
        final CameraPosition _kLake = CameraPosition(
            bearing: 192.8334901395799,
            target: LatLng(widget.datesModel.location["lat"], widget.datesModel.location["lng"]),
            tilt: 59.440717697143555,
            zoom: 19.151926040649414);
        final GoogleMapController controller = await _controller.future;
        controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
        setState(() {});

      },
    );
  }

}


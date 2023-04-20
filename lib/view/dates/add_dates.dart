import 'dart:io';

import 'package:dante/boxs/boxs.dart';
import 'package:dante/utility/app_button.dart';
import 'package:dante/view/admirer/add_profile.dart';
import 'package:dante/view/dates/location_map.dart';
import 'package:dante/view/dates/view_controller/addtext_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import '../../utility/app_input_rightIcons.dart';
import '../../utility/app_colors.dart';
import 'package:intl/intl.dart';
import 'package:geolocator/geolocator.dart';

class AddDates extends StatefulWidget {
  const AddDates({Key? key}) : super(key: key);

  @override
  State<AddDates> createState() => _AddDatesState();
}

class _AddDatesState extends State<AddDates> {
  final title = TextEditingController();
  final dec = TextEditingController();
  final date = TextEditingController();
  final time = TextEditingController();
  final location = TextEditingController();
  final addDateFormKey = GlobalKey<FormState>();
  final outfitName = TextEditingController();


  //image picker global variable
  final ImagePicker _picker = ImagePicker();


  // this is profile image store variable
  var outfitImage, outfitImageStr;


  Map<String, dynamic> selectedAdmirerProfiles = {};

  var selectedValue;

  //initial current date & time appear
  var selectedDate = DateFormat.yMMMd().format(DateTime.now());

  var _dateTime = DateFormat('hh:mm a').format(DateTime.now());


  //show selected locatiom
  Future showSelectedLocation(BuildContext context)async{
    // Navigator.push returns a Future that completes after calling
    // Navigator.pop on the Selection Screen.
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const LocationMap()),
    );
    // When a BuildContext is used from a StatefulWidget, the mounted property
    // must be checked after an asynchronous gap.
    if (!mounted) return;
    location.text = result;
    print("this is result location $result");
  }


  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: AppBar(
          elevation: 0,
          backgroundColor: AppColors.bgColor,
          centerTitle: true,
          leading: Container(
            margin: EdgeInsets.only(left: 12, top: 8, bottom: 8, right: 2),
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(5),
            ),
            child: IconButton(
              onPressed: ()=>Get.back(),
              icon: Icon(Icons.arrow_back_ios, size: 20, color: AppColors.textColor,),
            ),
          ),
          title: Text("Add Profile",
            style: TextStyle(
                fontSize: 18,
                color: AppColors.textColor
            ),
          )
      ),

      body: SingleChildScrollView(
        padding: EdgeInsets.all(30),
        child: Column(
          children: [
          Form(
          key: addDateFormKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Text("Date Title",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 15,),
              TextFormField(
                controller: title,
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: "Choose Sign",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none
                    )
                ),
              ),
              SizedBox(height: 30,),
              Text("Admirers",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 15,),
              InkWell(
                onTap: ()=>showAdmirers(),
                child: Container(
                  padding: EdgeInsets.only(left: 5, right: 15, top: 5, bottom: 5),
                  height: 60,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                     // border: Border.all(color: AppColors.blue, width: 1)
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: size.width*0.70,
                        child: selectedAdmirerProfiles.isNotEmpty ? buildAdmirerWidget(
                          image: selectedAdmirerProfiles["profile"],
                          name: selectedAdmirerProfiles["name"],
                        ) : Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text("Choose admirers",
                            style: TextStyle(
                              fontSize: 15
                            ),
                          ),
                        ),
                      ),
                      AppInputRightIcon()
                    ],
                  ),
                ),
              ),

              SizedBox(height: 30,),
              Text("Description",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 15,),
              TextFormField(
                controller: dec,
                maxLines: 6,
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: "Write here...",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none
                    )
                ),
              ),

              SizedBox(height: 30,),
              Text("Date & Time",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 15,),
              InkWell(
                onTap: ()=>selectDate(),
                child: Container(
                  padding: EdgeInsets.only(left: 10, right: 15, top: 7, bottom: 7),
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                    // border: Border.all(color: AppColors.blue, width: 1)
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: size.width*0.70,
                        child: Row(
                          children: [
                            Image.asset("assets/icons/bs_1.png", height: 30, width: 30,),
                            SizedBox(width: 8,),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Date", style: TextStyle(fontSize: 13, color: Colors.grey),),
                                Text("${selectedDate}", style: TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.w600),),

                              ],
                            )
                          ],
                        ),
                      ),
                      AppInputRightIcon()
                    ],
                  ),
                ),
              ),

              SizedBox(height: 15,),
              InkWell(
                onTap: ()=>selectTime(),
                child: Container(
                  padding: EdgeInsets.only(left: 10, right: 15, top: 7, bottom: 7),
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                    // border: Border.all(color: AppColors.blue, width: 1)
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: size.width*0.70,
                        child: Row(
                          children: [
                            Icon(Icons.watch_later_outlined, color: Colors.red, size: 30,),
                            SizedBox(width: 8,),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Time", style: TextStyle(fontSize: 13, color: Colors.grey),),
                                Text("$_dateTime", style: TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.w600),),

                              ],
                            )
                          ],
                        ),
                      ),
                      AppInputRightIcon()
                    ],
                  ),
                ),
              ),


              //location
              SizedBox(height: 30,),
              Text("Location",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 15,),
              InkWell(
                onTap: ()=>showSelectedLocation(context),
                child: Container(
                  padding: EdgeInsets.only(left: 10, right: 15, top: 7, bottom: 7),
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                    // border: Border.all(color: AppColors.blue, width: 1)
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: size.width*0.70,
                        child: Row(
                          children: [
                            Image.asset("assets/icons/map-marker.png", height: 20, width: 20,),
                            SizedBox(width: 8,),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("${location.text.isNotEmpty ? location.text : "Search Location"}", style: TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.w400),),
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              //location
              SizedBox(height: 30,),
              Text("Today’s Outfit",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 15,),

              Container(
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.grey.shade400,
                  borderRadius: BorderRadius.circular(10)
                ),
                child: Center(child: Text("No outfit found"),),
              ),
              //add text button, its a user
              AddTextButton(
                text: "Add Outfit",
                onClick: ()=>showOutfitPoup(),
              )

            ],
          ),
        )
        ]
      ),
      )
    );
  }


  //show admirer profiles
  Future<void> showAdmirers() async {
    print("this boxes ${Boxes.getAdmirers.getAt(0)!.admirerName}");
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (context, setState) {
            return AlertDialog(
              contentPadding: EdgeInsets.all(10),
              titlePadding: EdgeInsets.only(top: 10, bottom: 0),
              actionsPadding: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(32.0))),
              title: Row(
                children: [
                  IconButton(
                    onPressed: ()=>Navigator.pop(context),
                    icon: Icon(Icons.close),
                  ),
                  Text('Choose Admirers',
                    style: TextStyle(
                      color: AppColors.blue
                    ),
                  ),
                ],
              ),
              content: Container(
                height:300,
                width: 300.0,
                padding: EdgeInsets.only(top: 15, bottom: 0),
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(width: 1, color: AppColors.blue)
                  )
                ),
                child: Stack(
                  children: [
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount:  Boxes.getAdmirers.length,
                      itemBuilder: (_, index){
                        var data = Boxes.getAdmirers.getAt(index);
                        print("this is admirers $data");
                        return InkWell(
                          onTap: (){

                          setState((){
                            selectedAdmirerProfiles.clear();
                            selectedAdmirerProfiles.assignAll({
                              "id": data!.id,
                              "name" : data!.admirerName,
                              "profile" : data!.profile,
                            });

                            print("select admirers ${selectedAdmirerProfiles.isNotEmpty}");
                            Navigator.pop(context);

                          });

                          },
                          child: Container(
                              height: 40,
                              margin: EdgeInsets.only(bottom: 10),
                              decoration: BoxDecoration(
                              ),
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 40,
                                    height: 40,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(5),
                                      child: Image.memory(data!.profile,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 10,),
                                  Text(data!.admirerName,
                                    style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  )
                                ],
                              )),
                        );
                      },

                    ),

                    Positioned(
                      bottom: 10, right: 10,
                      child: InkWell(
                        onTap: ()=>Get.to(AddAdmirerProfile(), transition: Transition.rightToLeft),
                        child: Container(
                          width: 100,
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: AppColors.mainColor,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.add, color: Colors.white,), 
                              SizedBox(width: 5,),
                              Text("Add",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          }
        );
      },
    );
  }


  //show admirer profiles
  Future<void> selectTime() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (context, setState) {
            return AlertDialog(
              contentPadding: EdgeInsets.all(10),
              titlePadding: EdgeInsets.only(top: 10, bottom: 0),
              actionsPadding: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(32.0))),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: ()=>Navigator.pop(context),
                    icon: Icon(Icons.close),
                  ),
                  Text('Set Time',
                    style: TextStyle(
                      color: AppColors.blue
                    ),
                  ),
                  IconButton(
                    onPressed: ()=>setState(()=>Navigator.pop(context)),
                    icon: Icon(Icons.check, color: AppColors.blue,),
                  ),
                ],
              ),
              content: Container(
                height:300,
                width: 300.0,
                padding: EdgeInsets.only(top: 15, bottom: 0),
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(width: 1, color: AppColors.blue)
                  )
                ),
                child: TimePickerSpinner(
                  is24HourMode: false,
                  normalTextStyle: TextStyle(
                      fontSize: 24,
                      color: Colors.grey
                  ),
                  highlightedTextStyle: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppColors.blue
                  ),
                  spacing: 50,
                  itemHeight: 80,
                  isForce2Digits: true,
                  onTimeChange: (time) {
                    setState(() {
                      _dateTime = DateFormat('hh:mm a').format(time);
                      print("selected time === ${_dateTime}");
                    });
                  },
                )
              ),
            );
          }
        );
      },
    );
  }

  //select date
  Future selectDate() async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1920, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = DateFormat.yMMMd().format(picked);
        date.text = selectedDate;
        print("this is date === ${date.text}");
      });
  }

  //show Outfit popup
 Future showOutfitPoup() {
    var size = MediaQuery.of(context).size;
   return showDialog<void>(
     context: context,
     barrierDismissible: false, // user must tap button!
     builder: (BuildContext context) {
       return StatefulBuilder(
         builder: (context, setState) {
           return AlertDialog(
             contentPadding: EdgeInsets.all(20),

             titlePadding: EdgeInsets.zero,
             actionsPadding: EdgeInsets.zero,
             shape: RoundedRectangleBorder(
                 borderRadius: BorderRadius.all(Radius.circular(32.0))),
             title: const Text(''),
             content: SingleChildScrollView(
               child: ListBody(
                 children:  <Widget>[
                   Text('Outfit Name:',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: AppColors.blue
                    ),
                   ),
                   SizedBox(height: 10,),
                   TextFormField(
                     controller: outfitName,
                     decoration: InputDecoration(
                       hintText: "Outfit Name",
                       contentPadding: EdgeInsets.only(left: 15, right: 15),
                       focusedBorder:OutlineInputBorder(
                         borderSide: const BorderSide(color: AppColors.blue, width: 1.0),
                         borderRadius: BorderRadius.circular(5.0),
                       ),
                         border:OutlineInputBorder(
                           borderSide: const BorderSide(color: AppColors.blue, width: 1.0),
                           borderRadius: BorderRadius.circular(5.0),
                         ),
                         enabledBorder:OutlineInputBorder(
                           borderSide: const BorderSide(color: AppColors.blue, width: 1.0),
                           borderRadius: BorderRadius.circular(5.0),
                         )
                     ),
                   ),
                   SizedBox(height: 30,),
                   InkWell(
                     onTap: (){
                       openBottomSheet();
                       setState((){});
                     },
                     child: Container(
                       padding: EdgeInsets.all(10),
                       decoration: BoxDecoration(
                         color: AppColors.blue.withOpacity(0.2),
                         borderRadius: BorderRadius.circular(5),
                       ),
                       child: Row(
                         children: [
                          Image.asset("assets/icons/gallery.png", height: 30, width: 30,),
                           SizedBox(width: 10,),
                           Text("Upload photo",
                            style: TextStyle(
                              fontSize: 14,
                              color: AppColors.blue
                            ),
                           )
                         ],
                       ),
                     ),
                   ),
                   SizedBox(height: 30,),
                   Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: [
                       SizedBox(width: 110,
                        child: AppButton(
                            size: size,
                            bg: Colors.grey.shade300,
                            child: Text("Close",
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            onClick: ()=>Navigator.pop(context)
                        ),
                       ),
                       SizedBox(width: 110,
                         child: AppButton(
                             size: size,
                             child: Text("SAVE",
                               style: TextStyle(
                                 fontSize: 15,
                                 color: Colors.white,
                                 fontWeight: FontWeight.w600,
                               ),
                             ),
                             onClick: ()=>Navigator.pop(context)
                         ),
                       )
                     ],
                   )
                 ],
               ),
             ),

           );
         }
       );
     },
   );
 }

 //open bottom sheet for outfit image
  openBottomSheet() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: new Icon(Icons.photo),
                title: new Text('Gallery'),
                onTap: () {
                  //select image
                  selectImage(ImageSource.gallery);
                  setState(() {});
                },
              ),
              ListTile(
                leading: new Icon(Icons.camera_alt_outlined),
                title: new Text('Camera'),
                onTap: () {
                  selectImage(ImageSource.camera);
                  setState(() {});
                },
              ),
            ],
          );
        });
  }

  void selectImage(type) async{
    var image = await _picker.pickImage(source: type);
    setState(() {
      outfitImage = File(image!.path); // store the image path in this local variable
      outfitImageStr = image;
    });
    Navigator.pop(context); //when image taken, it will be close bottom sheets.
  }





//this select addmirer profile popup

}


class buildAdmirerWidget extends StatelessWidget {
  const buildAdmirerWidget({
    Key? key, required this.image, required this.name,
  }) : super(key: key);
  final dynamic image;
  final String name;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 58,
          height: 58,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Image.memory(image,
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(width: 10,),
        Text(name,
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w500,
          ),
        )
      ],
    );
  }
}


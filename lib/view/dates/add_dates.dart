import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:dante/boxs/boxs.dart';
import 'package:dante/notification/notification.dart';
import 'package:dante/utility/app_button.dart';
import 'package:dante/view/admirer/add_profile.dart';
import 'package:dante/view/dates/location_map.dart';
import 'package:dante/view/dates/view_controller/addtext_button.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../model/admirers_model/admirers_model.dart';
import '../../model/dates_model/dates_screen_model.dart';
import '../../model/profile_model/profile_model.dart';
import '../../utility/app_input_rightIcons.dart';
import '../../utility/app_colors.dart';
import 'package:intl/intl.dart';
import 'package:geolocator/geolocator.dart';

import '../index.dart';
import '../profile/edit_profile.dart';

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
  final reminderName = TextEditingController();
  final reminderText = TextEditingController();
  final purseCheckText = TextEditingController();


  //image picker global variable
  final ImagePicker _picker = ImagePicker();


  // this is profile image store variable
  var outfitImage, outfitImageStr;


  Map<String, dynamic> selectedAdmirerProfiles = {};

  var selectedValue;

  //initial current date & time appear
  var selectedDate = DateFormat.yMMMd().format(DateTime.now());

  var _dateTime = DateFormat('hh:mm a').format(DateTime.now());

  //reminder time
  var _reminderTime;

  var reminderAlarmTime;
  var reminderAlarmDate;

  //this list for out fit
  List<Map<String, dynamic>> outFitList = [];

//this list for Purse Check
  List<Map<String, dynamic>> purseCheck = [];


  //this list for all Reminders
  List<Map<String, dynamic>> allReminders = [];

  var selectLocationList;

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
    print("this is result location $result");
   setState(() {
     selectLocationList = result;
     location.text = result["location"];
   });

  }

  //user auth
  var userToken;
  getLogedInUser()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userToken = prefs.getString("token");
    });
  }

  

  //show user profile
  ProfileModel? showUserProfile;

  //EMAIL
  var userid, email, fname, lname, image, isVerify;
  showProfile()async{
    List userTokenList = [];
    List userIdList = [];

    SharedPreferences prefes = await SharedPreferences.getInstance();
    var token = prefes.getString("token");


    for(var i = 0; i < Boxes.getLogin.length; i ++){
      //store data with index
      var data = Boxes.getLogin.getAt(i);
      if(data?.token == token){
        userIdList.add(data?.id);
        userTokenList.add(data?.token);
      }
    }

    userid = userIdList[0];
    print(userid);
    var profiles = await Boxes.getProfile.get("${userid}");

    if(profiles != null){
      if(userTokenList.contains(token)){
        setState(() {
          showUserProfile = profiles;
        });
        print("this user profile ==== ${showUserProfile?.fName}");
        return profiles;
      }
    }else{
      return Get.to(EditProfile());
    }


  }
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLogedInUser();
    showProfile();
   // Boxes.getDates.clear();
  }




  DateTime scheduledDateTime = DateTime(2023, 5, 20, 03, 40, 40); // Replace with your desired date and time



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
                                Text("${selectedDate}", style: TextStyle(fontSize: 16, color: AppColors.textColor, fontWeight: FontWeight.w500),),

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
                                Text("$_dateTime", style: TextStyle(fontSize: 16, color: AppColors.textColor, fontWeight: FontWeight.w500),),

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
                                SizedBox(
                                  width: size.width*0.60,
                                  child: Text("${location.text.isNotEmpty ? location.text : "Search Location"}",
                                    overflow: TextOverflow.ellipsis,

                                    style: TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.w400),),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              //Out fit
              SizedBox(height: 30,),
              Text("Today’s Outfit",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 15,),
          outFitList.length != 0
              ? Container(
            width: size.width,
               padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(10)
                ),
                child:SizedBox(
                  height: 120,
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: outFitList.length,
                    itemBuilder: (_, index){
                      return Container(
                        //width: 80,
                        height: 90,
                        margin: EdgeInsets.only(right: 10),
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(5),
                              child: Image.memory(outFitList[index]["outfit_image"], height: 80, width: 80, fit: BoxFit.cover,),
                            ),
                            SizedBox(height: 10,),
                            Text("${outFitList[index]["outfit_name"]}",
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
                )

              ): Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                  color: Colors.grey.shade400,
                  borderRadius: BorderRadius.circular(10)
              ),
              child: Center(child: Text("No outfit found", style: TextStyle(color: AppColors.textColor)),)),
              //add text button, its a user
              AddTextButton(
                text: "Add Outfit",
                onClick: ()=>showOutfitPopup(),
              ),


              //Reminders
              SizedBox(height: 30,),
              Text("All Reminders",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 10,),
          allReminders.length != 0
              ? Container(
                height: 130.00 * allReminders.length,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10)
                ),
                child: SizedBox(
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: allReminders.length,
                    itemBuilder: (_, index){
                      var data = allReminders[index];
                      print("this is data${data}");
                      return Container(
                        width: size.width,
                        height: 110.00,
                        margin: EdgeInsets.only( bottom: 10),
                        padding: EdgeInsets.only(left: 15, right: 15, top: 15, bottom: 15),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Stack(
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.only(right: 15,),
                                  decoration: BoxDecoration(
                                    border: Border(
                                     right: BorderSide(width: 1, color: AppColors.blue)
                                    )
                                  ),
                                  child: Column(
                                    children: [
                                      Text("Time",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 15,color: AppColors.blue
                                        ),
                                      ),
                                      SizedBox(height: 10, ),
                                      Text("${reminderAlarmTime !=null ? data["reminder_time"] :"Set Time"}",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 12,
                                            color: AppColors.textColor
                                        ),
                                      ),
                                      SizedBox(height: 10, ),
                                      AppInputRightIcon(
                                        onClick: ()=>shoReminderTimePopup(
                                          index: index,
                                          name: data["reminder_name"],
                                          text: data["reminder_text"],
                                          id: data["reminder_id"],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(width: 15,),
                                SizedBox(
                                  width: size.width*0.40,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("${data["reminder_name"]}",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 15,color: AppColors.black
                                        ),
                                      ),
                                      SizedBox(height: 5, ),
                                      Text("${data["reminder_text"]}",
                                        style: TextStyle(
                                          overflow: TextOverflow.clip,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 12,
                                            color: AppColors.textColor
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Positioned(
                              bottom:0,
                              right:0,
                              child: IconButton(
                                onPressed: (){
                                  allReminders.removeAt(index);
                                  setState(() {});
                                },
                                icon: Icon(Icons.delete_outline_outlined, color: Colors.red,),
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  ),
                )

              ) : Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      color: Colors.grey.shade400,
                      borderRadius: BorderRadius.circular(10)
              ),
              child: Center(child: Text("No reminder found", style: TextStyle(color: AppColors.textColor),),)),
              //add text button, its a user
              AddTextButton(
                text: "Add Reminders",
                onClick: ()=>showReminderPopup(),
              ),



              //Purse Check
              SizedBox(height: 30,),
              Text("Purse Check",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 10,),
              purseCheck.length != 0
                  ? Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child:SizedBox(
                    height: 60.00 * purseCheck.length,
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: purseCheck.length,
                      itemBuilder: (_, index){
                        return Container(
                          width: size.width-85,
                          height: 50,
                          margin: EdgeInsets.only(bottom: 10),
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 50, height: 50,
                                margin: EdgeInsets.only(right: 15),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: AppColors.blue.withOpacity(0.4),
                                ),
                                child: Center(child: Text("${index+1}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.textColor,
                                    fontSize: 17
                                  ),
                                ),),
                              ),
                              Text("${purseCheck[index]["name"]}",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 13,
                                  color: AppColors.textColor
                                ),
                              ),
                            ],
                          )
                        );
                      },
                    ),
                  )

              ): Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      color: Colors.grey.shade400,
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: Center(child: Text("No purse items", style: TextStyle(color: AppColors.textColor)),)),
              //add text button, its a user
              AddTextButton(
                text: "Add More",
                onClick: ()=>showPurseCheckPopup(),
              ),

              SizedBox(height: 35,),
              Align(
                alignment: Alignment.center,
                child: SizedBox(
                  width: size.width*.75,
                  child: AppButton(
                      size: size,
                      child: Text("Save Date",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: AppColors.white
                        ),
                      ),
                      onClick: ()async{
                        print("this ===== ${reminderAlarmTime}");
                        if(title.text.isNotEmpty && selectedAdmirerProfiles.isNotEmpty && dec.text.isNotEmpty && selectedDate.isNotEmpty
                        && _dateTime.isNotEmpty && purseCheck.isNotEmpty && outFitList.isNotEmpty && allReminders.isNotEmpty
                        ){
                          if(reminderAlarmTime!=null){

                            //reminder time is not null
                            SharedPreferences prefs = await SharedPreferences.getInstance();
                            var userToken = await prefs.getString("token");

                            print("this is date for reminder ${reminderAlarmDate} ${reminderAlarmTime}");

                            //id
                            var id = new Random().nextInt(1000);

                            var data = DatesModel(
                                id: id,
                                token: userToken!,
                                title: title.text,
                                admirer: selectedAdmirerProfiles,
                                description: dec.text,
                                date: selectedDate.toString(),
                                time: _dateTime.toString(),
                                location: selectLocationList,
                                outfit: outFitList,
                                reminders: allReminders,
                                purses: purseCheck,
                                userProfile: showUserProfile!
                            );
                            var box = await Boxes.getDates;

                            print("schedule notification send");
                            box.put("$id", data);

                            // NotificationServices.showNotification(
                            //     id: id,
                            //     title: "Hey! Today you have a date with ${allReminders[0]["name"]}",
                            //     body: "Today you have a date with ${allReminders[0]["name"]}\n Location: ${location.text}",
                            //     interval: DateTime.parse("${reminderAlarmDate} ${reminderAlarmTime}"));



                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Index(index: 0,)));

                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text("New Date Added!"),
                              backgroundColor: Colors.green,
                              duration: Duration(milliseconds: 3000),
                            ));
                            if(kDebugMode){
                              print("admirer added");
                            }


                          }else{
                            //reminder time is null
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text("Reminder time is missing. Set reminder time."),
                              backgroundColor: Colors.red,
                              duration: Duration(milliseconds: 3000),
                            ));
                          }
                        }else{
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                            content: Text("Filed must not be empty. Some filed is empty."),
                            backgroundColor: Colors.red,
                            duration: Duration(milliseconds: 3000),
                          ));
                        }



                      }

                  ),
                ),
              )


            ],
          ),
        )
        ]
      ),
      )
    );
  }

  ///TODO:
  //show reminder popup
  Future showReminderPopup() {
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
                title: Row(
                  children: [
                    IconButton(
                      onPressed: ()=>Navigator.pop(context),
                      icon: Icon(Icons.close),
                    ),
                    SizedBox(width: 30,),
                    Text('Set Reminder',
                      style: TextStyle(
                          color: AppColors.blue
                      ),
                    ),
                  ],
                ),
                content: SingleChildScrollView(
                  child: ListBody(
                    children:  <Widget>[
                      TextFormField(
                        controller: reminderName,
                        decoration: InputDecoration(
                            hintText: "Remainder Name",
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
                      SizedBox(height: 20,),
                      TextFormField(
                        controller: reminderText,
                        maxLines: 4,
                        decoration: InputDecoration(
                            hintText: "Type...",
                            filled: true,
                            fillColor: Colors.grey.shade200,
                            contentPadding: EdgeInsets.only(left: 15, top: 15, right: 15),
                            focusedBorder:OutlineInputBorder(
                              borderSide:  BorderSide.none,
                              borderRadius: BorderRadius.circular(5.0),

                            ),
                            border:OutlineInputBorder(
                              borderSide:  BorderSide.none,
                              //borderSide: const BorderSide(color: AppColors.blue, width: 1.0),
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            enabledBorder:OutlineInputBorder(
                              borderSide:  BorderSide.none,
                              //borderSide: const BorderSide(color: AppColors.blue, width: 1.0),
                              borderRadius: BorderRadius.circular(5.0),
                            )
                        ),
                      ),
                      SizedBox(height: 30,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
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
                                onClick: ()async{
                                  Random random = new Random();
                                  int id = random.nextInt(100);
                                  Map<String, dynamic> data = {
                                    "reminder_id" : id.toString(),
                                    "reminder_name" : reminderName.text,
                                    "reminder_text" : reminderText.text,
                                    "reminder_time" : _reminderTime,
                                  };

                                  setState((){
                                    allReminders.add(data);
                                    print("this is outFitList ${allReminders}");
                                    print("this is outFitList ${data}");
                                    reminderText.clear();
                                    reminderName.clear();
                                  });

                                  setState(()=>Navigator.pop(context));
                                }
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

  //show reminder time popup
  Future<void> shoReminderTimePopup({required int index,  required String id, required String name, required String text}) async {
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
                    Text('Set Reminder Time',
                      style: TextStyle(
                          color: AppColors.blue
                      ),
                    ),
                    IconButton(
                      onPressed: (){
                        var item = allReminders.firstWhere((i) => i["reminder_id"] == id); // getting the item
                        var index = allReminders.indexOf(item); // Item index
                        allReminders[index] ={
                          "reminder_id": id,
                          "reminder_name": name,
                          "reminder_text": text,
                          "reminder_time": _reminderTime,
                        }; // replace item at the index
                        print("allReminders true");
                        print("allReminders true ${allReminders}");


                       var formetedDateTime = "${reminderAlarmDate} ${reminderAlarmTime}";
                       // var formetedDateTime = DateTime.now().toString();
                        print("this is remider date and time === ${formetedDateTime}");


                        NotificationServices.showNotification(
                            id: int.parse(id),
                            title: "Hey! Today you have a date with ${selectedAdmirerProfiles["name"]}",
                            body: "Today you have a date with ${selectedAdmirerProfiles["name"]}\n Location: ${location.text}",
                            interval: DateTime.parse("$formetedDateTime"));

                        debugPrint("this is notification times ===${formetedDateTime} ");



                        setState(() => Navigator.pop(context));

                      },
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
                          _reminderTime = DateFormat('hh:mm a').format(time);
                          reminderAlarmTime = "${time.hour}:${time.minute}:${time.second}";
                          debugPrint("this is reminder time === ${reminderAlarmTime}");

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




  //show admirer profiles
  Future<void> showAdmirers() async {

    //empty admirer model list
    List<AdmirerModel> shortedData = [];
    for(var i = 0; i<  Boxes.getAdmirers.length; i++){
      var data =  Boxes.getAdmirers.getAt(i);
      if(data?.userId == userToken.toString()){
        shortedData.add(data!);
      }
    }



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
                    Boxes.getAdmirers.length != 0? ListView.builder(
                      shrinkWrap: true,
                      itemCount:  shortedData.length,
                      itemBuilder: (_, index){

                        return InkWell(
                          onTap: (){

                          setState((){
                            selectedAdmirerProfiles.clear();
                            selectedAdmirerProfiles.addAll({
                              "id": shortedData[index]!.id,
                              "name" : shortedData[index]!.admirerName,
                              "profile" : shortedData[index]!.profile,
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
                                      child: Image.memory(shortedData[index]!.profile,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 10,),
                                  Text(shortedData[index]!.admirerName,
                                    style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  )
                                ],
                              )),
                        );
                      },

                    ):Center(child: Text("No Admirer Profile."),),

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
                )
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
        reminderAlarmDate = DateFormat('yyyy-MM-dd').format(picked);
        selectedDate = DateFormat.yMMMd().format(picked);
        date.text = selectedDate;
        print("this is date === ${date.text}");
        print("this is date === ${picked}");
      });
  }

  //show Outfit popup
 Future showOutfitPopup() {
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
                            onClick: ()async{

                              Navigator.pop(context);
                            }
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
                             onClick: ()async{
                               Uint8List outFitImage = await outfitImage.readAsBytes();
                               Map<String, dynamic> data = {
                                 "outfit_name" : outfitName.text,
                                 "outfit_image" : outFitImage,
                               };

                               setState((){
                                 outFitList.add(data);
                                 print("this is outFitList ${outFitList}");
                                 print("this is outFitList ${data}");
                                 outfitName.clear();

                               });
                               setState(()=>Navigator.pop(context));
                             }
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


  //show Outfit popup
  Future showPurseCheckPopup() {
    var size = MediaQuery.of(context).size;
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return StatefulBuilder(
            builder: (context, setState) {
              return AlertDialog(
                contentPadding: EdgeInsets.only(left: 20, right: 20, top: 0, bottom: 20),
                titlePadding: EdgeInsets.zero,
                actionsPadding: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(32.0))),
                title: const Text(''),
                content: SingleChildScrollView(
                  child: ListBody(
                    children:  <Widget>[
                      Text('Items Name:',
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: AppColors.blue
                        ),
                      ),
                      SizedBox(height: 15,),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(width: 1, color: AppColors.blue),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 50, height: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: AppColors.blue.withOpacity(0.4),
                              ),
                              child: Center(child: Icon(Icons.add)),
                            ),
                            SizedBox(
                              width: size.width*0.45,
                              child: TextFormField(
                                controller: purseCheckText,
                                decoration: InputDecoration(
                                    hintText: "Add Item",
                                    contentPadding: EdgeInsets.only(left: 15, right: 15),
                                    focusedBorder:OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                    ),
                                    border:OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                    ),
                                    enabledBorder:OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                    )
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 20,),
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
                                onClick: ()async{

                                  Navigator.pop(context);
                                }
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
                                onClick: ()async{
                                  Uint8List outFitImage = await outfitImage.readAsBytes();
                                  Map<String, dynamic> data = {
                                    "name" : purseCheckText.text,
                                  };

                                  setState((){
                                    purseCheck.add(data);
                                    print("this is outFitList ${purseCheck}");
                                    print("this is outFitList ${data}");
                                    purseCheckText.clear();

                                  });
                                  setState(()=>Navigator.pop(context));
                                }
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
      print("image === ${outfitImageStr}");
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


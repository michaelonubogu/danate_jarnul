import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'package:dante/view/dates/add_dates.dart';
import 'package:intl/intl.dart';
import 'package:dante/boxs/boxs.dart';
import 'package:dante/controller/auth_controller/auth_controller.dart';
import 'package:dante/model/admirers_model/admirers_model.dart';
import 'package:dante/utility/app_colors.dart';
import 'package:dante/view/admirer/admirers.dart';
import 'package:date_format_field/date_format_field.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

import '../../utility/app_button.dart';
import '../index.dart';

class AddAdmirerProfile extends StatefulWidget {
  final bool isBack;
  const AddAdmirerProfile({Key? key,  this.isBack = false}) : super(key: key);

  @override
  State<AddAdmirerProfile> createState() => _AddAdmirerProfileState();
}

class _AddAdmirerProfileState extends State<AddAdmirerProfile> {
  List socialImage = [
    "assets/icons/fb.png",
    "assets/icons/insta.png",
    "assets/icons/twitter.png",
    "assets/icons/twitter.png",
  ];

  List myLikes = [];
  List myDisLikes = [];
  int myLikesCount = 1;
  int myDisLikesCount = 1;

  final socialMediaFormKey = GlobalKey<FormState>();


  //image picker global variable
  final ImagePicker _picker = ImagePicker(); // this is Come from Image Picker Livery
  //it help use to take images

  double _value = 30.0;

  String? zodiacSelectedValue;

  final List<String> zodiacList = [
    'Cancer',
    'Sagittarius',
    'Leo',
    'Libra',
    'Gemini',
    'Taurus',
    'Virgo',
    'Pisces',
    'Aquarius',
    'Aries',
    'Capricorn',
    'Scorpio'
  ];

  final List<String> items = [
    'Facebook',
    'Instagram',
    'Twitter',
    'Tik-tok',
  ];
  String? selectedValue;

  //text editing controller
  final dob = TextEditingController();
  final admirerName = TextEditingController();
  final zodiac_sign = TextEditingController();
  final description = TextEditingController();
  final my_likes = TextEditingController();
  final my_dislikes = TextEditingController();
  final socialLink = TextEditingController();

  List likeInputList = [''];
  List dislikeInputList = [''];
  //store variables
  var choose, profile;
  List feature_images = [];
  List<Map> socialMediaList = [];



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
        // leading: Container(
        //   width: 40, height: 40,
        //   margin: EdgeInsets.only(left: 10, top: 5, bottom: 5),
        //   decoration: BoxDecoration(
        //     color: Colors.grey.shade200,
        //     borderRadius: BorderRadius.circular(5),
        //   ),
        //   child: Center(child: Icon(Icons.arrow_back_ios, size: 20, color: AppColors.textColor,)),
        // ),
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
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Container(
            //   width: size.width,
            //   height: 60,
            //   decoration: BoxDecoration(
            //     color: AppColors.bgColor,
            //   ),
            //   child: Row(
            //     children: [
            //       Container(
            //         width: 40, height: 40,
            //         padding: EdgeInsets.only(left: 12, right: 10),
            //         decoration: BoxDecoration(
            //           color: Colors.grey.shade200,
            //           borderRadius: BorderRadius.circular(5),
            //         ),
            //         child: Center(child: Icon(Icons.arrow_back_ios, color: Colors.black,)),
            //       ),
            //       SizedBox(width: size.width*.25,),
            //       Text("Add Profile",
            //         style: TextStyle(
            //             fontSize: 20,
            //             fontWeight: FontWeight.w600,
            //             color: Colors.black
            //         ),
            //       ),
            //     ],
            //   ),
            // )

            //Upload profile image section
            Align(
                alignment: Alignment.center,
                child: Container(
                  height: 130,
                   width: 130,
                  //padding: EdgeInsets.all(40),
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(100)
                  ),
                  child:  InkWell(
                    onTap: ()=>openBottomSheet(),
                    child: ClipRRect(
                       borderRadius: BorderRadius.circular(100),
                        child: profileImage != null
                            ? Image.file(profileImage, height: 130, width: 130, fit: BoxFit.cover,)
                            :  Padding(
                                padding: EdgeInsets.all(40),
                                child: Image.asset("assets/icons/upload_images.png", height: 40, width: 40, )
                            )
                    ),
                  ),

                ),
            ),
            SizedBox(height: 20,),
            Center(
              child: Text("Add Profile Picture",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(height: 20,),
            feature_images.length != 0
                ? SizedBox(
              height: 100,
                  child: ListView.builder(
                    shrinkWrap: true,
                scrollDirection: Axis.horizontal,
              itemCount: feature_images.length,
              itemBuilder: (_, index){
                  return Container(
                      margin: EdgeInsets.only(right: 10),
                      width: 100, height: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Stack(
                        clipBehavior: Clip.hardEdge,
                        children: [
                          Positioned(bottom: 0,
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                   child: Image.file(feature_images[index],width: 100, height: 95, fit: BoxFit.cover,))),
                          Positioned(
                              right: 0, top: -0,
                              child: InkWell(
                                onTap: (){
                                  //remove index from list
                                  feature_images.removeAt(index);
                                  setState(() {});
                                },
                                child: Container(
                                    padding: EdgeInsets.all(3),
                                    //transform: Matrix4.translationValues(0.0, -0.0, 0.0),
                                    decoration: BoxDecoration(
                                      color: AppColors.white,
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                    child: Icon(IconlyLight.delete, color: Colors.red, size: 15,)),
                              )),
                        ],
                      ));
              },
            ),
                ) : SizedBox(),
            SizedBox(height: 10,),
            Align(
              alignment: Alignment.center,
              child: Container(
                height: 100,
                width: 160,
                //padding: EdgeInsets.all(40),
                decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(10)
                ),
                child:  InkWell(
                  onTap: ()=>uploadFeatureImage(),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child:   Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(Icons.add),
                              Text("Feature Photo",
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          )
                  ),
                ),

              ),
            ),

            SizedBox(height: 50,),

            Text("Name",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 15,),
            TextFormField(
              controller: admirerName,
              decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: "Name",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none
                  )
              ),
            ),
            SizedBox(height: 30,),
            // Text("Date of Birth",
            //   style: TextStyle(
            //     fontSize: 16,
            //     fontWeight: FontWeight.w600,
            //   ),
            // ),
            //
            // SizedBox(height: 15,),
            // TextFormField(
            //   onTap: ()=>selectDate(),
            //   readOnly: true,
            //   controller: dob,
            //   decoration: InputDecoration(
            //       filled: true,
            //       fillColor: Colors.white,
            //       hintText: "YYYY-MM-DD",
            //       border: OutlineInputBorder(
            //           borderRadius: BorderRadius.circular(10),
            //           borderSide: BorderSide.none
            //       )
            //   ),
            // ),
            //
            // SizedBox(height: 30,),

            Text("Zodiac Sign",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 15,),
            // TextFormField(
            //   controller: zodiac_sign,
            //   decoration: InputDecoration(
            //       filled: true,
            //       fillColor: Colors.white,
            //       hintText: "Choose Sign",
            //       border: OutlineInputBorder(
            //           borderRadius: BorderRadius.circular(10),
            //           borderSide: BorderSide.none
            //       )
            //   ),
            // ),
            Container(
              width: size.width,
              height: 60,
              padding: EdgeInsets.only(left: 15, right: 15),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(10)
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton2(
                  hint: Text(
                    'Select Zodiac',
                    style: TextStyle(
                      fontSize: 16,
                      color: Theme.of(context).hintColor,
                    ),
                  ),
                  items: zodiacList
                      .map((item) => DropdownMenuItem<String>(
                    value: item,
                    child: Text(
                      item,
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  )).toList(),


                  value: zodiacSelectedValue,
                  onChanged: (value) {
                    setState(() {
                      zodiacSelectedValue = value as String;
                      zodiac_sign.text = zodiacSelectedValue!;
                    });
                  },
                  buttonStyleData: const ButtonStyleData(
                    height: 40,
                    width: 140,
                  ),
                  menuItemStyleData: const MenuItemStyleData(
                    height: 40,
                  ),
                ),
              ),
            ),

            SizedBox(height: 30,),
            Row(
              children: [
                Icon(Icons.favorite, color: Colors.grey.shade400,),
                Container(
                  width: size.width*.70,
                  child: SfSlider(
                    min: 0,
                    max: 75,
                    showLabels: true,
                    thumbIcon: Icon(Icons.favorite, color: AppColors.mainColor,),
                    showDividers: true,
                    interval: 25,
                    value: _value,
                    labelPlacement: LabelPlacement.onTicks,
                    labelFormatterCallback:
                        (dynamic actualValue, String formattedText) {
                      switch (actualValue) {
                        case 0:
                          return 'Meh';
                        case 25:
                          return 'Ok';
                        case 50:
                          return 'Cute';
                        case 75:
                          return 'Sexy';

                      }
                      return actualValue.toString();
                    },
                    onChanged: (dynamic newValue) {
                      setState(
                            () {
                          _value = newValue;
                          print("this value === $_value");
                        },
                      );
                    },
                  ),
                ),
                Icon(Icons.favorite, color: AppColors.mainColor,),
              ],
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
              controller: description,
              maxLines: 4,
              decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: "Enter bio about the person...",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none
                  )
              ),
            ),

            SizedBox(height: 30,),

            Text("My Likes",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 15,),
            for(var i=0; i<likeInputList.length; i++)
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: TextFormField(
                  onChanged: (val){
                    likeInputList[i] = val;
                    print("likeInputList === ${likeInputList}");
                  },
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: "Enter text here",
                      contentPadding: EdgeInsets.only( right: 10, top: 15, bottom: 15),
                      prefixIcon: InkWell(
                        onTap:(){
                          setState(() {
                            likeInputList.add('');
                          });
                        },
                        child: Container(
                          margin: EdgeInsets.all(3),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: AppColors.mainColor.withOpacity(0.6),
                          ),
                          child: Icon(Icons.add),
                        ),
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none
                      )
                  ),
                ),
              ),

            SizedBox(height: 30,),
            Text("My Dislikes",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 15,),
            for(var i=0; i<dislikeInputList.length; i++)
              Padding(
                padding: EdgeInsets.only(bottom: 8),
                child: TextFormField(
                  onChanged: (val){
                    dislikeInputList[i]= val;
                  },
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: "Enter text here",

                      contentPadding: EdgeInsets.only( right: 10, top: 15, bottom: 15),
                      prefixIcon: InkWell(
                        onTap:(){
                          setState(() {
                            dislikeInputList.add('');
                          });
                        },
                        child: Container(
                          margin: EdgeInsets.all(3),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: AppColors.blue.withOpacity(0.6),
                          ),
                          child: Icon(Icons.add),
                        ),
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none
                      )
                  ),
                ),
              ),



            SizedBox(height: 30,),

            Text("Social Media",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 15,),
            Container(
              width: size.width,
              height: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey.shade300
              ),
              child: socialMediaList.length != 0
                  ? SizedBox(height: 50,
                      child: Padding(
                        padding: EdgeInsets.only(left: 30, right: 30),
                        child:  ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: socialMediaList.length,
                          itemBuilder: (_, index){
                            return InkWell(
                              onTap: (){
                                socialMediaList.removeAt(index);
                                setState(() {});
                              },
                              child: Container(
                                    height: 40,
                                  margin: EdgeInsets.only(right: 10),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        socialMediaList[index]["name"].contains("Facebook")
                                             ? "assets/icons/fb.png"
                                             :  socialMediaList[index]["name"].contains("Instagram")
                                             ? "assets/icons/insta.png"
                                             : socialMediaList[index]["name"].contains("Twitter")
                                             ? "assets/icons/twitter.png"
                                             : socialMediaList[index]["name"].contains("Tik-tok")
                                             ? "assets/icons/tiktok.png"
                                              : "assets/icons/fb.png" ,
                                        height: 40, width: 40,),
                                      Icon(Icons.remove, color: Colors.red, size: 12,),
                                    ],
                                  )
                                ),
                            );
                          },
                        ),
                      )
                   )
                  :Center(child: Text("Add social media link",style: TextStyle(color: AppColors.textColor),),),
            ),

            SizedBox(height: 30,),
            InkWell(
              onTap: ()=>_addSocialMedia(size),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: AppColors.mainColor
                      ),
                      child: Icon(Icons.add, color: Colors.white,)),
                  SizedBox(width: 10,),
                  Text("Add Account",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: AppColors.textColor),
                  )
                ],
              ),
            ),

            SizedBox(height: 30,),

            AppButton(
              onClick: ()async{
                //get user id
                SharedPreferences prefs = await SharedPreferences.getInstance();
                var userToken = await prefs.getString("token");
                print("user token ==== $userToken");
                //id
                var id = new Random().nextInt(1000);

                //image convert
                Uint8List _profileImage = await profileImage.readAsBytes();


                var data = AdmirerModel(
                    id: id,
                    admirerName: admirerName.text,
                    userId: userToken.toString(),
                    profile: _profileImage,
                    featureImages: _featureImage ,
                    dob: "remove by client",
                    zodiacSign: zodiac_sign.text,
                    rate: _value,
                    description: description.text,
                    myLikes: likeInputList,
                    myDislikes: dislikeInputList,
                    socialMedia: socialMediaList,
                    datesCount: 0,
                );
               var box = await Boxes.getAdmirers;
                box.put("$id",data);
                widget.isBack
                    ? Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>AddDates()))
                    : Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Index(index: 1,)));
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text("New Admirers Profile Added!"),
                  backgroundColor: Colors.green,
                  duration: Duration(milliseconds: 3000),
                ));
                if(kDebugMode){
                  print("admirer added");
                }



              },//rout the next login pages
              size: size,
              child: Text("Save Admirer",
                style: TextStyle(
                    fontSize: 15, color: Colors.white, fontWeight: FontWeight.w500
                ),
              ),
            ),
            SizedBox(height: 30,),
          ],
        ),
      ),
    );
  }




  //Open bottomsheet for select the method to upload images.
  Future openBottomSheet(){
   return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: new Icon(Icons.photo),
                title: new Text('Gallery'),
                onTap: () {
                  uploadProfile(ImageSource.gallery); //it will take one parameter
                },
              ),

              ListTile(
                leading: new Icon(Icons.camera_alt_outlined),
                title: new Text('Camera'),
                onTap: () {
                  uploadProfile(ImageSource.camera); //it will take one parameter
                },
              ),
            ],
          );
        });
  }
  //Like Camera or Gallery


  // this is profile image store variable
  var profileImage, profileImageStr;
  //this method going take images and save local variable

  void uploadProfile(type) async{ // its take one parameter
    var image = await _picker.pickImage(source: type);
    setState(() {
      profileImage = File(image!.path); // store the image path in this local variable
      profileImageStr = image;
    });
    Navigator.pop(context); //when image taken, it will be close bottom sheets.
  }
  List<Uint8List> _featureImage =  [];

  void uploadFeatureImage() async{ // its take one parameter
    var image = await _picker.pickMultiImage();
    for(var i in image){
      feature_images.add(File(i.path));
    }
    Future<Uint8List> fileToUint8List(File file) async {
      Uint8List bytes = await file.readAsBytes();
      _featureImage.add(bytes);
      print("Feature Images == $_featureImage");
      return bytes;
    }
    for (var i in feature_images) {
      fileToUint8List(i);
      // _featureImage.add(i!.path.readAsBytes());
    }




    setState(() {});
    //Navigator.pop(context); //when image taken, it will be close bottom sheets.
  }



  //this method show the popup for add social media
  Future _addSocialMedia(size) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              titlePadding: EdgeInsets.zero,
              iconPadding: EdgeInsets.zero,
              buttonPadding: EdgeInsets.zero,
              insetPadding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),

              actionsPadding: EdgeInsets.zero,
             // contentPadding: EdgeInsets.all(10),
              content: SingleChildScrollView(
                child: Form(
                  key: socialMediaFormKey,
                  child: ListBody(
                    children:  <Widget>[
                      Text('Choose media',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 17,
                          color: AppColors.blue
                        ),
                      ),
                      SizedBox(height: 15,),
                      Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: AppColors.blue, width: 1)
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton2(
                            hint: Text(
                              'Select Item',
                              style: TextStyle(
                                fontSize: 14,
                                color: Theme.of(context).hintColor,
                              ),
                            ),
                            items: items
                                .map((item) => DropdownMenuItem<String>(
                              value: item,
                              child: Text(
                                item,
                                style: const TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                            ))
                                .toList(),
                            value: selectedValue,
                            onChanged: (value) {
                              setState(() {
                                selectedValue = value as String;

                              });
                            },
                            buttonStyleData: const ButtonStyleData(
                              height: 40,
                              width: 140,
                            ),
                            menuItemStyleData: const MenuItemStyleData(
                              height: 40,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 30,),
                      Text('Profile link',
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 17,
                            color: AppColors.blue
                        ),
                      ),
                      SizedBox(height: 15,),
                      TextFormField(
                        controller: socialLink,
                        validator: (value)=>RegExp(r"^(http:\/\/www\.|https:\/\/www\.|http:\/\/|https:\/\/)?[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?$").hasMatch(value!)?null:'Invalid url',
                        decoration: InputDecoration(
                            filled: true,
                            contentPadding: EdgeInsets.only(left: 5, right: 5, top: 5, bottom: 5),
                            fillColor: Colors.white,
                            hintText: "Choose Sign",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(0),
                                borderSide: BorderSide(
                                    color: AppColors.blue)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color:
                              AppColors.blue)),
                          enabledBorder: OutlineInputBorder(
                            borderSide:  BorderSide(color:
                            AppColors.blue),
                          ),
                        ),
                      ),


                      SizedBox(height: 20,),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AppButton(
                            onClick: ()=>Navigator.pop(context), //rout the next login pages
                            size: size*.25,
                            bg: Colors.grey.shade300,
                            child: Text("Cancel",
                              style: TextStyle(
                                  fontSize: 15, color:AppColors.textColor, fontWeight: FontWeight.w500
                              ),
                            ),
                          ),
                          AppButton(
                            onClick: (){
                              if(socialMediaFormKey.currentState!.validate()){
                                socialMediaList.add(
                                  {
                                    "name" : selectedValue,
                                    "link" : socialLink.text,
                                  },
                                );
                                setState((){

                                });
                                socialLink.clear();
                                Navigator.pop(context);
                              }

                            }, //rout the next login pages
                            size: size*.25,
                            child: Text("Save",
                              style: TextStyle(
                                  fontSize: 15, color:AppColors.white, fontWeight: FontWeight.w500
                              ),
                            ),
                          )
                        ],
                      ),

                      SizedBox(height: 10,),

                    ],
                  ),
                ),
              ),

            );
          }
        );
      },
    );
  }

  var selectedDate;
  Future selectDate() async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1920, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
       var data = "${selectedDate.toLocal()}".split(' ')[0];
        dob.text =  DateFormat('MM-dd-yyyy').format(DateTime.parse(data));
        print("dob.text ${dob.text}");
      });
  }


}

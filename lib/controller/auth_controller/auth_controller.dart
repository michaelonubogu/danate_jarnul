import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:dante/boxs/boxs.dart';
import 'package:dante/database/local_database.dart';
import 'package:dante/model/profile_model/profile_model.dart';
import 'package:dante/view/auth/ask_qustion/niceto_meet.dart';
import 'package:dante/view/auth/login.dart';
import 'package:dante/view/index.dart';
import 'package:dante/view/profile/profile.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:get/get.dart';

import '../../view/auth/verify_success.dart';


class AuthController{

  //this method for store user data
  static Future initData(data)async{
   var userDB = await LocalDatabases.INITIAL_DATA;
   //await userDB.delete("initial_Data");
   await userDB.put("initial_Data", data);//insert data
   // Prints the map data.
  }

  //this method for show inital data
  static Future showInitData()async{
   var userDB = await LocalDatabases.INITIAL_DATA;
   final retrievedData = await userDB.get('initial_Data');
   print("this is initial data === $retrievedData");
   return retrievedData;
  }


  //this method for store email verify data
  static Future emailVerify(data, context)async{
    print("data === $data");
    var res = await LocalDatabases.EMAIL_VERIFY;
    //await userDB.delete("initial_Data");
    await res.add(data);//insert data
    //redirect otp verification page
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>VerifySuccess()), (route) => false);
    // Prints the map data.
  }



  // Edit profile
  static Future editProfile(fname, lname, dob, email, image, userid, context)async{
    var res = await Boxes.getProfile;
   // await res.put("user_profile", data);//insert data
    var _image;
    if(image != null){
       _image = await image.readAsBytes();
    }else{
       _image = null;
    }

    var id = new Random().nextInt(1000);
    var data = ProfileModel(
        userId: userid.toString(),
        id: id.toString(),
        email: email,
        dob: dob,
        profile: image !=null ? _image : image,
        fName: fname,
        lName: lname
    );

    await res.put("$userid", data);//insert data
    //redirect otp verification page
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("Profile Updated!"),
      backgroundColor: Colors.green,
      duration: Duration(milliseconds: 3000),
    ));

    // final retrievedData = await res.get('profile_info');
    // print("this profile === ${Uint8List.fromList(retrievedData!["profile"])}");
    Get.to(Index(index: 3,), transition: Transition.leftToRight);
    // Prints the map data.
  }

  //this method for store user data
  static Future showProfile()async{
    var res = await LocalDatabases.PROFILE;
    final retrievedData = await res.get('profile_info');
    print("this is profiles === $retrievedData");
    return retrievedData;
  }


}


class ImageObject extends HiveObject {
  late List<int> bytes;
}
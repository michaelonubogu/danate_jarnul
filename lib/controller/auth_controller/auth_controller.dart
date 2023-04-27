import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:dante/database/local_database.dart';
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

  //this method for store email verify data
  static Future logout(data, context)async{
    var res = await LocalDatabases.EMAIL_VERIFY;
    //await userDB.delete("initial_Data");
    await res.put("email_verify", data);//insert data
    //redirect otp verification page
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>Login()), (route) => false);
    // Prints the map data.
  }
  //this method for store user data
  static Future showEmailVerify()async{
    var res = await LocalDatabases.EMAIL_VERIFY;
    final retrievedData = await res.get('dsdasfdas');
    print("this is email verify === $retrievedData");
    return retrievedData;
  }




  // Edit profile
  static Future editProfile(fname, lname, dob, email, image, userid, context)async{
    var res = await LocalDatabases.PROFILE;
   // await res.put("user_profile", data);//insert data

    List<int> imageBytes = await image.readAsBytes();
    ImageObject imageObject = ImageObject()
      ..bytes = imageBytes;

    Uint8List _image = await image.readAsBytes();
    var id = new Random().nextInt(1000);
    var data = {
      "user_id": userid,
      "id" : "$id",
      "f_name" : fname,
      "l_name" : lname,
      "dob" : dob,
      "email" : email,
      "profile" : _image
    };

    await res.put("profile_info", data);//insert data
    print("print profile edit data === $data");
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
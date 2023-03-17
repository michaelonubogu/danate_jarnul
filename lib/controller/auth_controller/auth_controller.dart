import 'dart:io';

import 'package:dante/database/local_database.dart';
import 'package:dante/view/auth/ask_qustion/niceto_meet.dart';
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
   return retrievedData;
  }


  //this method for store email verify data
  static Future emailVerify(data)async{
    print("data === $data");
    var res = await LocalDatabases.EMAIL_VERIFY;
    //await userDB.delete("initial_Data");
    await res.put("email_verify", data);//insert data
    //redirect otp verification page
    Get.to(VerifySuccess(), transition: Transition.leftToRight);
    // Prints the map data.
  }

  //this method for store user data
  static Future showEmailVerify()async{
    var res = await LocalDatabases.EMAIL_VERIFY;
    final retrievedData = await res.get('email_verify');
    print("this is email verify === $retrievedData");
    return retrievedData;
  }

}
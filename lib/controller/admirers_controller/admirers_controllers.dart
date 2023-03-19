import 'package:dante/database/local_database.dart';
import 'package:dante/model/admirers_model/admirers_model.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class AdmirersController{
  // Storing a list of objects in Hive
  static Future saveListOfObjects(admirerProfile) async {
    final admirersDB = await LocalDatabases.ADMIRER_PROFILE;
    final jsonList = admirerProfile.map((e) => e.toJson()).toList();
    admirersDB.put('admirers', jsonList);
    getListOfObjects();
  }

  // Retrieving a list of objects from Hive
  static Future<List<AdmirerModel>> getListOfObjects() async {
    final admirersDB = await LocalDatabases.ADMIRER_PROFILE;
    final jsonList = admirersDB.get('admirers', defaultValue: []) as List<String>;
    print("this is admirer ==== $jsonList");
    return jsonList.map((e) => AdmirerModel.fromJson(e as Map<String, dynamic>)).toList();
  }
}
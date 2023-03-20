import 'package:dante/database/local_database.dart';
import 'package:dante/model/admirers_model/admirers_model.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class AdmirersController{
  // Storing a list of objects in Hive
  static Future saveListOfObjects( admirerProfile) async {
    final admirersDB = await LocalDatabases.ADMIRER_PROFILE;
    admirersDB.add(admirerProfile);
    getListOfObjects();
  }

  // Retrieving a list of objects from Hive
  static Future getListOfObjects() async {
    final admirersDB = await LocalDatabases.ADMIRER_PROFILE;
  }
}
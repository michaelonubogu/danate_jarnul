import 'dart:convert';
import 'package:dante/model/profile_model/profile_model.dart';
import 'package:hive/hive.dart';
part 'dates_screen_model.g.dart';

@HiveType(typeId: 3)
class DatesModel extends HiveObject{

  DatesModel({
    required this.id,
    required this.token,
    required this.title,
    required this.admirer,
    required this.description,
    required this.date,
    required this.time,
    required this.location,
    required this.outfit,
    required this.reminders,
    required this.purses,
    required this.userProfile
  });



  @HiveField(0)
  final int id;

  @HiveField(1)
  final dynamic token;

  @HiveField(2)
  final dynamic title;

  @HiveField(3)
  final Map<String, dynamic> admirer;


  @HiveField(4)
  final String description;

  @HiveField(5)
  final String date;

  @HiveField(6)
  final String time;

  @HiveField(7)
  final Map<String, dynamic> location;

  @HiveField(8)
  final List<Map<String, dynamic>> outfit;

  @HiveField(9)
  final List<Map<String, dynamic>> reminders;

  @HiveField(10)
  final List<Map<String, dynamic>> purses;

  @HiveField(11)
  final ProfileModel userProfile;

}
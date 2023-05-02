import 'dart:convert';
import 'package:hive/hive.dart';
part 'dates_screen_model.g.dart';

@HiveType(typeId: 3)
class DatesModel extends HiveObject{

  DatesModel({
    required this.id,
    required this.title,
    required this.admirer,
    required this.description,
    required this.date,
    required this.time,
    required this.location,
    required this.outfit,
    required this.reminders,
    required this.purses,
  });



  @HiveField(0)
  final int id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final Map<String, dynamic> admirer;


  @HiveField(3)
  final String description;

  @HiveField(4)
  final String date;

  @HiveField(5)
  final String time;

  @HiveField(6)
  final String location;

  @HiveField(7)
  final List<Map<String, dynamic>> outfit;

  @HiveField(8)
  final List<Map<String, dynamic>> reminders;

  @HiveField(9)
  final List<Map<String, dynamic>> purses;

}
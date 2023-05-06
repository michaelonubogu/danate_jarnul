import 'dart:ui';

import 'package:dante/model/admirers_model/admirers_model.dart';
import 'package:hive/hive.dart';

part'journal_model.g.dart';
@HiveType(typeId: 6)
class JournalModel extends HiveObject{

  @HiveField(0)
  final String id;

  @HiveField(1)
  final String token;

  @HiveField(2)
  final String title;

  @HiveField(3)
  final dynamic color;

  @HiveField(4)
  final String details;

  @HiveField(5)
  final Map<String, dynamic> admirers;

  @HiveField(6)
  final String dateTime;


  JournalModel({
    required this.id,
    required this.token,
    required this.title,
    required this.admirers,
    required this.details,
    required this.dateTime,
    required this.color
});

}
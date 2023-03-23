import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
part 'admirers_model.g.dart';

@HiveType(typeId: 2)
class AdmirerModel extends HiveObject{
  AdmirerModel({
    required this.id,
    required this.userId,
    required this.profile,
    required this.featureImages,
    required this.dob,
    required this.zodiacSign,
    required this.rate,
    required this.description,
    required this.myLikes,
    required this.myDislikes,
    required this.socialMedia,
  });

  @HiveField(0)
  final int id;
  @HiveField(1)
  final String userId;
  @HiveField(2)
  final dynamic profile;
  @HiveField(3)
  final List<Uint8List> featureImages;
  @HiveField(4)
  final String dob;
  @HiveField(5)
  final String zodiacSign;
  @HiveField(6)
  final double rate;
  @HiveField(7)
  final String description;
  @HiveField(8)
  final List myLikes;
  @HiveField(9)
  final List myDislikes;
  @HiveField(10)
  final List<Map> socialMedia;

}


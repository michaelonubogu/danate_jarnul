import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
part 'admirers_model.g.dart';

@HiveType(typeId: 2)
class AdmirerModel extends HiveObject{
  AdmirerModel({
    required this.id,
    required this.admirerName,
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
  final String admirerName;
  @HiveField(2)
  final String userId;
  @HiveField(3)
  final dynamic profile;
  @HiveField(4)
  final List<Uint8List> featureImages;
  @HiveField(5)
  final String dob;
  @HiveField(6)
  final String zodiacSign;
  @HiveField(7)
  final double rate;
  @HiveField(8)
  final String description;
  @HiveField(9)
  final List myLikes;
  @HiveField(10)
  final List myDislikes;
  @HiveField(11)
  final List<Map> socialMedia;

}


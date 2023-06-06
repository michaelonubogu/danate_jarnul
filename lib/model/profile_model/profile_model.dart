import 'dart:typed_data';

import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'profile_model.g.dart';

@HiveType(typeId: 4)
class ProfileModel extends HiveObject{

  ProfileModel({
   required this.userId,
   required this.id,
   required this.email,
   required this.dob,
   required this.profile,
    required this.fName,
    required this.lName
});


  @HiveField(0)
  final String userId;

  @HiveField(1)
  final String id;

  @HiveField(2)
  final String fName;

  @HiveField(3)
  final String lName;

  @HiveField(4)
  final String dob;

  @HiveField(5)
  final String email;

  @HiveField(6)
  final dynamic profile;


}
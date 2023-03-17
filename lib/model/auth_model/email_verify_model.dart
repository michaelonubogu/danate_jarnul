import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
part 'email_verify_model.g.dart';

@HiveType(typeId: 1)
class EmailVerifyModel extends HiveObject{
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String email;
  @HiveField(2)
  final bool isVerified;


  EmailVerifyModel({
    required this.id,
    required this.email,
    required this.isVerified,
  });


}

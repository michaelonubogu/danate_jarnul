import 'package:hive/hive.dart';
part 'email_verify_model.g.dart';

@HiveType(typeId: 1)
class LoginModel extends HiveObject{

  @HiveField(0)
  final int id;

  @HiveField(1)
  final String email;

  @HiveField(4)
  final dynamic token;

  @HiveField(2)
  final bool isVerified;

  @HiveField(3)
  final bool isLogin;
  //
  // @HiveField(4)
  // final String? token;


  LoginModel({
    required this.id,
    required this.email,
    required this.token,
    required this.isVerified,
    required this.isLogin,
     // this.token,
  });


}

import 'package:hive/hive.dart';
import '../model/admirers_model/admirers_model.dart';

class Boxes{

  //admirers boxes
  static Box<AdmirerModel> getAdmirers = Hive.box<AdmirerModel>("admirers");
  static Box<AdmirerModel> getProfile = Hive.box<AdmirerModel>("profile");

}
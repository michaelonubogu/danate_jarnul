import 'package:hive/hive.dart';
import '../model/admirers_model/admirers_model.dart';
import '../model/dates_model/dates_screen_model.dart';

class Boxes{

  //admirers boxes
  static Box<AdmirerModel> getAdmirers = Hive.box<AdmirerModel>("admirers");
  static Box<AdmirerModel> getProfile = Hive.box<AdmirerModel>("profile");
  static Box<DatesModel> getDates = Hive.box<DatesModel>("dates");

}
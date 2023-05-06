
import 'package:dante/model/auth_model/email_verify_model.dart';
import 'package:dante/model/journal_model/journal_model.dart';
import 'package:hive/hive.dart';
import '../model/admirers_model/admirers_model.dart';
import '../model/dates_model/dates_screen_model.dart';
import '../model/profile_model/profile_model.dart';

class Boxes{

  //admirers boxes
  static Box<LoginModel> getLogin = Hive.box<LoginModel>("login");
  static Box<AdmirerModel> getAdmirers = Hive.box<AdmirerModel>("admirers");
  static Box<ProfileModel> getProfile = Hive.box<ProfileModel>("profiles");
  static Box<DatesModel> getDates = Hive.box<DatesModel>("dates");
  static Box<JournalModel> getJournal = Hive.box<JournalModel>("journals");

}
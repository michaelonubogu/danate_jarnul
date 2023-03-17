import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
part 'initialData_model.g.dart';

@HiveType(typeId: 0)
class InitialDataModel extends HiveObject{
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final bool first_dating;
  @HiveField(3)
  final String last_relationship;
  @HiveField(4)
  final String loking_partner;
  @HiveField(5)
  final String next_relationship;
  @HiveField(6)
  final bool take_info;


  InitialDataModel({
    required this.id,
    required this.name,
    required this.first_dating,
    required this.last_relationship,
    required this.loking_partner,
    required this.next_relationship,
    required this.take_info
});




}

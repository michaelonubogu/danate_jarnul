// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dates_screen_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DatesModelAdapter extends TypeAdapter<DatesModel> {
  @override
  final int typeId = 3;

  @override
  DatesModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DatesModel(
      id: fields[0] as int,
      token: fields[1] as dynamic,
      title: fields[2] as dynamic,
      admirer: (fields[3] as Map).cast<String, dynamic>(),
      description: fields[4] as String,
      date: fields[5] as String,
      time: fields[6] as String,
      location: (fields[7] as Map).cast<String, dynamic>(),
      outfit: (fields[8] as List)
          .map((dynamic e) => (e as Map).cast<String, dynamic>())
          .toList(),
      reminders: (fields[9] as List)
          .map((dynamic e) => (e as Map).cast<String, dynamic>())
          .toList(),
      purses: (fields[10] as List)
          .map((dynamic e) => (e as Map).cast<String, dynamic>())
          .toList(),
      userProfile: fields[11] as ProfileModel,
    );
  }

  @override
  void write(BinaryWriter writer, DatesModel obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.token)
      ..writeByte(2)
      ..write(obj.title)
      ..writeByte(3)
      ..write(obj.admirer)
      ..writeByte(4)
      ..write(obj.description)
      ..writeByte(5)
      ..write(obj.date)
      ..writeByte(6)
      ..write(obj.time)
      ..writeByte(7)
      ..write(obj.location)
      ..writeByte(8)
      ..write(obj.outfit)
      ..writeByte(9)
      ..write(obj.reminders)
      ..writeByte(10)
      ..write(obj.purses)
      ..writeByte(11)
      ..write(obj.userProfile);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DatesModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

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
      title: fields[1] as String,
      admirer: (fields[2] as Map).cast<String, dynamic>(),
      description: fields[3] as String,
      date: fields[4] as String,
      time: fields[5] as String,
      location: fields[6] as String,
      outfit: (fields[7] as List)
          .map((dynamic e) => (e as Map).cast<String, dynamic>())
          .toList(),
      reminders: (fields[8] as List)
          .map((dynamic e) => (e as Map).cast<String, dynamic>())
          .toList(),
      purses: (fields[9] as List)
          .map((dynamic e) => (e as Map).cast<String, dynamic>())
          .toList(),
    );
  }

  @override
  void write(BinaryWriter writer, DatesModel obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.admirer)
      ..writeByte(3)
      ..write(obj.description)
      ..writeByte(4)
      ..write(obj.date)
      ..writeByte(5)
      ..write(obj.time)
      ..writeByte(6)
      ..write(obj.location)
      ..writeByte(7)
      ..write(obj.outfit)
      ..writeByte(8)
      ..write(obj.reminders)
      ..writeByte(9)
      ..write(obj.purses);
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

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'initialData_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class InitialDataModelAdapter extends TypeAdapter<InitialDataModel> {
  @override
  final int typeId = 0;

  @override
  InitialDataModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return InitialDataModel(
      id: fields[0] as int,
      name: fields[1] as String,
      first_dating: fields[2] as bool,
      last_relationship: fields[3] as String,
      loking_partner: fields[4] as String,
      next_relationship: fields[5] as String,
      take_info: fields[6] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, InitialDataModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.first_dating)
      ..writeByte(3)
      ..write(obj.last_relationship)
      ..writeByte(4)
      ..write(obj.loking_partner)
      ..writeByte(5)
      ..write(obj.next_relationship)
      ..writeByte(6)
      ..write(obj.take_info);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is InitialDataModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

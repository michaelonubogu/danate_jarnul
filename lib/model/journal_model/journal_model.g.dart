// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'journal_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class JournalModelAdapter extends TypeAdapter<JournalModel> {
  @override
  final int typeId = 6;

  @override
  JournalModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return JournalModel(
      id: fields[0] as String,
      token: fields[1] as String,
      title: fields[2] as String,
      admirers: (fields[5] as Map).cast<String, dynamic>(),
      details: fields[4] as String,
      dateTime: fields[6] as String,
      color: fields[3] as dynamic,
    );
  }

  @override
  void write(BinaryWriter writer, JournalModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.token)
      ..writeByte(2)
      ..write(obj.title)
      ..writeByte(3)
      ..write(obj.color)
      ..writeByte(4)
      ..write(obj.details)
      ..writeByte(5)
      ..write(obj.admirers)
      ..writeByte(6)
      ..write(obj.dateTime);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is JournalModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

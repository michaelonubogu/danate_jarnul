// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admirers_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AdmirerModelAdapter extends TypeAdapter<AdmirerModel> {
  @override
  final int typeId = 2;

  @override
  AdmirerModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AdmirerModel(
      id: fields[0] as int,
      admirerName: fields[1] as String,
      userId: fields[2] as String,
      profile: fields[3] as dynamic,
      featureImages: (fields[4] as List).cast<Uint8List>(),
      dob: fields[5] as String,
      zodiacSign: fields[6] as String,
      rate: fields[7] as double,
      description: fields[8] as String,
      myLikes: (fields[9] as List).cast<dynamic>(),
      myDislikes: (fields[10] as List).cast<dynamic>(),
      socialMedia: (fields[11] as List)
          .map((dynamic e) => (e as Map).cast<dynamic, dynamic>())
          .toList(),
      datesCount: fields[12] as dynamic,
    );
  }

  @override
  void write(BinaryWriter writer, AdmirerModel obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.admirerName)
      ..writeByte(2)
      ..write(obj.userId)
      ..writeByte(3)
      ..write(obj.profile)
      ..writeByte(4)
      ..write(obj.featureImages)
      ..writeByte(5)
      ..write(obj.dob)
      ..writeByte(6)
      ..write(obj.zodiacSign)
      ..writeByte(7)
      ..write(obj.rate)
      ..writeByte(8)
      ..write(obj.description)
      ..writeByte(9)
      ..write(obj.myLikes)
      ..writeByte(10)
      ..write(obj.myDislikes)
      ..writeByte(11)
      ..write(obj.socialMedia);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AdmirerModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

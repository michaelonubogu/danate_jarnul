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
      userId: fields[1] as String,
      profile: fields[2] as dynamic,
      featureImages: (fields[3] as List).cast<Uint8List>(),
      dob: fields[4] as String,
      zodiacSign: fields[5] as String,
      rate: fields[6] as double,
      description: fields[7] as String,
      myLikes: (fields[8] as List).cast<dynamic>(),
      myDislikes: (fields[9] as List).cast<dynamic>(),
      socialMedia: (fields[10] as List)
          .map((dynamic e) => (e as Map).cast<dynamic, dynamic>())
          .toList(),
    );
  }

  @override
  void write(BinaryWriter writer, AdmirerModel obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.userId)
      ..writeByte(2)
      ..write(obj.profile)
      ..writeByte(3)
      ..write(obj.featureImages)
      ..writeByte(4)
      ..write(obj.dob)
      ..writeByte(5)
      ..write(obj.zodiacSign)
      ..writeByte(6)
      ..write(obj.rate)
      ..writeByte(7)
      ..write(obj.description)
      ..writeByte(8)
      ..write(obj.myLikes)
      ..writeByte(9)
      ..write(obj.myDislikes)
      ..writeByte(10)
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

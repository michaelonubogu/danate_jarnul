// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'email_verify_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class EmailVerifyModelAdapter extends TypeAdapter<EmailVerifyModel> {
  @override
  final int typeId = 1;

  @override
  EmailVerifyModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return EmailVerifyModel(
      id: fields[0] as int,
      email: fields[1] as String,
      isVerified: fields[2] as bool,
      isLogin: fields[3] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, EmailVerifyModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.email)
      ..writeByte(2)
      ..write(obj.isVerified)
      ..writeByte(3)
      ..write(obj.isLogin);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EmailVerifyModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'doctor_hive.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DoctorHiveAdapter extends TypeAdapter<DoctorHive> {
  @override
  final int typeId = 1;

  @override
  DoctorHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DoctorHive(
      id: fields[0] as String,
      firstName: fields[1] as String,
      lastName: fields[2] as String,
      address: fields[3] as String?,
      phone: fields[4] as String?,
      email: fields[5] as String,
      username: fields[6] as String,
      profilePicture: fields[7] as String?,
      gender: fields[8] as String,
    );
  }

  @override
  void write(BinaryWriter writer, DoctorHive obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.firstName)
      ..writeByte(2)
      ..write(obj.lastName)
      ..writeByte(3)
      ..write(obj.address)
      ..writeByte(4)
      ..write(obj.phone)
      ..writeByte(5)
      ..write(obj.email)
      ..writeByte(6)
      ..write(obj.username)
      ..writeByte(7)
      ..write(obj.profilePicture)
      ..writeByte(8)
      ..write(obj.gender);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DoctorHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

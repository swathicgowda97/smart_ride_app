// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'spending_limit_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SpendingLimitHiveModelAdapter
    extends TypeAdapter<SpendingLimitHiveModel> {
  @override
  final int typeId = 3;

  @override
  SpendingLimitHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SpendingLimitHiveModel(
      rideType: fields[0] as RideType,
      limit: fields[1] as double,
    );
  }

  @override
  void write(BinaryWriter writer, SpendingLimitHiveModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.rideType)
      ..writeByte(1)
      ..write(obj.limit);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SpendingLimitHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

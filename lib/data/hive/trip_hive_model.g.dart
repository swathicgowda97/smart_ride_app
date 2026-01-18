// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trip_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TripHiveModelAdapter extends TypeAdapter<TripHiveModel> {
  @override
  final int typeId = 0;

  @override
  TripHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TripHiveModel(
      id: fields[0] as String,
      pickupLocation: fields[1] as String,
      dropLocation: fields[2] as String,
      rideType: fields[3] as RideType,
      fare: fields[4] as double,
      dateTime: fields[5] as DateTime,
      status: fields[6] as TripStatus,
    );
  }

  @override
  void write(BinaryWriter writer, TripHiveModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.pickupLocation)
      ..writeByte(2)
      ..write(obj.dropLocation)
      ..writeByte(3)
      ..write(obj.rideType)
      ..writeByte(4)
      ..write(obj.fare)
      ..writeByte(5)
      ..write(obj.dateTime)
      ..writeByte(6)
      ..write(obj.status);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TripHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

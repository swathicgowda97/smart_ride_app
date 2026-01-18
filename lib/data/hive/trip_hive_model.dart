import 'package:hive/hive.dart';
import '../../core/constants/ride_types.dart';
import '../../core/constants/trip_status.dart';

part 'trip_hive_model.g.dart';

@HiveType(typeId: 0)
class TripHiveModel extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String pickupLocation;

  @HiveField(2)
  String dropLocation;

  @HiveField(3)
  RideType rideType;

  @HiveField(4)
  double fare;

  @HiveField(5)
  DateTime dateTime;

  @HiveField(6)
  TripStatus status;

  TripHiveModel({
    required this.id,
    required this.pickupLocation,
    required this.dropLocation,
    required this.rideType,
    required this.fare,
    required this.dateTime,
    required this.status,
  });
}

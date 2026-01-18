import 'package:hive/hive.dart';
import '../../core/constants/ride_types.dart';

part 'spending_limit_hive_model.g.dart';

@HiveType(typeId: 3)
class SpendingLimitHiveModel extends HiveObject {
  @HiveField(0)
  RideType rideType;

  @HiveField(1)
  double limit;

  SpendingLimitHiveModel({
    required this.rideType,
    required this.limit,
  });
}

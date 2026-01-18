import 'package:hive/hive.dart';
import '../../../core/constants/ride_types.dart';
import '../spending_limit_hive_model.dart';

class SpendingLimitRepository {
  static const _boxName = 'spending_limits';

  Future<Box<SpendingLimitHiveModel>> _box() async {
    return await Hive.openBox<SpendingLimitHiveModel>(_boxName);
  }

  Future<Map<RideType, double>> loadLimits() async {
    final box = await _box();
    return {
      for (final item in box.values) item.rideType: item.limit,
    };
  }

  Future<void> saveLimit(RideType type, double limit) async {
    final box = await _box();
    await box.put(
      type.name,
      SpendingLimitHiveModel(rideType: type, limit: limit),
    );
  }
}

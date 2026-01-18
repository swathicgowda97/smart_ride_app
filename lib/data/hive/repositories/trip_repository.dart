import 'package:hive/hive.dart';
import '../../../models/trip.dart';
import '../trip_hive_model.dart';

class TripRepository {
  static const _boxName = 'trips';

  Future<Box<TripHiveModel>> _box() async {
    return await Hive.openBox<TripHiveModel>(_boxName);
  }

  Future<List<Trip>> loadTrips() async {
    final box = await _box();
    return box.values.map(_toTrip).toList();
  }

  Future<void> saveTrip(Trip trip) async {
    final box = await _box();
    await box.put(trip.id, _fromTrip(trip));
  }

  Future<void> deleteTrip(String id) async {
    final box = await _box();
    await box.delete(id);
  }

  // MAPPERS
  Trip _toTrip(TripHiveModel h) => Trip(
    id: h.id,
    pickupLocation: h.pickupLocation,
    dropLocation: h.dropLocation,
    rideType: h.rideType,
    fare: h.fare,
    dateTime: h.dateTime,
    status: h.status,
  );

  TripHiveModel _fromTrip(Trip t) => TripHiveModel(
    id: t.id,
    pickupLocation: t.pickupLocation,
    dropLocation: t.dropLocation,
    rideType: t.rideType,
    fare: t.fare,
    dateTime: t.dateTime,
    status: t.status,
  );
}

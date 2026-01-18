// enum RideType { mini, sedan, auto, bike }
//
// extension RideTypeX on RideType {
//   String get label {
//     switch (this) {
//       case RideType.mini:
//         return 'Mini';
//       case RideType.sedan:
//         return 'Sedan';
//       case RideType.auto:
//         return 'Auto';
//       case RideType.bike:
//         return 'Bike';
//     }
//   }
// }

import 'package:hive/hive.dart';

part 'ride_types.g.dart';

@HiveType(typeId: 1)
enum RideType {
  @HiveField(0)
  mini,

  @HiveField(1)
  sedan,

  @HiveField(2)
  auto,

  @HiveField(3)
  bike,
}

extension RideTypeX on RideType {
  String get label {
    switch (this) {
      case RideType.mini:
        return 'Mini';
      case RideType.sedan:
        return 'Sedan';
      case RideType.auto:
        return 'Auto';
      case RideType.bike:
        return 'Bike';
    }
  }
}


enum RideType { mini, sedan, auto, bike }

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

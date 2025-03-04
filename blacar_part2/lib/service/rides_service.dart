import 'package:week_3_blabla_project/model/ride_pref/ride_pref.dart';
import 'package:week_3_blabla_project/repository/mock/mock_locations_repository.dart';
import 'package:week_3_blabla_project/repository/mock/mock_rides_repository.dart';
import 'package:week_3_blabla_project/repository/rides_repository.dart';

import '../dummy_data/dummy_data.dart';
import '../model/ride/ride.dart';

////
///   This service handles:
///   - The list of available rides
///
class RidesService {
  static List<Ride> availableRides = fakeRides;
  //
  static RidesService? _instance;
  //
  final RidesRepository repository;

  ///
  /// Private constructor
  ///
  RidesService._internal(this.repository);

  ///
  /// Initialize
  ///
  static void initialize(RidesRepository repository) {
    if (_instance == null) {
      _instance = RidesService._internal(repository);
    } else {
      throw Exception("The Ride is already initialized.");
    }
  }

  ///
  /// Singleton accessor
  ///
  static RidesService get instance {
    if (_instance == null) {
      throw Exception(
          "RideService is not initialized. Call initialize() first.");
    }
    return _instance!;
  }

  ///
  ///  Return the relevant rides, given the passenger preferences
  ///
  static List<Ride> getRidesFor(RidePreference preferences) {
    // For now, just a test
    return availableRides
        .where((ride) =>
            ride.departureLocation == preferences.departure &&
            ride.arrivalLocation == preferences.arrival)
        .toList();
  }

  ///
  /// Return the Rides that just Updated witht the filtered
  ///
  List<Ride> getRides(RidePreference preferences, RideFilter filter) {
    return MockRidesRepository().getRides(preferences, filter);
  }

  // To add new rides
  void addRides(Ride ride) {
    MockRidesRepository().addRides(ride);
  }
}

class RideFilter {
  final bool acceptPet;

  RideFilter({required this.acceptPet});
}

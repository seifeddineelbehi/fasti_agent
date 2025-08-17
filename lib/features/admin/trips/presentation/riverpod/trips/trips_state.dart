// Update your existing trips_state.dart to include these fields

import 'package:fasti_dashboard/core/error/failures.dart';
import 'package:fasti_dashboard/features/admin/trips/data/model/direction_details_info_model.dart';
import 'package:fasti_dashboard/features/admin/trips/data/model/predicted_places_model.dart';
import 'package:fasti_dashboard/features/admin/users/data/model/directions_model.dart';
import 'package:fasti_dashboard/features/admin/users/data/model/trip_model.dart';
import 'package:fasti_dashboard/features/admin/users/data/model/user_model.dart';

class TripsState {
  // Original fields
  final bool isGettingAllTripsLoading;
  final bool isGettingTripLoading;
  final List<TripModel>? trips;
  final TripModel? trip;
  final Failure? failure;

  // Add Trip functionality fields
  final bool isCreatingTrip;
  final bool isSearchLoading;
  final bool isFetchingAddress;

  // Location management
  final DirectionsModel? userPickupLocation;
  final List<DirectionsModel> userDropOffLocations;
  final DirectionDetailInfoModel? tripDirectionDetailsInfo;
  final int totalDistanceMeters;
  final int totalDurationSeconds;

  // Driver management
  final List<UserModel> nearbyDrivers;
  final bool isGettingNearbyDriversLoading;

  // Search and saved places
  final List<PredictedPlacesModel> searchResults;
  final List<Map<String, dynamic>> savedPlaces;

  const TripsState({
    // Original fields
    this.isGettingAllTripsLoading = false,
    this.isGettingTripLoading = false,
    this.trips = const [],
    this.trip,
    this.failure,

    // Add Trip fields
    this.isCreatingTrip = false,
    this.isSearchLoading = false,
    this.isFetchingAddress = false,
    this.userPickupLocation,
    this.userDropOffLocations = const [],
    this.tripDirectionDetailsInfo,
    this.totalDistanceMeters = 0,
    this.totalDurationSeconds = 0,

    // Driver fields
    this.nearbyDrivers = const [],
    this.isGettingNearbyDriversLoading = false,

    // Search fields
    this.searchResults = const [],
    this.savedPlaces = const [],
  });

  TripsState copyWith({
    // Original fields
    bool? isGettingAllTripsLoading,
    bool? isGettingTripLoading,
    List<TripModel>? trips,
    TripModel? trip,
    bool? tripCanBeNull,
    Failure? failure,

    // Add Trip fields
    bool? isCreatingTrip,
    bool? isSearchLoading,
    bool? isFetchingAddress,
    DirectionsModel? userPickupLocation,
    bool? userPickupLocationCanBeNull,
    List<DirectionsModel>? userDropOffLocations,
    DirectionDetailInfoModel? tripDirectionDetailsInfo,
    int? totalDistanceMeters,
    int? totalDurationSeconds,

    // Driver fields
    List<UserModel>? nearbyDrivers,
    bool? isGettingNearbyDriversLoading,

    // Search fields
    List<PredictedPlacesModel>? searchResults,
    List<Map<String, dynamic>>? savedPlaces,
  }) {
    return TripsState(
      // Original fields
      isGettingAllTripsLoading:
          isGettingAllTripsLoading ?? this.isGettingAllTripsLoading,
      isGettingTripLoading: isGettingTripLoading ?? this.isGettingTripLoading,
      trips: trips ?? this.trips,
      failure: failure ?? this.failure,
      trip: tripCanBeNull != null ? null : trip ?? this.trip,

      // Add Trip fields
      isCreatingTrip: isCreatingTrip ?? this.isCreatingTrip,
      isSearchLoading: isSearchLoading ?? this.isSearchLoading,
      isFetchingAddress: isFetchingAddress ?? this.isFetchingAddress,
      userPickupLocation: userPickupLocationCanBeNull != null
          ? null
          : userPickupLocation ?? this.userPickupLocation,
      userDropOffLocations: userDropOffLocations ?? this.userDropOffLocations,
      tripDirectionDetailsInfo:
          tripDirectionDetailsInfo ?? this.tripDirectionDetailsInfo,
      totalDistanceMeters: totalDistanceMeters ?? this.totalDistanceMeters,
      totalDurationSeconds: totalDurationSeconds ?? this.totalDurationSeconds,

      // Driver fields
      nearbyDrivers: nearbyDrivers ?? this.nearbyDrivers,
      isGettingNearbyDriversLoading:
          isGettingNearbyDriversLoading ?? this.isGettingNearbyDriversLoading,

      // Search fields
      searchResults: searchResults ?? this.searchResults,
      savedPlaces: savedPlaces ?? this.savedPlaces,
    );
  }
}

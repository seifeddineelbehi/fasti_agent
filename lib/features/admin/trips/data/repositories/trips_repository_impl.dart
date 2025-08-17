import 'package:dartz/dartz.dart';
import 'package:fasti_dashboard/core/error/failures.dart';
import 'package:fasti_dashboard/core/network/network_info.dart';
import 'package:fasti_dashboard/features/admin/trips/data/data_source/trips_remote_data_source.dart';
import 'package:fasti_dashboard/features/admin/trips/domain/repositories/trips_repository.dart';
import 'package:fasti_dashboard/features/admin/users/data/model/location_model.dart';
import 'package:fasti_dashboard/features/admin/users/data/model/trip_model.dart';
import 'package:fasti_dashboard/features/admin/users/data/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

@injectable
@singleton
class TripsRepositoryImpl implements TripsRepository {
  final TripsRemoteDataSource remoteDataSource;
  final NetworkInfoImpl networkInfoImpl;
  TripsRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfoImpl,
  });

  @override
  Future<Either<Failure, List<TripModel>>> getAllTrips() async {
    try {
      final user = await remoteDataSource.getAllTrips();
      return Right(user);
    } on FirebaseAuthException catch (e) {
      return Left(Failure.auth(e.message ?? 'Get all users failed'));
    } catch (e, s) {
      return Left(Failure.unknown(e.toString()));
    }
  }

  @override
  Future<Either<Failure, TripModel>> getTripById(
      {required String tripId}) async {
    try {
      final user = await remoteDataSource.getTripById(tripId: tripId);
      if (user == null) {
        return Left(Failure.auth('Get driver failed'));
      } else {
        return Right(user);
      }
    } on FirebaseAuthException catch (e) {
      return Left(Failure.auth(e.message ?? 'Get driver failed'));
    } catch (e) {
      return Left(Failure.unknown(e.toString()));
    }
  }

  @override
  Future<Either<Failure, TripModel>> endTrip({required String tripId}) async {
    try {
      final user = await remoteDataSource.endTrip(tripId: tripId);
      if (user == null) {
        return Left(Failure.auth('Get driver failed'));
      } else {
        return Right(user);
      }
    } on FirebaseAuthException catch (e) {
      return Left(Failure.auth(e.message ?? 'Get driver failed'));
    } catch (e) {
      return Left(Failure.unknown(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<UserModel>>> updateTwoUsers({
    required UserModel user,
    required UserModel driver,
    required double amount,
  }) async {
    try {
      final updatedUser = await remoteDataSource.updateTwoUsers(
          user: user, driver: driver, amount: amount);
      return Right(updatedUser);
    } on FirebaseException catch (e) {
      return Left(Failure.user(e.message ?? 'Failed to update user'));
    } catch (e) {
      return Left(Failure.unknown(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserModel>> updateUser(UserModel user) async {
    try {
      final updatedUser = await remoteDataSource.updateUser(user);
      return Right(updatedUser);
    } on FirebaseException catch (e) {
      return Left(Failure.user(e.message ?? 'Failed to update user'));
    } catch (e) {
      return Left(Failure.unknown(e.toString()));
    }
  }

  @override
  Future<Either<Failure, TripModel>> createRideRequest(
      TripModel rideRequest) async {
    try {
      final ride = await remoteDataSource.createTripRequest(rideRequest);
      return Right(ride);
    } on FirebaseException catch (e) {
      return Left(Failure.user(e.message ?? 'Failed to create ride'));
    } catch (e) {
      return Left(Failure.unknown(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserModel?>> getDriverById(
      {required String driverId}) async {
    try {
      final driver = await remoteDataSource.getDriverById(driverId: driverId);
      return Right(driver);
    } on FirebaseException catch (e) {
      return Left(Failure.user(e.message ?? 'Failed to get driver'));
    } catch (e) {
      return Left(Failure.unknown(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> getAccessToken() async {
    try {
      final token = await remoteDataSource.getAccessToken();
      return Right(token);
    } on FirebaseException catch (e) {
      return Left(Failure.user(e.message ?? 'Failed to get access token'));
    } catch (e) {
      return Left(Failure.unknown(e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> sendTripCallNotification({
    required UserModel user,
    required String deviceRegistrationToken,
    required String userTripRequestId,
    required String serverAccessTokenKey,
    required String dropOffString,
    required String locationName,
  }) async {
    try {
      final result = await remoteDataSource.sendTripCallNotification(
        user: user,
        deviceRegistrationToken: deviceRegistrationToken,
        userTripRequestId: userTripRequestId,
        serverAccessTokenKey: serverAccessTokenKey,
        dropOffString: dropOffString,
        locationName: locationName,
      );
      return Right(result);
    } on FirebaseException catch (e) {
      return Left(Failure.user(e.message ?? 'Failed to send notification'));
    } catch (e) {
      return Left(Failure.unknown(e.toString()));
    }
  }

  @override
  Future<Either<Failure, LocationModel>> addSavedPlace(
      LocationModel place) async {
    try {
      final location = await remoteDataSource.addSavedPlace(place);
      return Right(location);
    } on FirebaseException catch (e) {
      return Left(Failure.user(e.message ?? 'Failed to addSavedPlace'));
    } catch (e) {
      return Left(Failure.unknown(e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> deleteSavedPlace(
      {required String placeId}) async {
    try {
      await remoteDataSource.deleteSavedPlace(placeId);

      return Right(true);
    } on FirebaseException catch (e) {
      return Left(Failure.user(e.message ?? 'Failed to deleteSavedPlace'));
    } catch (e) {
      return Left(Failure.unknown(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<LocationModel>>> getAllSavedPlaces() async {
    try {
      final location = await remoteDataSource.getAllSavedPlaces();
      return Right(location);
    } on FirebaseException catch (e) {
      return Left(Failure.user(e.message ?? 'Failed to getAllSavedPlaces'));
    } catch (e) {
      return Left(Failure.unknown(e.toString()));
    }
  }

  @override
  Future<Either<Failure, LocationModel>> getSavedPlaceById(
      String placeId) async {
    try {
      final location = await remoteDataSource.getSavedPlaceById(placeId);
      if (location != null) {
        return Right(location);
      } else {
        return Left(Failure.unknown('Failed to get saved place by id'));
      }
    } on FirebaseException catch (e) {
      return Left(Failure.user(e.message ?? 'Failed to get saved place by id'));
    } catch (e) {
      return Left(Failure.unknown(e.toString()));
    }
  }

  @override
  Future<Either<Failure, LocationModel>> updateSavedPlace(
      String placeId, LocationModel place) async {
    try {
      final location = await remoteDataSource.updateSavedPlace(placeId, place);
      return Right(location);
    } on FirebaseException catch (e) {
      return Left(Failure.user(e.message ?? 'Failed to updateSavedPlace'));
    } catch (e) {
      return Left(Failure.unknown(e.toString()));
    }
  }

  @override
  Future<Either<Failure, dynamic>> receiveRequest({required String url}) async {
    try {
      final result = await remoteDataSource.receiveRequest(url: url);
      return Right(result);
    } on FirebaseException catch (e) {
      return Left(Failure.user(e.message ?? 'Failed to make request'));
    } catch (e) {
      return Left(Failure.unknown(e.toString()));
    }
  }
}

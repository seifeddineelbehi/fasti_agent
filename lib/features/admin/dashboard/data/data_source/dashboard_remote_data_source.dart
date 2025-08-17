import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fasti_dashboard/features/admin/cars/data/model/car_model.dart';
import 'package:fasti_dashboard/features/admin/rents/data/model/rental_request_model.dart';
import 'package:fasti_dashboard/features/admin/users/data/model/transaction_model.dart';
import 'package:fasti_dashboard/features/admin/users/data/model/trip_model.dart';
import 'package:fasti_dashboard/features/admin/users/data/model/user_model.dart';
import 'package:injectable/injectable.dart';

@injectable
@singleton
class DashboardRemoteDataSource {
  final FirebaseFirestore _fireStore;

  DashboardRemoteDataSource(this._fireStore);

  // Collection names
  static const String _usersCollection = 'users';
  static const String _carsCollection = 'cars';
  static const String _rentalRequestsCollection = 'rent_requests';
  static const String _transactionsCollection = 'transactions';
  static const String _tripsCollection = 'trip_requests';

  Future<List<UserModel>> getAllUsers() async {
    try {
      final querySnapshot = await _fireStore.collection(_usersCollection).get();
      return querySnapshot.docs
          .map((doc) => UserModel.fromJson(doc.data()))
          .toList();
    } catch (e, s) {
      log("getAllUsers error: $e");
      rethrow;
    }
  }

  Future<List<CarModel>> getAllCars() async {
    try {
      final querySnapshot = await _fireStore.collection(_carsCollection).get();
      return querySnapshot.docs
          .map((doc) => CarModel.fromJson(doc.data()))
          .toList();
    } catch (e) {
      log("getAllCars error: $e");
      rethrow;
    }
  }

  Future<List<RentalRequestModel>> getAllRentalRequests() async {
    try {
      final querySnapshot =
          await _fireStore.collection(_rentalRequestsCollection).get();
      return querySnapshot.docs
          .map((doc) => RentalRequestModel.fromJson(doc.data()))
          .toList();
    } catch (e) {
      log("getAllRentalRequests error: $e");
      rethrow;
    }
  }

  Future<List<TransactionModel>> getAllTransactions() async {
    try {
      final querySnapshot =
          await _fireStore.collection(_transactionsCollection).get();
      return querySnapshot.docs
          .map((doc) => TransactionModel.fromJson(doc.data()))
          .toList();
    } catch (e) {
      log("getAllTransactions error: $e");
      rethrow;
    }
  }

  Future<List<TripModel>> getAllTrips() async {
    try {
      final querySnapshot = await _fireStore.collection(_tripsCollection).get();
      return querySnapshot.docs
          .map((doc) => TripModel.fromJson(doc.data()))
          .toList();
    } catch (e) {
      log("getAllTrips error: $e");
      rethrow;
    }
  }

  // Get recent data for dashboard (last 30 days)
  Future<List<TransactionModel>> getRecentTransactions() async {
    try {
      final thirtyDaysAgo = DateTime.now().subtract(const Duration(days: 30));
      final querySnapshot = await _fireStore
          .collection(_transactionsCollection)
          .where('timestamp', isGreaterThan: thirtyDaysAgo.toIso8601String())
          .orderBy('timestamp', descending: true)
          .limit(100)
          .get();

      return querySnapshot.docs
          .map((doc) => TransactionModel.fromJson(doc.data()))
          .toList();
    } catch (e) {
      log("getRecentTransactions error: $e");
      rethrow;
    }
  }

  Future<List<TripModel>> getRecentTrips() async {
    try {
      final querySnapshot = await _fireStore
          .collection(_tripsCollection)
          .orderBy('time', descending: true)
          .limit(100)
          .get();

      return querySnapshot.docs
          .map((doc) => TripModel.fromJson(doc.data()))
          .toList();
    } catch (e) {
      log("getRecentTrips error: $e");
      rethrow;
    }
  }

  Future<List<RentalRequestModel>> getRecentRentalRequests() async {
    try {
      final querySnapshot = await _fireStore
          .collection(_rentalRequestsCollection)
          .orderBy('submittedAt', descending: true)
          .limit(100)
          .get();

      return querySnapshot.docs
          .map((doc) => RentalRequestModel.fromJson(doc.data()))
          .toList();
    } catch (e) {
      log("getRecentRentalRequests error: $e");
      rethrow;
    }
  }

  // Get counts for dashboard metrics
  Future<Map<String, int>> getDashboardCounts() async {
    try {
      final results = await Future.wait([
        _fireStore.collection(_usersCollection).count().get(),
        _fireStore.collection(_carsCollection).count().get(),
        _fireStore.collection(_tripsCollection).count().get(),
        _fireStore.collection(_rentalRequestsCollection).count().get(),
        _fireStore.collection(_transactionsCollection).count().get(),
      ]);

      return {
        'users': results[0].count ?? 0,
        'cars': results[1].count ?? 0,
        'trips': results[2].count ?? 0,
        'rentalRequests': results[3].count ?? 0,
        'transactions': results[4].count ?? 0,
      };
    } catch (e) {
      log("getDashboardCounts error: $e");
      rethrow;
    }
  }

  // Get users by role
  Future<Map<String, int>> getUsersByRole() async {
    try {
      final results = await Future.wait([
        _fireStore
            .collection(_usersCollection)
            .where('role', isEqualTo: 'client')
            .count()
            .get(),
        _fireStore
            .collection(_usersCollection)
            .where('role', isEqualTo: 'driver')
            .count()
            .get(),
        _fireStore
            .collection(_usersCollection)
            .where('role', isEqualTo: 'agent')
            .count()
            .get(),
      ]);

      return {
        'client': results[0].count ?? 0,
        'driver': results[1].count ?? 0,
        'agent': results[2].count ?? 0,
      };
    } catch (e) {
      log("getUsersByRole error: $e");
      rethrow;
    }
  }

  // Get available cars count
  Future<int> getAvailableCarsCount() async {
    try {
      final result = await _fireStore
          .collection(_carsCollection)
          .where('isAvailable', isEqualTo: true)
          .count()
          .get();
      return result.count ?? 0;
    } catch (e) {
      log("getAvailableCarsCount error: $e");
      rethrow;
    }
  }

  // Get active drivers count
  Future<int> getActiveDriversCount() async {
    try {
      final result = await _fireStore
          .collection(_usersCollection)
          .where('driverInfo', isNotEqualTo: null)
          .where('driverInfo.approvedStatus', isEqualTo: true)
          .count()
          .get();
      return result.count ?? 0;
    } catch (e) {
      log("getActiveDriversCount error: $e");
      rethrow;
    }
  }
}

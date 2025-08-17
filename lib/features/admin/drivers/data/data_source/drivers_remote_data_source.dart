import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fasti_dashboard/features/admin/users/data/model/transaction_model.dart';
import 'package:fasti_dashboard/features/admin/users/data/model/user_model.dart';
import 'package:fasti_dashboard/features/auth/data/model/admin_model.dart';
import 'package:injectable/injectable.dart';

@injectable
@singleton
class DriversRemoteDataSource {
  final FirebaseFirestore _fireStore;

  DriversRemoteDataSource(this._fireStore);
  static const String _collectionTransactions = 'transactions';
  static const String _collection = 'users';
  static const String _adminCollection = 'admin';
  Future<List<UserModel>> getAllDrivers() async {
    try {
      final querySnapshot = await _fireStore.collection(_collection).get();

      return querySnapshot.docs
          .map((doc) => UserModel.fromJson(doc.data()))
          .where((user) => user.driverInfo != null)
          .toList();
    } catch (e) {
      log("getUsersWithoutApprovedDriverInfo error: $e");
      rethrow;
    }
  }

  Future<UserModel?> getDriverById({required String driverId}) async {
    final doc = await _fireStore.collection(_collection).doc(driverId).get();
    if (doc.exists && doc.data() != null) {
      return UserModel.fromJson(doc.data()!);
    }
    return null;
  }

  Future<UserModel?> rechargeDriverWallet({
    required String driverId,
    required double amount,
  }) async {
    final docRef = _fireStore.collection(_collection).doc(driverId);
    final doc = await docRef.get();

    if (doc.exists && doc.data() != null) {
      final user = UserModel.fromJson(doc.data()!);

      final updatedBalance = user.walletBalance + amount;
      TransactionModel transactionModel = TransactionModel(
        amount: amount,
        fromUserId: "",
        fromUserName: "Admin",
        id: "1",
        timestamp: DateTime.now(),
        toUserId: user.id,
        toUserName: "${user.firstName} ${user.lastName}",
        toUserPhone: user.phone,
        type: "sent",
      );
      try {
        final docReff = _fireStore.collection(_collectionTransactions).doc();
        transactionModel = transactionModel.copyWith(id: docReff.id);
        await docReff.set(transactionModel.toJsonForFirestore());
        List<TransactionModel> transactionsSender = [
          ...user.transactions,
          transactionModel,
        ];
        await docRef.update({
          'walletBalance': updatedBalance,
          'transactions':
              transactionsSender.map((t) => t.toJsonForFirestore()).toList(),
        });
      } catch (e) {
        throw Exception('createTransactionRequest error: $e');
      }

      // Return the updated user
      return user.copyWith(walletBalance: updatedBalance);
    }

    return null;
  }

  Future<UserModel?> approveDriver({required String driverId}) async {
    final docRef = _fireStore.collection(_collection).doc(driverId);
    final doc = await docRef.get();

    if (doc.exists && doc.data() != null) {
      final user = UserModel.fromJson(doc.data()!);
      await docRef.update({
        'role': 'driver',
        'driverInfo.approvedStatus': "approved",
      });

      // Return the updated user
      return user.copyWith(
          driverInfo: user.driverInfo!.copyWith(approvedStatus: "approved"));
    }

    return null;
  }

  Future<UserModel?> banDriver({required String driverId}) async {
    final docRef = _fireStore.collection(_collection).doc(driverId);
    final doc = await docRef.get();

    if (doc.exists && doc.data() != null) {
      final user = UserModel.fromJson(doc.data()!);
      await docRef.update({
        'isBanned': !user.isBanned,
      });

      // Return the updated user
      return user.copyWith(isBanned: !user.isBanned);
    }

    return null;
  }

  Future<UserModel?> payAllWalletTrips({required UserModel driver}) async {
    await _fireStore
        .collection(_collection)
        .doc(driver.id)
        .update(driver.toJsonForFirestore());
    return driver;
  }

  Future<AdminModel?> getAdmin() async {
    try {
      final querySnapshot =
          await _fireStore.collection(_adminCollection).limit(1).get();
      if (querySnapshot.docs.isNotEmpty) {
        final doc = querySnapshot.docs.first;
        return AdminModel.fromJson(doc.data());
      }
      return null;
    } catch (e) {
      throw Exception('getAdmin error: $e');
    }
  }
}

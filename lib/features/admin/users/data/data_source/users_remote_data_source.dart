import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fasti_dashboard/features/admin/users/data/model/transaction_model.dart';
import 'package:fasti_dashboard/features/admin/users/data/model/user_model.dart';
import 'package:injectable/injectable.dart';

@injectable
@singleton
class UsersRemoteDataSource {
  final FirebaseFirestore _fireStore;

  UsersRemoteDataSource(this._fireStore);
  static const String _collectionTransactions = 'transactions';

  static const String _collection = 'users';

  Future<List<UserModel>> getAllUsers() async {
    try {
      final querySnapshot = await _fireStore.collection(_collection).get();

      return querySnapshot.docs
          .map((doc) => UserModel.fromJson(doc.data()))
          .where((user) =>
              user.driverInfo == null ||
              user.driverInfo!.approvedStatus != "approved")
          .toList();
    } catch (e) {
      log("getUsersWithoutApprovedDriverInfo error: $e");
      rethrow;
    }
  }

  Future<UserModel?> getUserById({required String userId}) async {
    final doc = await _fireStore.collection(_collection).doc(userId).get();
    if (doc.exists && doc.data() != null) {
      return UserModel.fromJson(doc.data()!);
    }
    return null;
  }

  Future<UserModel?> rechargeUserWallet({
    required String userId,
    required double amount,
  }) async {
    final docRef = _fireStore.collection(_collection).doc(userId);
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
        type: "recieved",
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

  Future<UserModel?> banUser({required String userId}) async {
    final docRef = _fireStore.collection(_collection).doc(userId);
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
}

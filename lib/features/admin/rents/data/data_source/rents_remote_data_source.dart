import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fasti_dashboard/features/admin/cars/data/model/rental_confirmation_model.dart';
import 'package:fasti_dashboard/features/admin/rents/data/model/rental_request_model.dart';
import 'package:fasti_dashboard/features/admin/users/data/model/notification_model.dart';
import 'package:fasti_dashboard/features/admin/users/data/model/user_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:googleapis_auth/googleapis_auth.dart' as auth;
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';

@injectable
@singleton
class RentsRemoteDataSource {
  final FirebaseFirestore _fireStore;

  RentsRemoteDataSource(this._fireStore);

  static const String _collection = 'rent_requests';
  static const String _collectionUser = 'users';

  Future<List<RentalRequestModel>> getAllRents() async {
    try {
      final querySnapshot = await _fireStore.collection(_collection).get();

      return querySnapshot.docs
          .map((doc) => RentalRequestModel.fromJson(doc.data()))
          .toList();
    } catch (e, s) {
      log("getUsersWithoutApprovedDriverInfo error: $e");
      rethrow;
    }
  }

  Future<RentalRequestModel?> getRentById({required String rentId}) async {
    final doc = await _fireStore.collection(_collection).doc(rentId).get();
    if (doc.exists && doc.data() != null) {
      return RentalRequestModel.fromJson(doc.data()!);
    }
    return null;
  }

  Future<RentalRequestModel?> confirmUnConfirmRent(
      {required RentalRequestModel rent}) async {
    await _fireStore
        .collection(_collection)
        .doc(rent.id)
        .update(rent.toJsonForFirestore());
    return rent;
  }

  Future<UserModel?> updateUserConfirmedRental({
    required RentalRequestModel rent,
  }) async {
    try {
      final docRef = _fireStore.collection(_collectionUser).doc(rent.user.id);
      final doc = await docRef.get();

      if (!doc.exists || doc.data() == null) return null;

      final user = UserModel.fromJson(doc.data()!);

      final userRent = RentalConfirmationModel(
        status: rent.status,
        car: rent.car,
        numberOfDays: rent.numberOfDays,
        reservationDateStart: rent.reservationDateStart,
        reservationDateEnd: rent.reservationDateEnd,
        reservationId: rent.id,
        totalCost: rent.totalCost,
        withDriver: rent.withDriver,
        submittedAt: rent.submittedAt,
        rentTime: rent.rentTime,
      );

      final List<RentalConfirmationModel> rents = [...user.rentalCars];

      final index =
          rents.indexWhere((element) => element.reservationId == rent.id);
      if (index != -1) {
        rents[index] = userRent;
      } else {
        rents.add(userRent);
      }

      final rentsAsJson = rents
          .map((e) => e.toJsonForFirestore())
          .toList(); // Ensure .toJson() is defined

      await docRef.update({
        'rentalCars': rentsAsJson,
      });

      return user.copyWith(rentalCars: rents);
    } catch (e, stack) {
      print('❌ updateUserConfirmedRental error: $e\n$stack');
      return null;
    }
  }

  Future<UserModel?> updateUserNotif({
    required NotificationModel notif,
    required String userId,
  }) async {
    try {
      final docRef = _fireStore.collection(_collectionUser).doc(userId);
      final doc = await docRef.get();

      if (!doc.exists || doc.data() == null) return null;

      final user = UserModel.fromJson(doc.data()!);

      final List<NotificationModel> notifs = [...user.notifications];
      notifs.add(notif);

      await docRef.update({
        'notifications': notifs.map((e) => e.toJson()).toList(),
      });

      return user.copyWith(notifications: notifs);
    } catch (e, stack) {
      print('❌ updateUserNotifications error: $e\n$stack');
      return null;
    }
  }

  Future<String> getAccessToken() async {
    try {
      final serviceAccountJson = {
        "type": dotenv.env['PUSH_NOTIFICATION_TYPE'],
        "project_id": dotenv.env['PUSH_NOTIFICATION_PROJECT_ID'],
        "private_key_id": dotenv.env['PUSH_NOTIFICATION_PRIVATE_KEY_ID'],
        "private_key": dotenv.env['PUSH_NOTIFICATION_PRIVATE_KEY']
            ?.replaceAll(r'\n', '\n'),
        "client_email": dotenv.env['PUSH_NOTIFICATION_CLIENT_EMAIL'],
        "client_id": dotenv.env['PUSH_NOTIFICATION_CLIENT_ID'],
        "auth_uri": dotenv.env['PUSH_NOTIFICATION_AUTH_URI'],
        "token_uri": dotenv.env['PUSH_NOTIFICATION_TOKEN_URI'],
        "auth_provider_x509_cert_url":
            dotenv.env['PUSH_NOTIFICATION_AUTH_PROVIDER_X509_CERT_URL'],
        "client_x509_cert_url":
            dotenv.env['PUSH_NOTIFICATION_CLIENT_X509_CERT_URL'],
      };

      final scopes = ['https://www.googleapis.com/auth/firebase.messaging'];

      final client = await clientViaServiceAccount(
        auth.ServiceAccountCredentials.fromJson(serviceAccountJson),
        scopes,
      );

      final credentials = await obtainAccessCredentialsViaServiceAccount(
        auth.ServiceAccountCredentials.fromJson(serviceAccountJson),
        scopes,
        client,
      );
      client.close();

      return credentials.accessToken.data;
    } catch (e) {
      throw Exception('getAccessToken error: $e');
    }
  }

  Future<bool> sendNotification({
    required String deviceRegistrationToken,
    required String serverAccessTokenKey,
    required String title,
    required String body,
  }) async {
    try {
      final endpoint =
          'https://fcm.googleapis.com/v1/projects/${dotenv.env['PUSH_NOTIFICATION_PROJECT_ID']}/messages:send';

      final message = {
        'message': {
          'token': deviceRegistrationToken,
          'notification': {
            'title': title,
            'body': body,
          },
          'data': {
            "status": "done",
          }
        },
      };

      final response = await http.post(
        Uri.parse(endpoint),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $serverAccessTokenKey',
        },
        body: jsonEncode(message),
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        throw Exception(
            'sendNotification failed with status: ${response.statusCode}, body: ${response.body}');
      }
    } catch (e) {
      throw Exception('sendNotification error: $e');
    }
  }
}

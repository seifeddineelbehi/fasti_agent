import 'package:fasti_dashboard/features/admin/cars/data/model/rental_confirmation_model.dart';
import 'package:fasti_dashboard/features/admin/users/data/model/notification_model.dart';
import 'package:fasti_dashboard/features/admin/users/data/model/transaction_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'driver_info_model.dart';
import 'location_model.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
class UserModel with _$UserModel {
  const factory UserModel({
    required String id,
    required String firstName,
    required String lastName,
    required String phone,
    String? email,
    @Default('') String photoUrl,
    @Default('') String deviceToken,
    @Default('client') String role, // "client", "driver", "agent"
    @Default(false) bool isBanned,
    @Default(0.0) double walletBalance,
    @Default(0) int points,
    @Default([]) List<LocationModel> favorites,
    LocationModel? location,
    @Default('offline') String status, // "online", "offline", etc.
    @Default([]) List<String> trips,
    @Default([]) List<NotificationModel> notifications,
    @Default([]) List<TransactionModel> transactions,
    DriverInfoModel? driverInfo,
    @Default([]) List<RentalConfirmationModel> rentalCars,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  // Factory method to create a new user with default values
  factory UserModel.createNew({
    required String id,
    required String phone,
    String firstName = '',
    String deviceToken = '',
    String lastName = '',
    String? email,
    String photoUrl = '',
    String role = 'client',
  }) {
    return UserModel(
      id: id,
      firstName: firstName,
      lastName: lastName,
      phone: phone,
      deviceToken: deviceToken,
      email: email,
      photoUrl: photoUrl,
      role: role,
      isBanned: false,
      walletBalance: 0.0,
      points: 0,
      favorites: [],
      notifications: [],
      transactions: [],
      location: null,
      status: 'offline',
      trips: [],
      driverInfo: null, // Will be populated when driver completes registration
    );
  }
}

extension UserModelFirestore on UserModel {
  Map<String, dynamic> toJsonForFirestore(
      {bool includeTrips = true, bool includeRentedCars = true}) {
    final json = <String, dynamic>{
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'deviceToken': deviceToken,
      'phone': phone,
      'email': email,
      'photoUrl': photoUrl,
      'role': role,
      'isBanned': isBanned,
      'points': points,
      'walletBalance': walletBalance,
      'favorites': favorites.map((f) => f.toJson()).toList(),
      'notifications': notifications.map((f) => f.toJson()).toList(),
      'transactions': transactions.map((f) => f.toJson()).toList(),
      'status': status,
      'trips': trips,
    };

    if (includeRentedCars) {
      json['rentalCars'] =
          rentalCars.map((t) => t.toJsonForFirestore()).toList();
    }
    if (location != null) {
      json['location'] = location!.toJson();
    }
    if (driverInfo != null) {
      json['driverInfo'] = driverInfo!.toJsonForFirestore();
    }

    return json;
  }
}

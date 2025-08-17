import 'package:dartz/dartz.dart';
import 'package:fasti_dashboard/core/error/failures.dart';
import 'package:fasti_dashboard/features/admin/rents/data/model/rental_request_model.dart';
import 'package:fasti_dashboard/features/admin/users/data/model/notification_model.dart';
import 'package:fasti_dashboard/features/admin/users/data/model/user_model.dart';

abstract class RentsRepository {
  Future<Either<Failure, List<RentalRequestModel>>> getAllRents();
  Future<Either<Failure, RentalRequestModel>> getRentById(
      {required String rentId});
  Future<Either<Failure, RentalRequestModel>> confirmUnConfirmRent(
      {required RentalRequestModel rent});
  Future<Either<Failure, UserModel>> updateUserConfirmedRental(
      {required RentalRequestModel rent});
  Future<Either<Failure, String>> getAccessToken();
  Future<Either<Failure, bool>> sendNotification({
    required deviceRegistrationToken,
    required String serverAccessTokenKey,
    required String title,
    required String body,
  });

  Future<Either<Failure, UserModel>> updateUserNotif(
      {required NotificationModel notif, required String userId});
}

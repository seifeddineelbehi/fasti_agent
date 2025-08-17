import 'package:fasti_dashboard/core/providers/providers.dart';
import 'package:fasti_dashboard/features/admin/rents/data/model/rental_request_model.dart';
import 'package:fasti_dashboard/features/admin/rents/presentation/riverpod/rents_state.dart';
import 'package:fasti_dashboard/features/admin/users/data/model/notification_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RentsNotifier extends StateNotifier<RentsState> {
  final Ref ref;

  RentsNotifier(this.ref) : super(const RentsState());

  Future<void> getAllRents() async {
    state = state.copyWith(failure: null, isGettingAllRentsLoading: true);
    final result = await ref.read(rentsRepositoryProvider).getAllRents();

    result.fold(
      (failure) {
        state = state.copyWith(
            failure: failure, isGettingAllRentsLoading: false, rents: []);
      },
      (rents) async {
        state = state.copyWith(rents: rents, isGettingAllRentsLoading: false);
      },
    );
  }

  Future<void> getRentById({required String rentId}) async {
    state = state.copyWith(failure: null, isGettingRentLoading: true);
    final result =
        await ref.read(rentsRepositoryProvider).getRentById(rentId: rentId);

    result.fold(
      (failure) {
        state = state
            .copyWith(failure: failure, isGettingRentLoading: false, rents: []);
      },
      (rent) async {
        state = state.copyWith(rent: rent, isGettingRentLoading: false);
      },
    );
  }

  Future<void> confirmUnConfirmRent(
      {required RentalRequestModel rent, required bool isAccept}) async {
    state = state.copyWith(failure: null, isGettingRentLoading: true);
    if (isAccept) {
      rent = rent.copyWith(status: "Confirmed");
    } else {
      rent = rent.copyWith(status: "NotConfirmed");
    }
    final result = await ref
        .read(rentsRepositoryProvider)
        .confirmUnConfirmRent(rent: rent);

    await result.fold(
      (failure) {
        state = state
            .copyWith(failure: failure, isGettingRentLoading: false, rents: []);
      },
      (rent) async {
        final resultUser = await ref
            .read(rentsRepositoryProvider)
            .updateUserConfirmedRental(rent: rent);

        await resultUser.fold(
          (failure) {
            state = state.copyWith(
                failure: failure, isGettingRentLoading: false, rents: []);
          },
          (user) async {
            await sendNotification(
              deviceRegistrationToken: rent.user.deviceToken,
              title: "Car Rental Request ${rent.car.model}",
              body:
                  'The request to rent ${rent.car.model} has been ${rent.status}',
            );
            NotificationModel notificationModel = NotificationModel(
              body:
                  'The request to rent ${rent.car.model} has been ${rent.status}',
              title: "Car Rental Request ${rent.status}",
              date: DateTime.now(),
              type: "admin",
            );

            await ref.read(rentsRepositoryProvider).updateUserNotif(
                notif: notificationModel, userId: rent.user.id);
            List<RentalRequestModel> rents = state.rents!;

            final index = rents.indexWhere((element) => element.id == rent.id);
            if (index != -1) {
              rents[index] = rent;
            }

            state = state.copyWith(rents: rents, isGettingRentLoading: false);
          },
        );
      },
    );
  }

  Future<void> sendNotification({
    required String deviceRegistrationToken,
    required String title,
    required String body,
  }) async {
    final result = await ref.read(rentsRepositoryProvider).getAccessToken();

    return await result.fold(
      (failure) {
        state = state.copyWith(failure: failure);
      },
      (data) async {
        String serverAccessTokenKey = data;

        final res = await ref.read(rentsRepositoryProvider).sendNotification(
              deviceRegistrationToken: deviceRegistrationToken,
              serverAccessTokenKey: serverAccessTokenKey,
              title: title,
              body: body,
            );
        await res.fold((failure) {
          state = state.copyWith(failure: failure);
          return false;
        }, (data) async {
          if (data) {
            print("notification sent successfully");
          } else {
            print("notification sent failed");
          }
        });
      },
    );
  }
}

final rentsNotifierProvider =
    StateNotifierProvider<RentsNotifier, RentsState>((ref) {
  return RentsNotifier(ref);
});

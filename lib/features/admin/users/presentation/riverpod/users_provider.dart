import 'package:fasti_dashboard/core/providers/providers.dart';
import 'package:fasti_dashboard/features/admin/users/data/model/user_model.dart';
import 'package:fasti_dashboard/features/admin/users/presentation/riverpod/users_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UsersNotifier extends StateNotifier<UsersState> {
  final Ref ref;

  UsersNotifier(this.ref) : super(const UsersState());

  Future<void> getAllUsers() async {
    state = state.copyWith(failure: null, isGettingAllUsersLoading: true);
    final result = await ref.read(usersRepositoryProvider).getAllUsers();

    result.fold(
      (failure) {
        state = state.copyWith(
            failure: failure, isGettingAllUsersLoading: false, users: []);
      },
      (users) async {
        state = state.copyWith(users: users, isGettingAllUsersLoading: false);
      },
    );
  }

  Future<void> getUserById({required String userId}) async {
    state = state.copyWith(failure: null, isGettingUserLoading: true);
    final result =
        await ref.read(usersRepositoryProvider).getUserById(userId: userId);

    result.fold(
      (failure) {
        state = state
            .copyWith(failure: failure, isGettingUserLoading: false, users: []);
      },
      (user) async {
        state = state.copyWith(user: user, isGettingUserLoading: false);
      },
    );
  }

  Future<void> rechargeUserWallet({
    required String userId,
    required double amount,
  }) async {
    state = state.copyWith(failure: null, isGettingUserLoading: true);
    final result = await ref
        .read(usersRepositoryProvider)
        .rechargeUserWallet(userId: userId, amount: amount);

    result.fold(
      (failure) {
        state = state
            .copyWith(failure: failure, isGettingUserLoading: false, users: []);
      },
      (user) async {
        List<UserModel> users = state.users!;

        final index = users.indexWhere((element) => element.id == user.id);
        if (index != -1) {
          users[index] = user;
        }

        state = state.copyWith(users: users, isGettingUserLoading: false);
      },
    );
  }

  Future<void> banUser({
    required String userId,
  }) async {
    state = state.copyWith(failure: null, isGettingUserLoading: true);
    final result =
        await ref.read(usersRepositoryProvider).banUser(userId: userId);

    result.fold(
      (failure) {
        state = state
            .copyWith(failure: failure, isGettingUserLoading: false, users: []);
      },
      (driver) async {
        List<UserModel> users = state.users!;

        final index = users.indexWhere((element) => element.id == driver.id);
        if (index != -1) {
          users[index] = driver;
        }

        state = state.copyWith(users: users, isGettingUserLoading: false);
      },
    );
  }
}

final usersNotifierProvider =
    StateNotifierProvider<UsersNotifier, UsersState>((ref) {
  return UsersNotifier(ref);
});

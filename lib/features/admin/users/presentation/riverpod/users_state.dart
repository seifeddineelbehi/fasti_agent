import 'package:fasti_dashboard/core/error/failures.dart';
import 'package:fasti_dashboard/features/admin/users/data/model/user_model.dart';

class UsersState {
  final bool isGettingAllUsersLoading;
  final bool isGettingUserLoading;
  final List<UserModel>? users;
  final UserModel? user;
  final Failure? failure;

  const UsersState({
    this.isGettingAllUsersLoading = false,
    this.users = const [],
    this.failure,
    this.user,
    this.isGettingUserLoading = false,
  });

  UsersState copyWith({
    bool? isGettingAllUsersLoading,
    bool? isGettingUserLoading,
    List<UserModel>? users,
    UserModel? user,
    Failure? failure,
  }) {
    return UsersState(
      isGettingAllUsersLoading:
          isGettingAllUsersLoading ?? this.isGettingAllUsersLoading,
      users: users ?? this.users,
      failure: failure ?? this.failure,
      user: user ?? this.user,
      isGettingUserLoading: isGettingUserLoading ?? this.isGettingUserLoading,
    );
  }
}

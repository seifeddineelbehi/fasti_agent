import 'package:fasti_dashboard/core/providers/providers.dart';
import 'package:fasti_dashboard/features/admin/dashboard/presentation/riverpod/dashboard_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DashboardNotifier extends StateNotifier<DashboardState> {
  final Ref ref;

  DashboardNotifier(this.ref) : super(const DashboardState());

  Future<void> loadDashboardData() async {
    state = state.copyWith(isLoading: true, failure: null);

    final result =
        await ref.read(dashboardRepositoryProvider).getDashboardData();

    result.fold(
      (failure) {
        state = state.copyWith(
          failure: failure,
          isLoading: false,
        );
      },
      (analytics) {
        state = state.copyWith(
          analytics: analytics,
          isLoading: false,
        );
      },
    );
  }

  Future<void> refreshDashboardData() async {
    state = state.copyWith(isLoading: true, failure: null);

    final result =
        await ref.read(dashboardRepositoryProvider).refreshDashboardData();

    result.fold(
      (failure) {
        state = state.copyWith(
          failure: failure,
          isLoading: false,
        );
      },
      (analytics) {
        state = state.copyWith(
          analytics: analytics,
          isLoading: false,
        );
      },
    );
  }

  void clearError() {
    state = state.copyWith(failure: null);
  }
}

final dashboardNotifierProvider =
    StateNotifierProvider<DashboardNotifier, DashboardState>((ref) {
  return DashboardNotifier(ref);
});

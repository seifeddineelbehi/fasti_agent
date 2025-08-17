import 'package:dartz/dartz.dart';
import 'package:fasti_dashboard/core/error/failures.dart';
import 'package:fasti_dashboard/features/admin/dashboard/presentation/riverpod/dashboard_state.dart';

abstract class DashboardRepository {
  Future<Either<Failure, DashboardAnalytics>> getDashboardData();
  Future<Either<Failure, DashboardAnalytics>> refreshDashboardData();
}

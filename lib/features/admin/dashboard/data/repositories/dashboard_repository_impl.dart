import 'package:dartz/dartz.dart';
import 'package:fasti_dashboard/core/error/failures.dart';
import 'package:fasti_dashboard/core/network/network_info.dart';
import 'package:fasti_dashboard/features/admin/dashboard/data/data_source/dashboard_remote_data_source.dart';
import 'package:fasti_dashboard/features/admin/dashboard/domain/repositories/dashboard_repository.dart';
import 'package:fasti_dashboard/features/admin/dashboard/presentation/riverpod/dashboard_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';

@injectable
@singleton
class DashboardRepositoryImpl implements DashboardRepository {
  final DashboardRemoteDataSource remoteDataSource;
  final NetworkInfoImpl networkInfoImpl;

  DashboardRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfoImpl,
  });

  @override
  Future<Either<Failure, DashboardAnalytics>> getDashboardData() async {
    return _fetchDashboardData();
  }

  @override
  Future<Either<Failure, DashboardAnalytics>> refreshDashboardData() async {
    return _fetchDashboardData();
  }

  Future<Either<Failure, DashboardAnalytics>> _fetchDashboardData() async {
    try {
      // Fetch all data concurrently
      final results = await Future.wait([
        remoteDataSource.getAllUsers(),
        remoteDataSource.getAllCars(),
        remoteDataSource.getAllRentalRequests(),
        remoteDataSource.getAllTransactions(),
        remoteDataSource.getAllTrips(),
        remoteDataSource.getDashboardCounts(),
        remoteDataSource.getUsersByRole(),
        remoteDataSource.getAvailableCarsCount(),
        remoteDataSource.getActiveDriversCount(),
      ]);

      final users = results[0] as List;
      final cars = results[1] as List;
      final rentalRequests = results[2] as List;
      final transactions = results[3] as List;
      final trips = results[4] as List;
      final counts = results[5] as Map<String, int>;
      final usersByRole = results[6] as Map<String, int>;
      final availableCars = results[7] as int;
      final activeDrivers = results[8] as int;

      // Calculate analytics
      final analytics = _calculateAnalytics(
        users: users,
        cars: cars,
        rentalRequests: rentalRequests,
        transactions: transactions,
        trips: trips,
        counts: counts,
        usersByRole: usersByRole,
        availableCars: availableCars,
        activeDrivers: activeDrivers,
      );

      return Right(analytics);
    } on FirebaseAuthException catch (e) {
      return Left(Failure.auth(e.message ?? 'Dashboard data fetch failed'));
    } catch (e) {
      return Left(Failure.unknown(e.toString()));
    }
  }

  DashboardAnalytics _calculateAnalytics({
    required List users,
    required List cars,
    required List rentalRequests,
    required List transactions,
    required List trips,
    required Map<String, int> counts,
    required Map<String, int> usersByRole,
    required int availableCars,
    required int activeDrivers,
  }) {
    // Calculate basic metrics
    final totalUsers = users.length;
    final totalCars = cars.length;
    final totalTrips = trips.length;
    final totalRentalRequests = rentalRequests.length;

    // Calculate revenue
    final totalRevenue =
        trips.fold<double>(0.0, (sum, trip) => sum + (trip.fare ?? 0.0));
    final totalTransactionAmount = transactions.fold<double>(
        0.0, (sum, transaction) => sum + (transaction.amount ?? 0.0));

    // Calculate completed trips
    final completedTrips = trips.where((trip) => trip.status == 'ended').length;

    // Calculate pending rentals
    final pendingRentals =
        rentalRequests.where((rental) => rental.status == 'pending').length;

    // Calculate average rating from drivers
    final driversWithRating =
        users.where((user) => user.driverInfo?.rating != null);
    final averageRating = driversWithRating.isNotEmpty
        ? driversWithRating.fold<double>(
                0.0, (sum, user) => sum + (user.driverInfo?.rating ?? 0.0)) /
            driversWithRating.length
        : 0.0;

    // Generate monthly revenue data
    final monthlyRevenue = _generateMonthlyRevenue(trips, rentalRequests);

    // Generate user distribution
    final userDistribution = _generateUserDistribution(usersByRole, totalUsers);

    // Generate car type distribution
    final carTypeDistribution = _generateCarTypeDistribution(cars);

    // Generate transaction type data
    final transactionTypeData = _generateTransactionTypeData(transactions);

    // Generate trip status data
    final tripStatusData = _generateTripStatusData(trips);

    // Generate daily activity data
    final dailyActivity =
        _generateDailyActivityData(trips, rentalRequests, users);

    return DashboardAnalytics(
      totalUsers: totalUsers,
      totalCars: totalCars,
      totalTrips: totalTrips,
      totalRentalRequests: totalRentalRequests,
      totalRevenue: totalRevenue,
      totalTransactionAmount: totalTransactionAmount,
      activeDrivers: activeDrivers,
      availableCars: availableCars,
      completedTrips: completedTrips,
      pendingRentals: pendingRentals,
      averageRating: averageRating,
      monthlyRevenue: monthlyRevenue,
      userDistribution: userDistribution,
      carTypeDistribution: carTypeDistribution,
      transactionTypeData: transactionTypeData,
      tripStatusData: tripStatusData,
      dailyActivity: dailyActivity,
    );
  }

  List<MonthlyRevenue> _generateMonthlyRevenue(
      List trips, List rentalRequests) {
    final Map<String, Map<String, double>> monthlyData = {};

    // Process trips
    for (final trip in trips) {
      try {
        final date = DateTime.parse(trip.time);
        final monthKey = DateFormat('MMM yyyy').format(date);

        if (!monthlyData.containsKey(monthKey)) {
          monthlyData[monthKey] = {'trip': 0.0, 'rental': 0.0};
        }
        monthlyData[monthKey]!['trip'] =
            (monthlyData[monthKey]!['trip'] ?? 0.0) + (trip.fare ?? 0.0);
      } catch (e) {
        // Skip invalid dates
      }
    }

    // Process rental requests
    for (final rental in rentalRequests) {
      try {
        final date = DateTime.parse(rental.submittedAt);
        final monthKey = DateFormat('MMM yyyy').format(date);

        if (!monthlyData.containsKey(monthKey)) {
          monthlyData[monthKey] = {'trip': 0.0, 'rental': 0.0};
        }
        monthlyData[monthKey]!['rental'] =
            (monthlyData[monthKey]!['rental'] ?? 0.0) +
                (rental.totalCost ?? 0.0);
      } catch (e) {
        // Skip invalid dates
      }
    }

    return monthlyData.entries.map((entry) {
      final tripRevenue = entry.value['trip'] ?? 0.0;
      final rentalRevenue = entry.value['rental'] ?? 0.0;
      return MonthlyRevenue(
        month: entry.key,
        tripRevenue: tripRevenue,
        rentalRevenue: rentalRevenue,
        totalRevenue: tripRevenue + rentalRevenue,
      );
    }).toList()
      ..sort((a, b) => a.month.compareTo(b.month));
  }

  List<UserTypeDistribution> _generateUserDistribution(
      Map<String, int> usersByRole, int totalUsers) {
    return usersByRole.entries.map((entry) {
      final percentage =
          totalUsers > 0 ? (entry.value / totalUsers) * 100 : 0.0;
      return UserTypeDistribution(
        userType: entry.key.toUpperCase(),
        count: entry.value,
        percentage: percentage,
      );
    }).toList();
  }

  List<CarTypeDistribution> _generateCarTypeDistribution(List cars) {
    final Map<String, List<double>> typeData = {};

    for (final car in cars) {
      final type = car.brand ?? 'Unknown';
      if (!typeData.containsKey(type)) {
        typeData[type] = [];
      }
      typeData[type]!.add(car.pricePerDay ?? 0.0);
    }

    return typeData.entries.map((entry) {
      final averagePrice = entry.value.isNotEmpty
          ? entry.value.reduce((a, b) => a + b) / entry.value.length
          : 0.0;
      return CarTypeDistribution(
        carType: entry.key,
        count: entry.value.length,
        averagePrice: averagePrice,
      );
    }).toList();
  }

  List<TransactionTypeData> _generateTransactionTypeData(List transactions) {
    final Map<String, List<double>> typeData = {};

    for (final transaction in transactions) {
      final type = "sent" ?? 'Unknown';
      if (!typeData.containsKey(type)) {
        typeData[type] = [];
      }
      typeData[type]!.add(transaction.amount ?? 0.0);
    }

    return typeData.entries.map((entry) {
      final totalAmount =
          entry.value.fold<double>(0.0, (sum, amount) => sum + amount);
      return TransactionTypeData(
        type: entry.key.toUpperCase(),
        count: entry.value.length,
        amount: totalAmount,
      );
    }).toList();
  }

  List<TripStatusData> _generateTripStatusData(List trips) {
    final Map<String, int> statusCount = {};

    for (final trip in trips) {
      final status = trip.status ?? 'Unknown';
      statusCount[status] = (statusCount[status] ?? 0) + 1;
    }

    return statusCount.entries.map((entry) {
      final percentage =
          trips.isNotEmpty ? (entry.value / trips.length) * 100 : 0.0;
      return TripStatusData(
        status: entry.key.toUpperCase(),
        count: entry.value,
        percentage: percentage,
      );
    }).toList();
  }

  List<DailyActivityData> _generateDailyActivityData(
      List trips, List rentalRequests, List users) {
    final Map<String, Map<String, int>> dailyData = {};
    final now = DateTime.now();

    // Initialize last 7 days
    for (int i = 6; i >= 0; i--) {
      final date = now.subtract(Duration(days: i));
      final dateKey = DateFormat('MMM dd').format(date);
      dailyData[dateKey] = {'trips': 0, 'rentals': 0, 'registrations': 0};
    }

    // Process trips
    for (final trip in trips) {
      try {
        final date = DateTime.parse(trip.time);
        if (date.isAfter(now.subtract(const Duration(days: 7)))) {
          final dateKey = DateFormat('MMM dd').format(date);
          if (dailyData.containsKey(dateKey)) {
            dailyData[dateKey]!['trips'] =
                (dailyData[dateKey]!['trips'] ?? 0) + 1;
          }
        }
      } catch (e) {
        // Skip invalid dates
      }
    }

    // Process rental requests
    for (final rental in rentalRequests) {
      try {
        final date = DateTime.parse(rental.submittedAt);
        if (date.isAfter(now.subtract(const Duration(days: 7)))) {
          final dateKey = DateFormat('MMM dd').format(date);
          if (dailyData.containsKey(dateKey)) {
            dailyData[dateKey]!['rentals'] =
                (dailyData[dateKey]!['rentals'] ?? 0) + 1;
          }
        }
      } catch (e) {
        // Skip invalid dates
      }
    }

    return dailyData.entries.map((entry) {
      return DailyActivityData(
        date: entry.key,
        trips: entry.value['trips'] ?? 0,
        rentals: entry.value['rentals'] ?? 0,
        registrations: entry.value['registrations'] ?? 0,
      );
    }).toList();
  }
}

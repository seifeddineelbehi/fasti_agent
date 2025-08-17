import 'package:fasti_dashboard/core/error/failures.dart';
import 'package:fasti_dashboard/features/admin/cars/data/model/car_model.dart';
import 'package:fasti_dashboard/features/admin/rents/data/model/rental_request_model.dart';
import 'package:fasti_dashboard/features/admin/users/data/model/transaction_model.dart';
import 'package:fasti_dashboard/features/admin/users/data/model/trip_model.dart';
import 'package:fasti_dashboard/features/admin/users/data/model/user_model.dart';

class DashboardState {
  final bool isLoading;
  final List<UserModel> users;
  final List<CarModel> cars;
  final List<RentalRequestModel> rentalRequests;
  final List<TransactionModel> transactions;
  final List<TripModel> trips;
  final Failure? failure;

  // Dashboard analytics
  final DashboardAnalytics? analytics;

  const DashboardState({
    this.isLoading = false,
    this.users = const [],
    this.cars = const [],
    this.rentalRequests = const [],
    this.transactions = const [],
    this.trips = const [],
    this.failure,
    this.analytics,
  });

  DashboardState copyWith({
    bool? isLoading,
    List<UserModel>? users,
    List<CarModel>? cars,
    List<RentalRequestModel>? rentalRequests,
    List<TransactionModel>? transactions,
    List<TripModel>? trips,
    Failure? failure,
    DashboardAnalytics? analytics,
  }) {
    return DashboardState(
      isLoading: isLoading ?? this.isLoading,
      users: users ?? this.users,
      cars: cars ?? this.cars,
      rentalRequests: rentalRequests ?? this.rentalRequests,
      transactions: transactions ?? this.transactions,
      trips: trips ?? this.trips,
      failure: failure,
      analytics: analytics ?? this.analytics,
    );
  }
}

class DashboardAnalytics {
  final int totalUsers;
  final int totalCars;
  final int totalTrips;
  final int totalRentalRequests;
  final double totalRevenue;
  final double totalTransactionAmount;
  final int activeDrivers;
  final int availableCars;
  final int completedTrips;
  final int pendingRentals;
  final double averageRating;
  final List<MonthlyRevenue> monthlyRevenue;
  final List<UserTypeDistribution> userDistribution;
  final List<CarTypeDistribution> carTypeDistribution;
  final List<TransactionTypeData> transactionTypeData;
  final List<TripStatusData> tripStatusData;
  final List<DailyActivityData> dailyActivity;

  const DashboardAnalytics({
    required this.totalUsers,
    required this.totalCars,
    required this.totalTrips,
    required this.totalRentalRequests,
    required this.totalRevenue,
    required this.totalTransactionAmount,
    required this.activeDrivers,
    required this.availableCars,
    required this.completedTrips,
    required this.pendingRentals,
    required this.averageRating,
    required this.monthlyRevenue,
    required this.userDistribution,
    required this.carTypeDistribution,
    required this.transactionTypeData,
    required this.tripStatusData,
    required this.dailyActivity,
  });
}

class MonthlyRevenue {
  final String month;
  final double tripRevenue;
  final double rentalRevenue;
  final double totalRevenue;

  const MonthlyRevenue({
    required this.month,
    required this.tripRevenue,
    required this.rentalRevenue,
    required this.totalRevenue,
  });
}

class UserTypeDistribution {
  final String userType;
  final int count;
  final double percentage;

  const UserTypeDistribution({
    required this.userType,
    required this.count,
    required this.percentage,
  });
}

class CarTypeDistribution {
  final String carType;
  final int count;
  final double averagePrice;

  const CarTypeDistribution({
    required this.carType,
    required this.count,
    required this.averagePrice,
  });
}

class TransactionTypeData {
  final String type;
  final int count;
  final double amount;

  const TransactionTypeData({
    required this.type,
    required this.count,
    required this.amount,
  });
}

class TripStatusData {
  final String status;
  final int count;
  final double percentage;

  const TripStatusData({
    required this.status,
    required this.count,
    required this.percentage,
  });
}

class DailyActivityData {
  final String date;
  final int trips;
  final int rentals;
  final int registrations;

  const DailyActivityData({
    required this.date,
    required this.trips,
    required this.rentals,
    required this.registrations,
  });
}

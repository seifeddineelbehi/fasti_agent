// import 'package:equatable/equatable.dart';
//
// abstract class Failure extends Equatable {}
//
// class OfflineFailure extends Failure {
//   @override
//   List<Object?> get props => [];
// }
//
// class ServerFailure extends Failure {
//   @override
//   List<Object?> get props => [];
// }
//
// class EmptyCacheFailure extends Failure {
//   @override
//   List<Object?> get props => [];
// }
import 'package:freezed_annotation/freezed_annotation.dart';

part 'failures.freezed.dart';

@freezed
class Failure with _$Failure {
  const factory Failure.auth(String message) = AuthFailure;
  const factory Failure.network(String message) = NetworkFailure;
  const factory Failure.user(String message) = UserFailure;
  const factory Failure.unknown(String message) = UnknownFailure;
  const factory Failure.emptyCache(String message) = EmptyCacheFailure;
}

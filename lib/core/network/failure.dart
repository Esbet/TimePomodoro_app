// This class is abstract to allow condition the functional methods and allow capture the failure events

import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {}

// This class capture the failure error the methods to fuctional level
class ErrorFailure extends Failure {
  final Object? error;

  ErrorFailure({
    this.error,
  });

  @override
  List<Object?> get props => [
        error,
      ];
}

//General failures
class CacheFailure extends Failure {
  final Object? message;

  CacheFailure({
    this.message,
  });

  @override
  List<Object?> get props => [
        message,
      ];
}

class DataBaseFailure extends Failure {
  final Object? message;

  DataBaseFailure({
    this.message,
  });

  @override
  List<Object?> get props => [
        message,
      ];
}

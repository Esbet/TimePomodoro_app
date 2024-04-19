import 'package:dartz/dartz.dart';
import 'package:timepomodoro_app/core/network/failure.dart';
import 'package:timepomodoro_app/features/time/domain/usecases/get_total_breaks_usecase.dart';
import 'package:timepomodoro_app/features/time/domain/usecases/get_total_pomodoros_usecase.dart';
import 'package:timepomodoro_app/features/time/domain/usecases/has_user_data_usecase.dart';
import 'package:timepomodoro_app/features/time/domain/usecases/insert_breaks_time_usecase.dart';
import 'package:timepomodoro_app/features/time/domain/usecases/insert_pomodoro_time_usecase.dart';
import '../../domain/repositories/time_repository.dart';
import '../../domain/usecases/get_pomodoro_today_usecase.dart';
import '../../domain/usecases/get_user_usecase.dart';
import '../../domain/usecases/insert_user_usecase.dart';
import '../datasources/local_datasource.dart';

class TimeRepositoryImp implements TimeRepository {
  final LocalDatasource localDatabaseRepository;

  TimeRepositoryImp({
    required this.localDatabaseRepository,
  });

  @override
  Future<Either<Failure, UseCaseInsertPomodoroTimeResult>> insertPomodoroTime(
      {required String date, required int minutes}) async {
    try {
      final response =
          await localDatabaseRepository.saveTotalMinutesForDate(date, minutes);
      return Right(
        UseCaseInsertPomodoroTimeResult(result: response),
      );
    } on CacheFailure catch (e) {
      return Left(CacheFailure(message: e.message));
    } on DataBaseFailure catch (e) {
      return Left(DataBaseFailure(message: e.message));
    } on Object catch (e) {
      return Left(ErrorFailure(error: e));
    }
  }

  @override
  Future<Either<Failure, UseCaseGetPomodoroTodayResult>> getPomodoroToday(
      {required String date}) async {
    try {
      final response =
          await localDatabaseRepository.getTotalMinutesForDate(date);
      return Right(
        UseCaseGetPomodoroTodayResult(result: response),
      );
    } on CacheFailure catch (e) {
      return Left(CacheFailure(message: e.message));
    } on DataBaseFailure catch (e) {
      return Left(DataBaseFailure(message: e.message));
    } on Object catch (e) {
      return Left(ErrorFailure(error: e));
    }
  }

  @override
  Future<Either<Failure, UseCaseGetPomodorosResult>> getTotalPomodoros() async {
    try {
      final response = await localDatabaseRepository.getTotalPomodoros();
      return Right(
        UseCaseGetPomodorosResult(result: response),
      );
    } on CacheFailure catch (e) {
      return Left(CacheFailure(message: e.message));
    } on DataBaseFailure catch (e) {
      return Left(DataBaseFailure(message: e.message));
    } on Object catch (e) {
      return Left(ErrorFailure(error: e));
    }
  }

  @override
  Future<Either<Failure, UseCaseInsertBreaksTimeResult>> insertBreaksTime(
      {required String date, required int minutes}) async {
    try {
      final response =
          await localDatabaseRepository.saveTotalBreaksForDate(date, minutes);
      return Right(
        UseCaseInsertBreaksTimeResult(result: response),
      );
    } on CacheFailure catch (e) {
      return Left(CacheFailure(message: e.message));
    } on DataBaseFailure catch (e) {
      return Left(DataBaseFailure(message: e.message));
    } on Object catch (e) {
      return Left(ErrorFailure(error: e));
    }
  }

  @override
  Future<Either<Failure, UseCaseGetTotalBreaksResult>> getTotalBreaks() async {
    try {
      final response = await localDatabaseRepository.getTotalBreaks();
      return Right(
        UseCaseGetTotalBreaksResult(result: response),
      );
    } on CacheFailure catch (e) {
      return Left(CacheFailure(message: e.message));
    } on DataBaseFailure catch (e) {
      return Left(DataBaseFailure(message: e.message));
    } on Object catch (e) {
      return Left(ErrorFailure(error: e));
    }
  }

  @override
  Future<Either<Failure, UseCaseGetUserResult>> getUser() async {
    try {
      final response = await localDatabaseRepository.getUser();
      return Right(
        UseCaseGetUserResult(result: response),
      );
    } on CacheFailure catch (e) {
      return Left(CacheFailure(message: e.message));
    } on DataBaseFailure catch (e) {
      return Left(DataBaseFailure(message: e.message));
    } on Object catch (e) {
      return Left(ErrorFailure(error: e));
    }
  }

  @override
  Future<Either<Failure, UseCaseInsertUserResult>> insertUser(
      {required String email, required String name}) async {
    try {
      final response = await localDatabaseRepository.saveUser(name, email);
      return Right(
        UseCaseInsertUserResult(result: response),
      );
    } on CacheFailure catch (e) {
      return Left(CacheFailure(message: e.message));
    } on DataBaseFailure catch (e) {
      return Left(DataBaseFailure(message: e.message));
    } on Object catch (e) {
      return Left(ErrorFailure(error: e));
    }
  }

  @override
  Future<Either<Failure, UseCaseHasUserDataResult>> hasUserData() async {
    try {
      final response = await localDatabaseRepository.hasUserData();
      return Right(
        UseCaseHasUserDataResult(result: response),
      );
    } on CacheFailure catch (e) {
      return Left(CacheFailure(message: e.message));
    } on DataBaseFailure catch (e) {
      return Left(DataBaseFailure(message: e.message));
    } on Object catch (e) {
      return Left(ErrorFailure(error: e));
    }
  }
}

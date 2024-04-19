import 'package:dartz/dartz.dart';

import '../../../../core/network/failure.dart';
import '../usecases/get_pomodoro_today_usecase.dart';
import '../usecases/get_total_breaks_usecase.dart';
import '../usecases/get_total_pomodoros_usecase.dart';
import '../usecases/get_user_usecase.dart';
import '../usecases/has_user_data_usecase.dart';
import '../usecases/insert_breaks_time_usecase.dart';
import '../usecases/insert_pomodoro_time_usecase.dart';
import '../usecases/insert_user_usecase.dart';

abstract class TimeRepository {

  ///Method that allows you to insert pomodoro time
  Future<Either<Failure, UseCaseInsertPomodoroTimeResult>> insertPomodoroTime({required  String date, required int minutes});

  ///Method that allows you to get pomodoro time by date 
  Future<Either<Failure,  UseCaseGetPomodoroTodayResult>> getPomodoroToday({required  String date});

  ///Method that allows you to get total pomodoros 
  Future<Either<Failure, UseCaseGetPomodorosResult>> getTotalPomodoros();

  ///Method that allows you to insert breaks time
  Future<Either<Failure, UseCaseInsertBreaksTimeResult>> insertBreaksTime({required  String date, required int minutes});

    ///Method that allows you to get total breaks 
  Future<Either<Failure, UseCaseGetTotalBreaksResult>> getTotalBreaks();

  ///Method that allows you to get user 
  Future<Either<Failure,UseCaseGetUserResult >> getUser();

  ///Method that allows you to save user
  Future<Either<Failure, UseCaseInsertUserResult>> insertUser({required  String email, required String name});

  ///Method that allows you to get user 
  Future<Either<Failure,UseCaseHasUserDataResult >> hasUserData();

}
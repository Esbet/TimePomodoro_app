import 'package:dartz/dartz.dart';

import '../../../../core/network/failure.dart';
import '../../../../core/usecases/usecases.dart';
import '../repositories/time_repository.dart';

class GetPomodoroTodayUseCase
    implements
        UseCase<UseCaseGetPomodoroTodayResult,
            ParamsUseCaseGetPomodoroToday> {
  final TimeRepository repository;
  GetPomodoroTodayUseCase({required this.repository});
  @override
  Future<Either<Failure, UseCaseGetPomodoroTodayResult>> call(
      params) async {
    final result =
        await repository.getPomodoroToday(date: params.date);
    return result.fold(
      (failure) => Left(failure),
      (resp) =>
          Right(UseCaseGetPomodoroTodayResult(result: resp.result)),
    );
  }
}

class ParamsUseCaseGetPomodoroToday {
  final String date;
  const ParamsUseCaseGetPomodoroToday({
    required this.date});
}

class UseCaseGetPomodoroTodayResult {
  final int result;
  const UseCaseGetPomodoroTodayResult({required this.result});
}

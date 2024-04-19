import 'package:dartz/dartz.dart';

import '../../../../core/network/failure.dart';
import '../../../../core/usecases/usecases.dart';
import '../repositories/time_repository.dart';

class InsertPomodoroTimeUseCase implements UseCase<UseCaseInsertPomodoroTimeResult, ParamsUseCaseInsertPomodoroTime> {
  final TimeRepository repository;
  InsertPomodoroTimeUseCase({required this.repository});
  @override
  Future<Either<Failure, UseCaseInsertPomodoroTimeResult>> call(params) async {
    final result = await repository.insertPomodoroTime(date: params.date, minutes: params.minutes);
    return result.fold(
      (failure) => Left(failure),
      (resp) => Right(UseCaseInsertPomodoroTimeResult(result: resp.result)),
    );
  }
}

class ParamsUseCaseInsertPomodoroTime {
  final String date;
  final int minutes;
  const ParamsUseCaseInsertPomodoroTime({
    required this.date, 
    required this.minutes});
}

class UseCaseInsertPomodoroTimeResult {
  final bool result;
  const UseCaseInsertPomodoroTimeResult({required this.result});
}
import 'package:dartz/dartz.dart';

import '../../../../core/network/failure.dart';
import '../../../../core/usecases/usecases.dart';
import '../repositories/time_repository.dart';

class InsertBreaksTimeUseCase implements UseCase<UseCaseInsertBreaksTimeResult, ParamsUseCaseInsertBreaksTime> {
  final TimeRepository repository;
  InsertBreaksTimeUseCase({required this.repository});
  @override
  Future<Either<Failure, UseCaseInsertBreaksTimeResult>> call(params) async {
    final result = await repository.insertBreaksTime(date: params.date, minutes: params.minutes);
    return result.fold(
      (failure) => Left(failure),
      (resp) => Right(UseCaseInsertBreaksTimeResult(result: resp.result)),
    );
  }
}

class ParamsUseCaseInsertBreaksTime {
  final String date;
  final int minutes;
  const ParamsUseCaseInsertBreaksTime({
    required this.date, 
    required this.minutes});
}

class UseCaseInsertBreaksTimeResult {
  final bool result;
  const UseCaseInsertBreaksTimeResult({required this.result});
}
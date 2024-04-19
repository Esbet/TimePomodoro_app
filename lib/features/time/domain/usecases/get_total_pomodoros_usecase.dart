import 'package:dartz/dartz.dart';

import '../../../../core/network/failure.dart';
import '../../../../core/usecases/usecases.dart';
import '../repositories/time_repository.dart';

class GetTotalPomodorosUseCase implements UseCase<UseCaseGetPomodorosResult, NoParams> {
  final TimeRepository repository;
  GetTotalPomodorosUseCase({required this.repository});
  @override
  Future<Either<Failure, UseCaseGetPomodorosResult>> call(NoParams params) async {
    final result = await repository.getTotalPomodoros();
    return result.fold(
      (failure) => Left(failure),
      (resp) => Right(UseCaseGetPomodorosResult(result: resp.result)),
    );
  }
}

class UseCaseGetPomodorosResult {
  final int result;
  const UseCaseGetPomodorosResult({required this.result});
}


import 'package:dartz/dartz.dart';

import '../../../../core/network/failure.dart';
import '../../../../core/usecases/usecases.dart';
import '../repositories/time_repository.dart';

class GetTotalBreaksUseCase implements UseCase<UseCaseGetTotalBreaksResult, NoParams> {
  final TimeRepository repository;
  GetTotalBreaksUseCase({required this.repository});
  @override
  Future<Either<Failure, UseCaseGetTotalBreaksResult>> call(NoParams params) async {
    final result = await repository.getTotalBreaks();
    return result.fold(
      (failure) => Left(failure),
      (resp) => Right(UseCaseGetTotalBreaksResult(result: resp.result)),
    );
  }
}

class UseCaseGetTotalBreaksResult {
  final int result;
  const UseCaseGetTotalBreaksResult({required this.result});
}

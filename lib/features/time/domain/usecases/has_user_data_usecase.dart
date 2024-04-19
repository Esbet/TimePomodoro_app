import 'package:dartz/dartz.dart';

import '../../../../core/network/failure.dart';
import '../../../../core/usecases/usecases.dart';
import '../repositories/time_repository.dart';

class HasUserDataUseCase implements UseCase<UseCaseHasUserDataResult, NoParams> {
  final TimeRepository repository;
  HasUserDataUseCase({required this.repository});
  @override
  Future<Either<Failure, UseCaseHasUserDataResult>> call(NoParams params) async {
    final result = await repository.hasUserData();
    return result.fold(
      (failure) => Left(failure),
      (resp) => Right(UseCaseHasUserDataResult(result: resp.result)),
    );
  }
}

class UseCaseHasUserDataResult {
  final bool result;
  const UseCaseHasUserDataResult({required this.result});
}

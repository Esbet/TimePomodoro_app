
import 'package:dartz/dartz.dart';
import 'package:timepomodoro_app/features/time/domain/entities/user_entity.dart';

import '../../../../core/network/failure.dart';
import '../../../../core/usecases/usecases.dart';
import '../repositories/time_repository.dart';

class GetUserUseCase implements UseCase<UseCaseGetUserResult, NoParams> {
  final TimeRepository repository;
  GetUserUseCase({required this.repository});
  @override
  Future<Either<Failure, UseCaseGetUserResult>> call(NoParams params) async {
    final result = await repository.getUser();
    return result.fold(
      (failure) => Left(failure),
      (resp) => Right(UseCaseGetUserResult(result: resp.result)),
    );
  }
}

class UseCaseGetUserResult {
  final UserEntity result;
  const UseCaseGetUserResult({required this.result});
}

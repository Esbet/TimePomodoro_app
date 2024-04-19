import 'package:dartz/dartz.dart';

import '../../../../core/network/failure.dart';
import '../../../../core/usecases/usecases.dart';
import '../repositories/time_repository.dart';

class InsertUserUseCase implements UseCase<UseCaseInsertUserResult, ParamsUseCaseInsertUser> {
  final TimeRepository repository;
  InsertUserUseCase({required this.repository});
  @override
  Future<Either<Failure, UseCaseInsertUserResult>> call(params) async {
    final result = await repository.insertUser(email: params.email, name: params.name);
    return result.fold(
      (failure) => Left(failure),
      (resp) => Right(UseCaseInsertUserResult(result: resp.result)),
    );
  }
}

class ParamsUseCaseInsertUser {
  final String email;
  final String name;
  const ParamsUseCaseInsertUser({
    required this.email, 
    required this.name});
}

class UseCaseInsertUserResult {
  final bool result;
  const UseCaseInsertUserResult({required this.result});
}
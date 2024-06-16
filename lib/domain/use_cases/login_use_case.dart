import 'package:dartz/dartz.dart';
import '../entities/auth_result_entity.dart';
import '../entities/failures.dart';
import '../repository/repository/auth_repository_contract.dart';

class LoginUseCase {
  AuthRepositoryContract repositoryContract;
  LoginUseCase({required this.repositoryContract});

  /// register
  Future<Either<Failures, AuthResultEntity>> invoke(
    String email,
    String password,
  ) {
    return repositoryContract.login(email, password);
  }
}



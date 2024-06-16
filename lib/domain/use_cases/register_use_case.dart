import 'package:dartz/dartz.dart';
import '../entities/auth_result_entity.dart';
import '../entities/failures.dart';
import '../repository/repository/auth_repository_contract.dart';

class RegisterUseCase{
  AuthRepositoryContract repositoryContract ;
  RegisterUseCase({required this.repositoryContract});
  /// register
  Future<Either<Failures,AuthResultEntity>> invoke(String name, String email, String password,
      String rePassword, String phone){
    return repositoryContract.register(name, email, password, rePassword, phone);
  }
}

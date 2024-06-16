import 'package:dartz/dartz.dart';
import '../../entities/auth_result_entity.dart';
import '../../entities/failures.dart';

abstract class AuthRepositoryContract {
  Future<Either<Failures, AuthResultEntity>> register(String name, String email,
      String password, String rePassword, String phone);

  Future<Either<Failures, AuthResultEntity>> login(
      String email, String password);
}

import 'package:dartz/dartz.dart';
import '../../../domain/entities/auth_result_entity.dart';
import '../../../domain/entities/failures.dart';
import '../../../domain/repository/data_source/auth_remote_data_source.dart';
import '../../api/api_manager.dart';

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource{
  ApiManager apiManager ;
  AuthRemoteDataSourceImpl({required this.apiManager});
  @override
  Future<Either<Failures,AuthResultEntity>> register(String name, String email,
      String password, String rePassword, String phone) async{
    var either = await apiManager.register(name, email, password, rePassword, phone);
    return either.fold((l) {
      return Left(Failures(errorMessage: l.errorMessage));
    },
            (response) {
      return Right(response.toAuthResultEntity());
            });
  }

  @override
  Future<Either<Failures, AuthResultEntity>> login(String email, String password)async {
    var either = await apiManager.login(email, password);
    return either.fold((l) {
      return Left(Failures(errorMessage: l.errorMessage));
    }, (response) {
      return Right(response.toAuthResultEntity());
    });
  }
}

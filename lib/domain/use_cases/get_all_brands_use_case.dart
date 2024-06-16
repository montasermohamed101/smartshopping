import 'package:dartz/dartz.dart';
import '../entities/CategoryOrBrandResponseEntity.dart';
import '../entities/failures.dart';
import '../repository/repository/home_repository_contract.dart';

class GetAllBrandsUseCase{
  HomeRepositoryContract repositoryContract ;
  GetAllBrandsUseCase({required this.repositoryContract});

  Future<Either<Failures, CategoryOrBrandResponseEntity>> invoke(){
    return repositoryContract.getAllBrands();
  }
}
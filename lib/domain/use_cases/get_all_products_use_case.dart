import 'package:dartz/dartz.dart';
import '../entities/ProductResponseEntity.dart';
import '../entities/failures.dart';
import '../repository/repository/home_repository_contract.dart';

class GetAllProductsUseCase{
  HomeRepositoryContract repositoryContract ;
  GetAllProductsUseCase({required this.repositoryContract});

  Future<Either<Failures, ProductResponseEntity>> invoke(){
    return repositoryContract.getAllProducts();
  }
}
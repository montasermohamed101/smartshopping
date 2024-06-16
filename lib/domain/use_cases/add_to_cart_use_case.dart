import 'package:dartz/dartz.dart';
import '../entities/AddToCartResponseEntity.dart';
import '../entities/failures.dart';
import '../repository/repository/home_repository_contract.dart';

class AddToCartUseCase{
  HomeRepositoryContract repositoryContract ;
  AddToCartUseCase({required this.repositoryContract});

  Future<Either<Failures, AddToCartResponseEntity>> invoke(String productId){
    return repositoryContract.addToCart(productId);
  }
}
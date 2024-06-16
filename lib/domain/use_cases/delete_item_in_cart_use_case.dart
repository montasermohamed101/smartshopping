import 'package:dartz/dartz.dart';

import '../../data/model/response/GetCartResponseDto.dart';
import '../entities/failures.dart';
import '../repository/repository/cart_repository_contract.dart';

class DeleteItemInCartUseCase {
  CartRepositoryContract repositoryContract;
  DeleteItemInCartUseCase({required this.repositoryContract});

  Future<Either<Failures, CartResponseModel>> invoke(String productId) {
    return repositoryContract.deleteItemInCart(productId);
  }
}

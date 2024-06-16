import 'package:dartz/dartz.dart';

import '../../data/model/response/GetCartResponseDto.dart';
import '../entities/failures.dart';
import '../repository/repository/cart_repository_contract.dart';

class GetCartUseCase {
  CartRepositoryContract repositoryContract;
  GetCartUseCase({required this.repositoryContract});

  Future<Either<Failures, CartResponseModel>> invoke() {
    return repositoryContract.getCart();
  }
}

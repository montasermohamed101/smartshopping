import 'package:dartz/dartz.dart';
import 'package:ecommerce/data/model/response/GetCartResponseDto.dart';

import '../../entities/failures.dart';

abstract class CartRepositoryContract {
  Future<Either<Failures, CartResponseModel>> getCart();
  Future<Either<Failures, CartResponseModel>> deleteItemInCart(
      String productId);
  Future<Either<Failures, CartResponseModel>> updateCountInCart(
      String productId, int count);
}

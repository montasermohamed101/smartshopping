import 'package:dartz/dartz.dart';
import 'package:ecommerce/data/model/response/GetCartResponseDto.dart';

import '../../../domain/entities/failures.dart';
import '../../../domain/repository/data_source/cart_remote_data_source.dart';
import '../../../domain/repository/repository/cart_repository_contract.dart';
class CartRepositoryImpl implements CartRepositoryContract {
  CartRemoteDataSource cartRemoteDataSource;

  CartRepositoryImpl({required this.cartRemoteDataSource});

  @override
  Future<Either<Failures, CartResponseModel>> getCart() {
    return cartRemoteDataSource.getCart();
  }

  @override
  Future<Either<Failures, CartResponseModel>> deleteItemInCart(String productId) {
    return cartRemoteDataSource.deleteItemInCart(productId);
  }

  @override
  Future<Either<Failures, CartResponseModel>> updateCountInCart(String productId, int count) {
    return cartRemoteDataSource.updateCountInCart(productId, count);
  }
}



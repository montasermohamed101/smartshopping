import 'package:dartz/dartz.dart';
import 'package:ecommerce/data/model/response/GetCartResponseDto.dart';

import '../../../domain/entities/failures.dart';
import '../../../domain/repository/data_source/cart_remote_data_source.dart';
import '../../api/api_manager.dart';
class CartRemoteDataSourceImpl implements CartRemoteDataSource {
  final ApiManager apiManager;

  CartRemoteDataSourceImpl({required this.apiManager});

  @override
  Future<Either<Failures, CartResponseModel>> getCart() async {
    try {
      var either = await apiManager.getCart();
      return either.fold(
            (failure) => Left(Failures(errorMessage: failure.errorMessage ?? 'Failed to get cart')),
            (cartResponse) => Right(cartResponse),
      );
    } catch (e) {
      return Left(Failures(errorMessage: 'Exception: $e'));
    }
  }

  @override
  Future<Either<Failures, CartResponseModel>> deleteItemInCart(String productId) async {
    try {
      var either = await apiManager.deleteItemInCart(productId);
      return either.fold(
            (failure) => Left(Failures(errorMessage: failure.errorMessage ?? 'Failed to delete item from cart')),
            (cartResponse) => Right(cartResponse),
      );
    } catch (e) {
      return Left(Failures(errorMessage: 'Exception: $e'));
    }
  }

  @override
  Future<Either<Failures, CartResponseModel>> updateCountInCart(String productId, int count) async {
    try {
      var either = await apiManager.updateCountInCart(productId, count);
      return either.fold(
            (failure) => Left(Failures(errorMessage: failure.errorMessage ?? 'Failed to update item count in cart')),
            (cartResponse) => Right(cartResponse),
      );
    } catch (e) {
      return Left(Failures(errorMessage: 'Exception: $e'));
    }
  }
}


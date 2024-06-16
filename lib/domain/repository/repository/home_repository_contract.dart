import 'package:dartz/dartz.dart';
import '../../entities/AddToCartResponseEntity.dart';
import '../../entities/CategoryOrBrandResponseEntity.dart';
import '../../entities/ProductResponseEntity.dart';
import '../../entities/failures.dart';

abstract class HomeRepositoryContract {
  Future<Either<Failures,CategoryOrBrandResponseEntity>> getAllCategories();
  Future<Either<Failures,CategoryOrBrandResponseEntity>> getAllBrands();
  Future<Either<Failures,ProductResponseEntity>> getAllProducts();
  Future<Either<Failures,AddToCartResponseEntity>> addToCart(String productId);
}
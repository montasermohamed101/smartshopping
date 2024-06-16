import 'package:dartz/dartz.dart';
import 'package:ecommerce/data/model/response/sub_category_model.dart';
import '../../entities/AddToCartResponseEntity.dart';
import '../../entities/CategoryOrBrandResponseEntity.dart';
import '../../entities/ProductResponseEntity.dart';
import '../../entities/failures.dart';

abstract class HomeRemoteDataSource {
  Future<Either<Failures,CategoryOrBrandResponseEntity>> getAllCategories();
  Future<Either<Failures,CategoryOrBrandResponseEntity>> getAllBrands();
  Future<Either<Failures,ProductResponseEntity>> getAllProducts();
  Future<Either<Failures,AddToCartResponseEntity>> addToCart(String productId);
  Future<Either<Failures, List<SubCategoryDto>>> getSubCategories();


}
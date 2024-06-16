import 'package:dartz/dartz.dart';
import 'package:ecommerce/data/model/response/sub_category_model.dart';
import '../../../domain/entities/AddToCartResponseEntity.dart';
import '../../../domain/entities/CategoryOrBrandResponseEntity.dart';
import '../../../domain/entities/ProductResponseEntity.dart';
import '../../../domain/entities/failures.dart';
import '../../../domain/repository/data_source/home_remote_data_source.dart';
import '../../../domain/repository/repository/home_repository_contract.dart';

class HomeRepositoryImpl implements HomeRepositoryContract{
  HomeRemoteDataSource remoteDataSource ;
  HomeRepositoryImpl({required this.remoteDataSource});
  @override
  Future<Either<Failures, CategoryOrBrandResponseEntity>> getAllCategories() {
    return remoteDataSource.getAllCategories();
  }

  @override
  Future<Either<Failures, CategoryOrBrandResponseEntity>> getAllBrands() {
    return remoteDataSource.getAllBrands();
  }

  @override
  Future<Either<Failures, ProductResponseEntity>> getAllProducts() {
    return remoteDataSource.getAllProducts();
  }

  @override
  Future<Either<Failures, AddToCartResponseEntity>> addToCart(String productId) {
    return remoteDataSource.addToCart(productId);
  }
  @override
  Future<Either<Failures, List<SubCategoryDto>>> getSubCategories() async {
    return remoteDataSource.getSubCategories();
  }

}
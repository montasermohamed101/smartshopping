import 'package:dartz/dartz.dart';
import 'package:ecommerce/data/model/response/sub_category_model.dart';
import '../../../domain/entities/AddToCartResponseEntity.dart';
import '../../../domain/entities/CategoryOrBrandResponseEntity.dart';
import '../../../domain/entities/ProductResponseEntity.dart';
import '../../../domain/entities/failures.dart';
import '../../../domain/repository/data_source/home_remote_data_source.dart';
import '../../api/api_manager.dart';

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  ApiManager apiManager;

  HomeRemoteDataSourceImpl({required this.apiManager});

  @override
  Future<Either<Failures, CategoryOrBrandResponseEntity>>
      getAllCategories() async {
    var either = await apiManager.getAllCategories();
    return either.fold((l) {
      return Left(Failures(errorMessage: l.errorMessage));
    }, (response) {
      return Right(response);
    });
  }

  @override
  Future<Either<Failures, CategoryOrBrandResponseEntity>> getAllBrands() async {
    var either = await apiManager.getAllBrands();
    return either.fold((l) {
      return Left(Failures(errorMessage: l.errorMessage));
    }, (response) {
      return Right(response);
    });
  }

  @override
  Future<Either<Failures, ProductResponseEntity>> getAllProducts()async {
    var either = await apiManager.getAllProducts();
    return either.fold((l) {
      return Left(Failures(errorMessage: l.errorMessage));
    }, (response) {
      return Right(response);
    });
  }

  @override
  Future<Either<Failures, AddToCartResponseEntity>> addToCart(String productId)async {
    var either = await apiManager.addToCart(productId);
    return either.fold((l) {
      return Left(Failures(errorMessage: l.errorMessage));
    }, (response) {
      return Right(response);
    });
  }

  @override
  Future<Either<Failures, List<SubCategoryDto>>> getSubCategories() async {
    var either = await apiManager.getSubCategories();
    return either.fold((l) {
      return Left(Failures(errorMessage: l.errorMessage));
    }, (response) {
      return Right(response);
    });
  }
}


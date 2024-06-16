import 'package:ecommerce/ui/home/tabs/product_list_tab/cubit/product_list_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../domain/entities/ProductResponseEntity.dart';
import '../../../../../domain/use_cases/add_to_cart_use_case.dart';
import '../../../../../domain/use_cases/get_all_products_use_case.dart';
import 'package:ecommerce/ui/home/tabs/product_list_tab/cubit/product_list_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../domain/entities/ProductResponseEntity.dart';
import '../../../../../domain/use_cases/add_to_cart_use_case.dart';
import '../../../../../domain/use_cases/get_all_products_use_case.dart';
import 'package:ecommerce/ui/home/tabs/product_list_tab/cubit/product_list_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../domain/entities/ProductResponseEntity.dart';
import '../../../../../domain/use_cases/add_to_cart_use_case.dart';
import '../../../../../domain/use_cases/get_all_products_use_case.dart';

import 'package:ecommerce/ui/home/tabs/product_list_tab/cubit/product_list_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../domain/entities/ProductResponseEntity.dart';
import '../../../../../domain/use_cases/add_to_cart_use_case.dart';
import '../../../../../domain/use_cases/get_all_products_use_case.dart';
import 'package:ecommerce/ui/home/tabs/product_list_tab/cubit/product_list_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../domain/entities/ProductResponseEntity.dart';
import '../../../../../domain/use_cases/add_to_cart_use_case.dart';
import '../../../../../domain/use_cases/get_all_products_use_case.dart';

import 'package:ecommerce/ui/home/tabs/product_list_tab/cubit/product_list_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../domain/entities/ProductResponseEntity.dart';
import '../../../../../domain/use_cases/add_to_cart_use_case.dart';
import '../../../../../domain/use_cases/get_all_products_use_case.dart';

import 'package:ecommerce/ui/home/tabs/product_list_tab/cubit/product_list_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../domain/entities/ProductResponseEntity.dart';
import '../../../../../domain/use_cases/add_to_cart_use_case.dart';
import '../../../../../domain/use_cases/get_all_products_use_case.dart';

class ProductListTabViewModel extends Cubit<ProductListTabStates> {
  final GetAllProductsUseCase getAllProductsUseCase;
  final AddToCartUseCase addToCartUseCase;

  ProductListTabViewModel({
    required this.getAllProductsUseCase,
    required this.addToCartUseCase,
  }) : super(ProductListTabInitialStates());

  List<ProductEntity> productsList = [];
  List<ProductEntity> displayedProductsList = [];
  int currentPage = 0;
  final int itemsPerPage = 2;
  String? currentFilterQuery;

  ProductEntity getProductById(String productId) =>
      productsList.firstWhere((product) => product.id == productId);

  static ProductListTabViewModel get(context) => BlocProvider.of(context);

  Future<void> getProducts() async {
    if (state is ProductListTabLoadingStates) return;

    emit(ProductListTabLoadingStates(loadingMessage: 'Loading...'));

    var either = await getAllProductsUseCase.invoke();
    either.fold((l) {
      emit(ProductListTabErrorStates(errors: l));
    }, (response) {
      productsList = response.data ?? [];
      loadMoreProducts(initialLoad: true);
    });
  }

  void loadMoreProducts({bool initialLoad = false}) {
    if (initialLoad) {
      currentPage = 0;
      displayedProductsList.clear();
    }

    int startIndex = currentPage * itemsPerPage;
    int endIndex = startIndex + itemsPerPage;

    if (startIndex < productsList.length) {
      displayedProductsList.addAll(productsList.sublist(
          startIndex,
          endIndex > productsList.length ? productsList.length : endIndex));
      currentPage += 1;
      emit(ProductListTabSuccessStates(products: displayedProductsList));
    }
  }

  void filterProducts(String query) {
    if (query.isNotEmpty) {
      currentFilterQuery = query;
      displayedProductsList = productsList
          .where((product) =>
          product.title!.toLowerCase().contains(query.toLowerCase()))
          .toList();
      emit(ProductListTabSuccessStates(products: displayedProductsList));
    } else {
      currentFilterQuery = null;
      emit(ProductListTabSuccessStates(products: productsList));
    }
  }
}

// class ProductListTabViewModel extends Cubit<ProductListTabStates> {
//   final GetAllProductsUseCase getAllProductsUseCase;
//   final AddToCartUseCase addToCartUseCase;
//
//   ProductListTabViewModel({
//     required this.getAllProductsUseCase,
//     required this.addToCartUseCase,
//   }) : super(ProductListTabInitialStates());
//
//   List<ProductEntity> productsList = [];
//   List<ProductEntity> displayedProductsList = [];
//   int numOfCartItems = 0;
//   int currentPage = 0;
//   final int itemsPerPage = 2;
//
//   ProductEntity getProductById(String productId) =>
//       productsList.firstWhere((product) => product.id == productId);
//
//   static ProductListTabViewModel get(context) => BlocProvider.of(context);
//
//   Future<void> getProducts() async {
//     if (state is ProductListTabLoadingStates) return;
//
//     emit(ProductListTabLoadingStates(loadingMessage: 'Loading...'));
//
//     var either = await getAllProductsUseCase.invoke();
//     either.fold((l) {
//       emit(ProductListTabErrorStates(errors: l));
//     }, (response) {
//       productsList = response.data ?? [];
//       loadMoreProducts(initialLoad: true);
//     });
//   }
//
//   void loadMoreProducts({bool initialLoad = false}) {
//     if (initialLoad) {
//       currentPage = 0;
//       displayedProductsList.clear();
//     }
//
//     int nextPage = currentPage + 1;
//     int startIndex = currentPage * itemsPerPage;
//     int endIndex = startIndex + itemsPerPage;
//
//     if (startIndex < productsList.length) {
//       displayedProductsList.addAll(productsList.sublist(
//           startIndex,
//           endIndex > productsList.length ? productsList.length : endIndex));
//       currentPage = nextPage;
//       emit(ProductListTabSuccessStates(products: displayedProductsList));
//     }
//   }
//
//   void filterProducts(String query) {
//     displayedProductsList = productsList
//         .where((product) => product.title!.toLowerCase().contains(query.toLowerCase()))
//         .toList();
//     emit(ProductListTabSuccessStates(products: displayedProductsList));
//   }
// }

/*
class ProductListTabViewModel extends Cubit<ProductListTabStates> {
  final GetAllProductsUseCase getAllProductsUseCase;
  final AddToCartUseCase addToCartUseCase;

  ProductListTabViewModel({
    required this.getAllProductsUseCase,
    required this.addToCartUseCase,
  }) : super(ProductListTabInitialStates());

  List<ProductEntity> productsList = [];
  List<ProductEntity> displayedProductsList = [];
  int numOfCartItems = 0;
  int currentPage = 0;
  final int itemsPerPage = 10;

  ProductEntity getProductById(String productId) =>
      productsList.firstWhere((product) => product.id == productId);

  static ProductListTabViewModel get(context) => BlocProvider.of(context);

  Future<void> getProducts() async {
    if (productsList.isNotEmpty) {
      emit(ProductListTabSuccessStates(products: displayedProductsList));
      return;
    }

    if (state is ProductListTabLoadingStates) return;

    emit(ProductListTabLoadingStates(loadingMessage: 'Loading...'));

    var either = await getAllProductsUseCase.invoke();
    either.fold((l) {
      emit(ProductListTabErrorStates(errors: l));
    }, (response) {
      productsList = response.data ?? [];
      currentPage = 0;
      displayedProductsList.clear();
      loadMoreProducts();
    });
  }

  void loadMoreProducts() {
    if (state is ProductListTabLoadingStates) return;

    int startIndex = currentPage * itemsPerPage;
    int endIndex = startIndex + itemsPerPage;

    if (startIndex < productsList.length) {
      displayedProductsList.addAll(productsList.sublist(
        startIndex,
        endIndex > productsList.length ? productsList.length : endIndex,
      ));
      currentPage++;
      emit(ProductListTabSuccessStates(products: displayedProductsList));
    }
  }

  void filterProducts(String query) {
    if (query.isEmpty) {
      displayedProductsList = List.from(productsList);
    } else {
      displayedProductsList = productsList
          .where((product) =>
          product.title!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    emit(ProductListTabSuccessStates(products: displayedProductsList));
  }
}
*/

// class ProductListTabViewModel extends Cubit<ProductListTabStates> {
//   final GetAllProductsUseCase getAllProductsUseCase;
//   final AddToCartUseCase addToCartUseCase;
//
//   ProductListTabViewModel({
//     required this.getAllProductsUseCase,
//     required this.addToCartUseCase,
//   }) : super(ProductListTabInitialStates());
//
//   List<ProductEntity> productsList = [];
//   List<ProductEntity> displayedProductsList = [];
//   int numOfCartItems = 0;
//   int currentPage = 0;
//   final int itemsPerPage = 2;
//
//   ProductEntity getProductById(String productId) =>
//       productsList.firstWhere((product) => product.id == productId);
//
//   static ProductListTabViewModel get(context) => BlocProvider.of(context);
//
//   Future<void> getProducts() async {
//     if (state is ProductListTabLoadingStates) return;
//
//     emit(ProductListTabLoadingStates(loadingMessage: 'Loading...'));
//
//     var either = await getAllProductsUseCase.invoke();
//     either.fold((l) {
//       emit(ProductListTabErrorStates(errors: l));
//     }, (response) {
//       productsList = response.data ?? [];
//       loadMoreProducts();
//     });
//   }
//
//   void loadMoreProducts() {
//     int nextPage = currentPage + 1;
//     int startIndex = currentPage * itemsPerPage;
//     int endIndex = startIndex + itemsPerPage;
//
//     if (startIndex < productsList.length) {
//       displayedProductsList.addAll(productsList.sublist(
//           startIndex,
//           endIndex > productsList.length ? productsList.length : endIndex));
//       currentPage = nextPage;
//       emit(ProductListTabSuccessStates(products: displayedProductsList));
//     }
//   }
// }

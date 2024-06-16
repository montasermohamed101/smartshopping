import 'package:ecommerce/data/model/response/GetCartResponseDto.dart';
import 'package:ecommerce/data/model/response/ProductResponseDto.dart';

import '../../../../domain/entities/AddToCartResponseEntity.dart';
import '../../../../domain/entities/GetCartResponseEntity.dart';
import '../../../../domain/entities/failures.dart';

abstract class CartStates {}

class GetCartInitialStates extends CartStates {}

class GetCartLoadingStates extends CartStates {
  String? loadingMessage;

  GetCartLoadingStates({required this.loadingMessage});
}

class GetCartErrorStates extends CartStates {
  Failures errors;

  GetCartErrorStates({required this.errors});
}
class UpdateTotalCartPriceSuccessState extends CartStates {
  final double totalPrice;

  UpdateTotalCartPriceSuccessState(this.totalPrice);

  @override
  List<Object> get props => [totalPrice];
}
class GetCartSuccessStates extends CartStates {
  CartResponseModel getCartResponseEntity;

  GetCartSuccessStates({required this.getCartResponseEntity});
}

class GetSpecificCartProductSuccessStates extends CartStates {
  ProductDto product;

  GetSpecificCartProductSuccessStates({required this.product});
}

class DeleteItemInCartLoadingStates extends CartStates {
  String? loadingMessage;

  DeleteItemInCartLoadingStates({required this.loadingMessage});
}

class DeleteItemInCartErrorStates extends CartStates {
  Failures errors;

  DeleteItemInCartErrorStates({required this.errors});
}

class DeleteItemInSuccessStates extends CartStates {

}

class UpdateCountInCartLoadingStates extends CartStates {
  String? loadingMessage;

  UpdateCountInCartLoadingStates({required this.loadingMessage});
}

class UpdateCountInCartErrorStates extends CartStates {
  Failures errors;

  UpdateCountInCartErrorStates({required this.errors});
}

class UpdateCountInSuccessStates extends CartStates {
  GetCartResponseEntity getCartResponseEntity;

  UpdateCountInSuccessStates({required this.getCartResponseEntity});
}

class AddToCartLoadingStates extends CartStates {
  String? loadingMessage;

  AddToCartLoadingStates({required this.loadingMessage});
}

class AddToCartTabErrorStates extends CartStates {
  Failures errors;

  AddToCartTabErrorStates({required this.errors});
}

class AddToCartSuccessStates extends CartStates {
  AddToCartResponseEntity addToCartResponseEntity;

  AddToCartSuccessStates({required this.addToCartResponseEntity});
}

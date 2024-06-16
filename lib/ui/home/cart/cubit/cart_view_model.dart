import 'package:ecommerce/data/model/response/GetCartResponseDto.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/api/api_manager.dart';
import '../../../../domain/use_cases/add_to_cart_use_case.dart';
import '../../../../domain/use_cases/delete_item_in_cart_use_case.dart';
import '../../../../domain/use_cases/get_cart_use_case.dart';
import '../../../../domain/use_cases/update_count_in_cart_use_case.dart';
import 'cart_states.dart';

class CartViewModel extends Cubit<CartStates> {
  GetCartUseCase getCartUseCase;
  DeleteItemInCartUseCase deleteItemInCartUseCase;
  UpdateCountInCartUseCase updateCountInCartUseCase;
  AddToCartUseCase addToCartUseCase;
  CartViewModel(
      {required this.getCartUseCase,
      required this.deleteItemInCartUseCase,
      required this.updateCountInCartUseCase,
      required this.addToCartUseCase})
      : super(GetCartInitialStates());

  CartResponseModel? cartResponseModel;

  static CartViewModel get(context) => BlocProvider.of(context);

  final List<CartItemData> cartItems = [];

  int numOfCartItems = 0;

  bool isInCart(String productId) {
    bool isInCart = false;

    for (final item in cartItems) {
      if (item.product == productId) {
        isInCart = true;
      }
    }
    return isInCart;
  }

  getCart() async {
    emit(GetCartLoadingStates(loadingMessage: 'Loading...'));
    var either = await getCartUseCase.invoke();
    either.fold((l) {
      emit(GetCartErrorStates(errors: l));
    }, (response) {
      cartResponseModel = response;
      cartItems.clear();
      for (final item in response.cart.cartItems) {
        cartItems.add(item);
      }
      emit(GetCartSuccessStates(getCartResponseEntity: response));
    });
  }


  deleteItemInCart(String productId) async {
    emit(DeleteItemInCartLoadingStates(loadingMessage: 'Loading...'));
    var either = await deleteItemInCartUseCase.invoke(productId);
    either.fold((l) {
      emit(DeleteItemInCartErrorStates(errors: l));
    }, (response) {

      cartItems.removeWhere((item) => item.id == productId);

      emit(GetCartSuccessStates(getCartResponseEntity: response));
    });
  }

  updateCountInCart(String productId, int count) async {
    emit(UpdateCountInCartLoadingStates(loadingMessage: 'Loading...'));
    var either = await updateCountInCartUseCase.invoke(productId, count);
    either.fold((l) {
      emit(UpdateCountInCartErrorStates(errors: l));
    }, (response) {
      print('update successfully');
      emit(GetCartSuccessStates(getCartResponseEntity: response));
    });
  }

  getSpecifCartProduct(String productId) async {
    emit(UpdateCountInCartLoadingStates(loadingMessage: 'Loading...'));
    var either = await ApiManager.getInstance().getSpecificProduct(productId);
    either.fold((l) {
      emit(UpdateCountInCartErrorStates(errors: l));
    }, (response) {
      print('got product successfully');
      emit(GetSpecificCartProductSuccessStates(product: response));
    });
  }

  addToCart(String productId) async {
    emit(AddToCartLoadingStates(loadingMessage: 'Loading...'));
    var either = await addToCartUseCase.invoke(productId);
    either.fold((l) {
      emit(AddToCartTabErrorStates(errors: l));
    }, (response) async {
      numOfCartItems = response.numOfCartItems ?? 0;
      print('numOfCartItems: $numOfCartItems');
      await getCart();
      emit(AddToCartSuccessStates(addToCartResponseEntity: response));
    });
  }
}

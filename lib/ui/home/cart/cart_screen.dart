import 'package:ecommerce/ui/home/cart/widget/cart_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/utils/my_colors.dart';
import '../../../domain/di.dart';
import 'cubit/cart_states.dart';
import 'cubit/cart_view_model.dart';
class CartScreen extends StatelessWidget {
  static const String routeName = 'cart-screen';
  final CartViewModel viewModel = CartViewModel(
    getCartUseCase: injectGetCartUseCase(),
    updateCountInCartUseCase: injectUpdateCountInCartUseCase(),
    deleteItemInCartUseCase: injectDeleteItemInCartUseCase(),
    addToCartUseCase: injectAddToCartUseCase(),
  );

  CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CartViewModel>(
      create: (context) => viewModel..getCart(),
  child: BlocConsumer<CartViewModel, CartStates>(
      bloc: viewModel..getCart(),
      listener: (context, state) {},
      builder: (context, state) {
        if (state is GetCartLoadingStates) {
          return const Scaffold(body: Center(child: CircularProgressIndicator(color: AppColors.primaryColor)),);
        }
        else if (state is GetCartSuccessStates) {
          return Scaffold(
              appBar: AppBar(
                centerTitle: true,
                backgroundColor: Colors.transparent,
                elevation: 0,
                leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.arrow_back,
                      color: Theme
                          .of(context)
                          .primaryColor),
                ),
                title: Text(
                  'Cart',
                  style: Theme
                      .of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(color: Theme
                      .of(context)
                      .primaryColor),
                ),
                actions: [
                  IconButton(
                    onPressed: () {

                    },
                    icon:
                    Icon(Icons.search, color: Theme
                        .of(context)
                        .primaryColor),
                  ),
                  IconButton(
                    onPressed: () {

                    },
                    icon: const Icon(Icons.shopping_cart_outlined,
                        color: AppColors.primaryColor),
                  ),
                ],
              ),
              body: state is GetCartSuccessStates
                  ? Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        return CartItem(
                            cartItem: state.getCartResponseEntity.cart
                                .cartItems[index]);
                      },
                      itemCount:
                      state.getCartResponseEntity.cart.cartItems.length,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        bottom: 98.h, left: 16.w, right: 16.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(bottom: 12.h),
                              child: Text('Total Price',
                                  style: Theme
                                      .of(context)
                                      .textTheme
                                      .titleMedium
                                      ?.copyWith(
                                      color: AppColors.greyColor)),
                            ),
                            Text(
                                'EGP ${state.getCartResponseEntity.cart
                                    .totalPrice ?? 0}',
                                style: Theme
                                    .of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.primaryColor)),
                          ],
                        ),
                        InkWell(
                          onTap: () {
                            //logic here
                          },
                          child: Container(
                            height: 48.h,
                            width: 270.w,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.r),
                                color: Theme
                                    .of(context)
                                    .primaryColor),
                            child: Padding(
                              padding:
                              EdgeInsets.only(top: 12.h, bottom: 12.h),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceEvenly,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(left: 83.w),
                                    child: Text('Check out',
                                        style: Theme
                                            .of(context)
                                            .textTheme
                                            .titleMedium),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: 27.w, right: 32.w),
                                    child: Icon(Icons.arrow_forward,
                                        size: 20.w,
                                        color: AppColors.whiteColor),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              )
                  : const Center(
                child: CircularProgressIndicator(
                    color: AppColors.primaryColor),
              ));
        }
        else {
          return const Scaffold(body: Center(
            child: CircularProgressIndicator(
                color: AppColors.primaryColor),
          ),);
        }
      },
    ),
);
  }
}

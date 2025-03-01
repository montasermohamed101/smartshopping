import 'package:ecommerce/ui/home/cart/cubit/cart_states.dart';
import 'package:ecommerce/ui/home/cart/cubit/cart_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:readmore/readmore.dart';
import '../../../core/utils/my_assets.dart';
import '../../../core/utils/my_colors.dart';
import '../../../domain/entities/ProductResponseEntity.dart';




class ProductDetailsView extends StatefulWidget {
  static String routeName = "product-details-view";

  const ProductDetailsView({super.key});

  @override
  State<ProductDetailsView> createState() => _ProductDetailsViewState();
}

class _ProductDetailsViewState extends State<ProductDetailsView> {
  int quantity = 1;
  double price = 134.0;

  void _incrementQuantity() {
    setState(() {
      quantity++;
      _updateTotalPrice();
    });
  }

  void _decrementQuantity() {
    if (quantity > 1) {
      setState(() {
        quantity--;
        _updateTotalPrice();
      });
    }
  }

  void _updateTotalPrice() {
    setState(() {
      price = 134.0 * quantity;
    });
  }
  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)!.settings.arguments as ProductEntity;
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        centerTitle: true,
        elevation: 0,
        title: const Text("Product details"),
        backgroundColor: Colors.transparent,
        foregroundColor: AppColors.primaryColor,
        titleTextStyle: Theme.of(context).textTheme.titleLarge!.copyWith(
          fontSize: 20.sp,
          color: AppColors.darkPrimaryColor,
          fontWeight: FontWeight.bold,
        ),
        actions: [
          IconButton(
            padding: EdgeInsets.zero,
            onPressed: () {},
            icon: const Icon(Icons.search),
          ),
          IconButton(
            padding: EdgeInsets.zero,
            onPressed: () {
            },
            icon: const Icon(Icons.shopping_cart_outlined),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.r),
                    border: Border.all(color: AppColors.greyColor, width: 2)),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.r),
                  child: Image.network(
                    args.images!.first,
                    fit: BoxFit.cover,
                    height: 300.h,
                    width: double.infinity,
                  ),
                ),
              ),
              SizedBox(height: 24.h),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      args.title ?? '',
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        fontSize: 18.sp,
                        color: AppColors.darkPrimaryColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Text(
                    args.price != null ? "EGP ${price.toStringAsFixed(2)}" : "EGP 134",
                    style: TextStyle(
                      fontSize: 18.sp,
                      color: AppColors.darkPrimaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
              SizedBox(height: 16.h),
              Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 16.w, vertical: 8.h),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100.r),
                            border: Border.all(
                              color: AppColors.primaryColor,
                              width: 1,
                            ),
                          ),
                          child: Text(
                            args.sold != null
                                ? "Sold : ${price.toStringAsFixed(2)}"
                                : "Sold : available",
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(
                              color: AppColors.darkPrimaryColor,
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(width: 16.w),
                        Image.asset(MyAssets.starIcon),
                        SizedBox(width: 4.w),
                        Text(
                          args.ratingsAverage != null
                              ? "${args.ratingsAverage}"
                              : '3',
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall!
                              .copyWith(
                            color: AppColors.darkPrimaryColor,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 16.w),
                  BlocBuilder<CartViewModel, CartStates>(
                    builder: (context, state) {
                      return Container(
                        height: 50.h,
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor,
                          borderRadius: BorderRadius.circular(100.r),
                        ),
                        child: Row(
                          children: [
                            IconButton(
                              padding: EdgeInsets.zero,
                              onPressed: _decrementQuantity,
                              icon: Icon(
                                Icons.remove_circle_outline_rounded,
                                color: AppColors.whiteColor,
                                size: 28.sp,
                              ),
                            ),
                            Text(
                              '$quantity',
                              style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w500,
                                color: AppColors.whiteColor,
                              ),
                            ),
                            IconButton(
                              padding: EdgeInsets.zero,
                              onPressed: _incrementQuantity,
                              icon: Icon(
                                Icons.add_circle_outline_rounded,
                                color: AppColors.whiteColor,
                                size: 28.sp,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
              SizedBox(height: 24.h),
              Text(
                "Description",
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.darkPrimaryColor,
                ),
              ),
              SizedBox(height: 10.h),
              ReadMoreText(
                args.description ?? '',
                trimLines: 3,
                trimMode: TrimMode.Line,
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  fontSize: 14.sp,
                  color: AppColors.primaryColor.withOpacity(0.6),
                ),
                trimCollapsedText: ' Show More',
                trimExpandedText: ' Show Less',
                moreStyle: Theme.of(context).textTheme.titleSmall!.copyWith(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.darkPrimaryColor),
                lessStyle: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.darkPrimaryColor),
              ),
              SizedBox(height: 16.h),
              SizedBox(height: 120.h),
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Total price",
                        style:
                        Theme.of(context).textTheme.titleMedium!.copyWith(
                          fontSize: 18.sp,
                          color: AppColors.primaryColor,
                        ),
                      ),
                      SizedBox(height: 5.h),
                      Text(
                        args.price != null ? "EGP ${price.toStringAsFixed(2)}" : "EGP 134",
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(
                          fontSize: 18.sp,
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: 32.w),
                  BlocBuilder<CartViewModel, CartStates>(
                    builder: (context, state) {
                      final viewModel = CartViewModel.get(context);
                      return Expanded(
                        child: viewModel.isInCart(args.id!)
                            ? Container(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          decoration: BoxDecoration(
                            color: AppColors.primaryColor,
                            borderRadius: BorderRadius.circular(16.r),
                          ),
                          child: Text(
                            "In cart",
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium,
                            textAlign: TextAlign.center,
                          ),
                        )
                            : ElevatedButton(
                          onPressed: state is AddToCartLoadingStates ||
                              state is GetCartLoadingStates
                              ? null
                              : () {
                            if (!viewModel.isInCart(args.id!)) {
                              viewModel.addToCart(args.id!);
                            }
                          },
                          style: TextButton.styleFrom(
                            backgroundColor: AppColors.primaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16.r),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceEvenly,
                            children: [
                              const Icon(Icons.add_shopping_cart_outlined),
                              Text("Add to cart",
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}



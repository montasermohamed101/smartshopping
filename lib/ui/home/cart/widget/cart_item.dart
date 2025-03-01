import 'package:ecommerce/data/model/response/GetCartResponseDto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/my_colors.dart';
import '../../tabs/product_list_tab/cubit/product_list_tab_view_model.dart';
import '../cubit/cart_view_model.dart';


class CartItem extends StatefulWidget {
  final CartItemData cartItem;

  const CartItem({super.key, required this.cartItem});

  @override
  _CartItemState createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  late int quantity;
  late double totalPrice;

  @override
  void initState() {
    super.initState();
    quantity = widget.cartItem.quantity ?? 1;
    totalPrice = widget.cartItem.price * quantity.toDouble();
  }

  void _incrementQuantity() {
    setState(() {
      quantity++;
      totalPrice = widget.cartItem.price * quantity.toDouble();
    });
  }

  void _decrementQuantity() {
    if (quantity > 1) {
      setState(() {
        quantity--;
        totalPrice = widget.cartItem.price * quantity.toDouble();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final product = ProductListTabViewModel.get(context).getProductById(widget.cartItem.product);

    return Padding(
      padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 24.h, bottom: 24.h),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.r),
          border: Border.all(width: 1.w, color: AppColors.lightGreyColor),
        ),
        width: 398.w,
        height: 145.h,
        child: Row(children: [
          Container(
            clipBehavior: Clip.antiAlias,
            height: 145.h,
            width: 130.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.r),
            ),
            child: Image.network(
              product.imageCover != null
                  ? product.imageCover ?? ''
                  : product.images?.first ?? '',
              fit: BoxFit.fill,
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 8.w, right: 8.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 16.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "", // cartItem.product?.title ??
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(
                              color: AppColors.primaryColor,
                              fontWeight: FontWeight.bold),
                        ),
                        InkWell(
                          onTap: () {
                            CartViewModel.get(context).deleteItemInCart(widget.cartItem.id ?? "");
                          },
                          child: const Icon(
                            Icons.delete_outline,
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 13.h, bottom: 13.h),
                    child: Row(
                      children: [
                        Text('Count: $quantity',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(color: AppColors.blueGreyColor)),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 14.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('EGP $totalPrice',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(
                                  color: AppColors.primaryColor,
                                  fontWeight: FontWeight.bold)),
                          Container(
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
                                  quantity.toString(),
                                  style: TextStyle(
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.whiteColor),
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
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }
}


import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce/ui/home/cart/cubit/cart_states.dart';
import 'package:ecommerce/ui/home/cart/cubit/cart_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../core/utils/my_assets.dart';
import '../../../../../core/utils/my_colors.dart';
import '../../../../../domain/entities/ProductResponseEntity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';

class GridViewCardItem extends StatefulWidget {
  final ProductEntity productEntity;
  final int index;

  GridViewCardItem({Key? key, required this.productEntity, required this.index}) : super(key: key);

  @override
  State<GridViewCardItem> createState() => _GridViewCardItemState();
}

class _GridViewCardItemState extends State<GridViewCardItem> {
  bool isWishlisted = false;
  final List<int> ratings = [4, 2, 5, 3, 4, 2, 5, 3, 4, 4, 3, 2];


  @override
  void initState() {
    super.initState();
    checkWishlistStatus();
  }

  Future<void> checkWishlistStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> wishlist = prefs.getStringList('wishlist') ?? [];
    setState(() {
      isWishlisted = wishlist.any((productJson) {
        Map<String, dynamic> productMap = jsonDecode(productJson);
        return productMap['id'] == widget.productEntity.id;
      });
    });
  }

  Future<void> addToWishlist(ProductEntity product) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> wishlist = prefs.getStringList('wishlist') ?? [];
    wishlist.add(jsonEncode(product.toJson()));
    await prefs.setStringList('wishlist', wishlist);
  }

  Future<void> removeFromWishlist(String productId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> wishlist = prefs.getStringList('wishlist') ?? [];
    wishlist.removeWhere((productJson) {
      Map<String, dynamic> productMap = jsonDecode(productJson);
      return productMap['id'] == productId;
    });
    await prefs.setStringList('wishlist', wishlist);
  }

  // double get averageRating {
  //   if (ratings.isEmpty) return 0;
  //   return ratings.reduce((a, b) => a + b) / ratings.length;
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 191.w,
      height: 237.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.r),
        border: Border.all(
          color: AppColors.primaryColor,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15.r),
                child: CachedNetworkImage(
                  imageUrl: widget.productEntity.imageCover != null
                      ? widget.productEntity.imageCover ?? ''
                      : widget.productEntity.images?.first ?? "",
                  fit: BoxFit.cover,
                  width: 191.w,
                  height: 128.h,
                ),
              ),
              Positioned(
                top: 5.h,
                right: 2.w,
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 15,
                  child: IconButton(
                    color: AppColors.primaryColor,
                    padding: EdgeInsets.zero,
                    onPressed: () async {
                      if (isWishlisted) {
                        await removeFromWishlist(widget.productEntity.id!);
                      } else {
                        await addToWishlist(widget.productEntity);
                      }
                      setState(() {
                        isWishlisted = !isWishlisted;
                      });
                    },
                    icon: isWishlisted
                        ? const Icon(Icons.favorite_rounded)
                        : const Icon(Icons.favorite_border_rounded),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 7.h),
          Padding(
            padding: EdgeInsets.only(left: 8.w),
            child: Text(
              widget.productEntity.title ?? "",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                fontSize: 14.sp,
                color: AppColors.darkPrimaryColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          SizedBox(height: 7.h),
          Padding(
            padding: EdgeInsets.only(left: 8.w),
            child: Row(
              children: [
                Text(
                  widget.productEntity.price != null
                      ? "EGP ${widget.productEntity.price}"
                      : "EGP 134",
                  maxLines: 1,
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    fontSize: 14.sp,
                    color: AppColors.darkPrimaryColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(width: 10.w),
              ],
            ),
          ),
          SizedBox(height: 7.h),
          Padding(
            padding: EdgeInsets.only(left: 8.0.w, right: 8.w),
            child: Row(
              children: [
                RatingBarIndicator(
                  rating: ratings[widget.index].toDouble(),
                  itemBuilder: (context, index) => const Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  itemCount: 5,
                  itemSize: 16.0,
                  direction: Axis.horizontal,
                ),
                SizedBox(width: 7.w),
                Text(
                  "(${ratings[widget.index]})",
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    fontSize: 14.sp,
                    color: AppColors.darkPrimaryColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Spacer(flex: 1),
                BlocBuilder<CartViewModel, CartStates>(
                  builder: (context, state) {
                    final viewModel = CartViewModel.get(context);
                    return InkWell(
                      onTap: state is AddToCartLoadingStates || state is GetCartLoadingStates
                          ? null
                          : () {
                        if (!viewModel.isInCart(widget.productEntity.id!)) {
                          CartViewModel.get(context).addToCart(widget.productEntity.id ?? "");
                        }
                      },
                      splashColor: Colors.transparent,
                      child: Icon(
                        viewModel.isInCart(widget.productEntity.id!)
                            ? Icons.done
                            : Icons.add_circle,
                        size: 32.sp,
                        color: AppColors.primaryColor,
                      ),
                    );
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// class GridViewCardItem extends StatefulWidget {
//   final ProductEntity productEntity;
//
//   GridViewCardItem({Key? key, required this.productEntity}) : super(key: key);
//
//   @override
//   State<GridViewCardItem> createState() => _GridViewCardItemState();
// }
//
// class _GridViewCardItemState extends State<GridViewCardItem> {
//   bool isWishlisted = false;
//
//   @override
//   void initState() {
//     super.initState();
//     checkWishlistStatus();
//   }
//
//   Future<void> checkWishlistStatus() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     List<String> wishlist = prefs.getStringList('wishlist') ?? [];
//     setState(() {
//       isWishlisted = wishlist.any((productJson) {
//         Map<String, dynamic> productMap = jsonDecode(productJson);
//         return productMap['id'] == widget.productEntity.id;
//       });
//     });
//   }
//
//   Future<void> addToWishlist(ProductEntity product) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     List<String> wishlist = prefs.getStringList('wishlist') ?? [];
//     wishlist.add(jsonEncode(product.toJson()));
//     await prefs.setStringList('wishlist', wishlist);
//   }
//
//   Future<void> removeFromWishlist(String productId) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     List<String> wishlist = prefs.getStringList('wishlist') ?? [];
//     wishlist.removeWhere((productJson) {
//       Map<String, dynamic> productMap = jsonDecode(productJson);
//       return productMap['id'] == productId;
//     });
//     await prefs.setStringList('wishlist', wishlist);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 191.w,
//       height: 237.h,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(15.r),
//         border: Border.all(
//           color: AppColors.primaryColor,
//           width: 1,
//         ),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Stack(
//             children: [
//               ClipRRect(
//                 borderRadius: BorderRadius.circular(15.r),
//                 child: CachedNetworkImage(
//                  imageUrl:  widget.productEntity.imageCover != null
//                       ? widget.productEntity.imageCover ?? ''
//                       : widget.productEntity.images?.first ?? "",
//                   fit: BoxFit.cover,
//                   width: 191.w,
//                   height: 128.h,
//                 ),
//               ),
//               Positioned(
//                 top: 5.h,
//                 right: 2.w,
//                 child: CircleAvatar(
//                   backgroundColor: Colors.white,
//                   radius: 15,
//                   child: IconButton(
//                     color: AppColors.primaryColor,
//                     padding: EdgeInsets.zero,
//                     onPressed: () async {
//                       if (isWishlisted) {
//                         await removeFromWishlist(widget.productEntity.id!);
//                       } else {
//                         await addToWishlist(widget.productEntity);
//                       }
//                       setState(() {
//                         isWishlisted = !isWishlisted;
//                       });
//                     },
//                     icon: isWishlisted
//                         ? const Icon(Icons.favorite_rounded)
//                         : const Icon(Icons.favorite_border_rounded),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(height: 7.h),
//           Padding(
//             padding: EdgeInsets.only(left: 8.w),
//             child: Text(
//               widget.productEntity.title ?? "",
//               maxLines: 1,
//               overflow: TextOverflow.ellipsis,
//               style: Theme.of(context).textTheme.titleSmall!.copyWith(
//                 fontSize: 14.sp,
//                 color: AppColors.darkPrimaryColor,
//                 fontWeight: FontWeight.w500,
//               ),
//             ),
//           ),
//           SizedBox(height: 7.h),
//           Padding(
//             padding: EdgeInsets.only(left: 8.w),
//             child: Row(
//               children: [
//                 Text(
//                   widget.productEntity.price != null
//                       ? "EGP ${widget.productEntity.price}"
//                       : "EGP 134",
//                   maxLines: 1,
//                   style: Theme.of(context).textTheme.titleSmall!.copyWith(
//                     fontSize: 14.sp,
//                     color: AppColors.darkPrimaryColor,
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//                 SizedBox(width: 10.w),
//               ],
//             ),
//           ),
//           SizedBox(height: 7.h),
//           Padding(
//             padding: EdgeInsets.only(left: 8.0.w, right: 8.w),
//             child: Row(
//               children: [
//                 Text(
//                   widget.productEntity.ratingsAverage != null
//                       ? "Review (${widget.productEntity.ratingsAverage})"
//                       : "Review (3)",
//                   maxLines: 1,
//                   style: Theme.of(context).textTheme.titleSmall!.copyWith(
//                     fontSize: 14.sp,
//                     color: AppColors.darkPrimaryColor,
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//                 SizedBox(width: 7.w),
//                 Image.asset(MyAssets.starIcon),
//                 const Spacer(flex: 1),
//                 BlocBuilder<CartViewModel, CartStates>(
//                   builder: (context, state) {
//                     final viewModel = CartViewModel.get(context);
//                     return InkWell(
//                       onTap: state is AddToCartLoadingStates || state is GetCartLoadingStates
//                           ? null
//                           : () {
//                         if (!viewModel.isInCart(widget.productEntity.id!)) {
//                           CartViewModel.get(context).addToCart(widget.productEntity.id ?? "");
//                         }
//                       },
//                       splashColor: Colors.transparent,
//                       child: Icon(
//                         viewModel.isInCart(widget.productEntity.id!)
//                             ? Icons.done
//                             : Icons.add_circle,
//                         size: 32.sp,
//                         color: AppColors.primaryColor,
//                       ),
//                     );
//                   },
//                 )
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

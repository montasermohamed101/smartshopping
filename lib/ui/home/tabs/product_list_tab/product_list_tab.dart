import 'package:ecommerce/core/utils/my_assets.dart';
import 'package:ecommerce/core/utils/my_colors.dart';
import 'package:ecommerce/ui/home/cart/cubit/cart_states.dart';
import 'package:ecommerce/ui/home/cart/cubit/cart_view_model.dart';
import 'package:ecommerce/ui/home/tabs/home_tab/widgets/custom_text_field.dart';
import 'package:ecommerce/ui/home/tabs/product_list_tab/cubit/product_list_states.dart';
import 'package:ecommerce/ui/home/tabs/product_list_tab/cubit/product_list_tab_view_model.dart';
import 'package:ecommerce/ui/home/tabs/product_list_tab/widgets/grid_view_card_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../cart/cart_screen.dart';
import '../../product_details/product_details_view.dart';

class ProductListTab extends StatefulWidget {
  const ProductListTab({super.key});

  @override
  _ProductListTabState createState() => _ProductListTabState();
}

class _ProductListTabState extends State<ProductListTab>
    with AutomaticKeepAliveClientMixin<ProductListTab> {
  final TextEditingController _searchController = TextEditingController();
  bool _isFirstLoad = true;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    final viewModel = ProductListTabViewModel.get(context);
    if (_isFirstLoad) {
      viewModel.getProducts();
      _isFirstLoad = false;
    }
    _searchController.addListener(() {
      viewModel.filterProducts(_searchController.text);
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocConsumer<ProductListTabViewModel, ProductListTabStates>(
      listener: (BuildContext context, ProductListTabStates state) {},
      builder: (context, state) {
        final viewModel = ProductListTabViewModel.get(context);

        return SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 17.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10.h),
                Image.asset(
                  MyAssets.logo,
                  alignment: Alignment.topLeft,
                ),
                SizedBox(height: 18.h),
                Row(
                  children: [
                    Expanded(
                      child: CustomTextField(
                        controller: _searchController,
                      ),
                    ),
                    SizedBox(width: 24.w),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pushNamed(CartScreen.routeName);
                      },
                      child: Badge(
                        label: BlocBuilder<CartViewModel, CartStates>(
                          builder: (context, state) {
                            return Text(CartViewModel.get(context)
                                .cartItems
                                .length
                                .toString());
                          },
                        ),
                        child: ImageIcon(
                          const AssetImage(MyAssets.shoppingCart),
                          size: 28.sp,
                          color: AppColors.primaryColor,
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 24.h),
                if (state is ProductListTabLoadingStates && !_isFirstLoad)
                  const Center(
                    child: CircularProgressIndicator(
                      color: AppColors.primaryColor,
                    ),
                  )
                else if (state is ProductListTabSuccessStates)
                  Expanded(
                    child: NotificationListener<ScrollNotification>(
                      onNotification: (ScrollNotification scrollInfo) {
                        if (scrollInfo is ScrollEndNotification &&
                            scrollInfo.metrics.pixels ==
                                scrollInfo.metrics.maxScrollExtent) {
                          viewModel.loadMoreProducts();
                        }
                        return true;
                      },
                      child: GridView.builder(
                        itemCount: viewModel.displayedProductsList.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 2 / 2.4,
                          crossAxisSpacing: 16.w,
                          mainAxisSpacing: 16.h,
                        ),
                        itemBuilder: (context, index) {
                          final product = viewModel.displayedProductsList[index];
                          return InkWell(
                            splashColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () {
                              Navigator.of(context).pushNamed(
                                ProductDetailsView.routeName,
                                arguments: product,
                              );
                            },
                            child: GridViewCardItem(productEntity: product,index:index),
                          );
                        },
                      ),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}

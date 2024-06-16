import 'package:ecommerce/ui/home/tabs/home_tab/widgets/annountcements_section.dart';
import 'package:ecommerce/ui/home/tabs/home_tab/widgets/categories_or_brands_section.dart';
import 'package:ecommerce/ui/home/tabs/home_tab/widgets/custom_search_with_shopping_cart.dart';
import 'package:ecommerce/ui/home/tabs/home_tab/widgets/row_section_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/my_assets.dart';
import '../../../../core/utils/my_colors.dart';
import '../../../../domain/di.dart';
import 'cubit/home_tab_states.dart';
import 'cubit/home_tab_view_model.dart';
import 'list_screen.dart';
class HomeTab extends StatefulWidget {
  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  late final HomeTabViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = HomeTabViewModel(
      getAllCategoriesUseCase: injectGetAllCategoriesUseCase(),
      getAllBrandsUseCase: injectGetAllBrandsUseCase(),
    );
    _viewModel.getCategories();
    _viewModel.getBrands();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeTabViewModel, HomeTabStates>(
      bloc: _viewModel,
      listener: (context, state) {},
      builder: (context, state) {
        return state is HomeTabCategoryLoadingStates ||
            _viewModel.categoriesList == null ||
            _viewModel.brandsList == null
            ? const Center(
            child: CircularProgressIndicator(
              color: AppColors.primaryColor,
            ))
            : SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 13.w),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.list),
                        padding: const EdgeInsets.only(top: 10),
                        color: Colors.orange,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ListScreen()),
                          );
                        },
                      ),
                      // Adjust the width as needed
                      Image.asset(MyAssets.logo
                        // Adjust the height as needed
                      ),
                    ],
                  ),
                  SizedBox(height: 18.h),
                   CustomSearchWithShoppingCart(),
                  SizedBox(height: 16.h),
                  AnnouncementsSection(),
                  SizedBox(height: 16.h),
                  buildCategoriesSection(state),
                  SizedBox(height: 24.h),
                  buildBrandsSection(state),
                  SizedBox(height: 25.h),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget buildCategoriesSection(HomeTabStates state) {
    if (state is HomeTabCategoryLoadingStates) {
      return const Center(
        child: CircularProgressIndicator(
          color: AppColors.primaryColor,
        ),
      );
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RowSectionWidget(name: 'Categories'),
          SizedBox(height: 24.h),
          CategoriesOrBrandsSection(list: _viewModel.categoriesList ?? []),
          SizedBox(height: 24.h),
        ],
      );
    }
  }

  Widget buildBrandsSection(HomeTabStates state) {
    if (state is HomeTabBrandLoadingStates) {
      return const Center(
        child: CircularProgressIndicator(
          color: AppColors.primaryColor,
        ),
      );
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RowSectionWidget(name: 'Brands'),
          SizedBox(height: 13.h),
          BrandsSection(list: _viewModel.brandsList ?? []),
          SizedBox(height: 25.h),
        ],
      );
    }
  }
}

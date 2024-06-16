
import 'package:ecommerce/ui/home/home_screen/widget/custom_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cart/cubit/cart_view_model.dart';
import '../tabs/product_list_tab/cubit/product_list_tab_view_model.dart';
import 'cubit/home_screen_view_model.dart';
import 'cubit/home_states.dart';

class HomeScreenView extends StatefulWidget {
  static const String routeName = 'home';

  @override
  _HomeScreenViewState createState() => _HomeScreenViewState();
}

class _HomeScreenViewState extends State<HomeScreenView> {
  late final HomeScreenViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = HomeScreenViewModel();
    ProductListTabViewModel.get(context).getProducts();
    CartViewModel.get(context).getCart();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeScreenViewModel, HomeScreenStates>(
      bloc: _viewModel,
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          bottomNavigationBar: buildCustomBottomNavigationBar(
            context: context,
            selectedIndex: _viewModel.selectedIndex,
            onTapFunction: (index) {
              _viewModel.changeBottomNavIndex(index);
            },
          ),
          body: _viewModel.tabs[_viewModel.selectedIndex],
        );
      },
    );
  }
}

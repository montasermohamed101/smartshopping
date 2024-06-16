import 'package:ecommerce/ui/home/home_screen/widget/custom_bottom_navigation_bar.dart';
import 'package:ecommerce/ui/home/tabs/contact_us/contact_us.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../tabs/favorite_tab/favorite_tab.dart';
import '../../tabs/home_tab/home_tab.dart';
import '../../tabs/product_list_tab/product_list_tab.dart';
import '../../tabs/profile_tab/profile_tab.dart';
import 'home_states.dart';

class HomeScreenViewModel extends Cubit<HomeScreenStates>{
  HomeScreenViewModel():super(HomeInitialState());
  int selectedIndex = 0;
  List<Widget> tabs = [
    HomeTab(),
    ProductListTab(),
    FavoriteTab(),
    ProfileTab(),
    ChatScreen()

  ];
  void changeBottomNavIndex(int newSelectedIndex){
    HomeInitialState();
    selectedIndex = newSelectedIndex ;
    emit(HomeChangeBottomNavBar());
  }
}
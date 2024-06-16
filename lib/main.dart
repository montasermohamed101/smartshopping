import 'package:ecommerce/core/consts.dart';
import 'package:ecommerce/core/utils/app_theme.dart';
import 'package:ecommerce/core/utils/my_bloc_observer.dart';
import 'package:ecommerce/core/utils/shared_preference_utils.dart';
import 'package:ecommerce/domain/di.dart';
import 'package:ecommerce/ui/auth/login/login_screen.dart';
import 'package:ecommerce/ui/auth/register/register_screen.dart';
import 'package:ecommerce/ui/home/cart/cart_screen.dart';
import 'package:ecommerce/ui/home/cart/cubit/cart_view_model.dart';
import 'package:ecommerce/ui/home/home_screen/home_screen_view.dart';
import 'package:ecommerce/ui/home/product_details/product_details_view.dart';
import 'package:ecommerce/ui/home/tabs/product_list_tab/cubit/product_list_tab_view_model.dart';
import 'package:ecommerce/ui/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await SharedPreferenceUtils.init();

  runApp(const MyApp());
}



class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(430, 932),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (_) => ProductListTabViewModel(
                  getAllProductsUseCase: injectGetAllProductsUseCase(),
                  addToCartUseCase: injectAddToCartUseCase(),
                ),
              ),
              BlocProvider(
                create: (context) => CartViewModel(
                    getCartUseCase: injectGetCartUseCase(),
                    deleteItemInCartUseCase: injectDeleteItemInCartUseCase(),
                    updateCountInCartUseCase: injectUpdateCountInCartUseCase(),
                    addToCartUseCase: injectAddToCartUseCase()),
              )
            ],
            child: Builder(builder: (context) {
              ProductListTabViewModel.get(context).getProducts();
              CartViewModel.get(context).getCart();
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                initialRoute:
                    SharedPreferenceUtils.getData(key: kTokenKey) != null
                        ? HomeScreenView.routeName
                        : LoginScreen.routeName,
                routes: {
                  SplashScreen.routeName: (context) => SplashScreen(),
                  LoginScreen.routeName: (context) => const LoginScreen(),
                  RegisterScreen.routeName: (context) => RegisterScreen(),
                  HomeScreenView.routeName: (context) => HomeScreenView(),
                  ProductDetailsView.routeName: (context) =>
                      const ProductDetailsView(),
                  CartScreen.routeName: (context) => CartScreen(),

                },
                theme: AppTheme.mainTheme,
              );
            }),
          );
        });
  }
}

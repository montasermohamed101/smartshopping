import 'package:ecommerce/ui/home/cart/cart_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/utils/my_assets.dart';
import '../../../../../core/utils/my_colors.dart';
import '../../../cart/cubit/cart_states.dart';
import '../../../cart/cubit/cart_view_model.dart';
import 'custom_text_field.dart';

class CustomSearchWithShoppingCart extends StatelessWidget {
   CustomSearchWithShoppingCart({
    super.key,
  });

  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
         Expanded(
          child: CustomTextField(controller: controller,),
        ),
        SizedBox(
          width: 24.w,
        ),
        InkWell(
          onTap: () {
            Navigator.of(context).pushNamed(CartScreen.routeName);
          },
          child: Badge(
            label: BlocBuilder<CartViewModel, CartStates>(
                builder: (context, state) {
              return Text(
                  CartViewModel.get(context).cartItems.length.toString());
            }),
            child: ImageIcon(
              const AssetImage(MyAssets.shoppingCart),
              size: 28.sp,
              color: AppColors.primaryColor,
            ),
          ),
        )
      ],
    );
  }
}

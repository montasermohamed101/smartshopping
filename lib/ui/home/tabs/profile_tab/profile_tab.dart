import 'package:ecommerce/core/consts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/custome_text_field_item.dart';
import '../../../../core/utils/my_assets.dart';
import '../../../../core/utils/my_colors.dart';
import '../../../../core/utils/shared_preference_utils.dart';
import '../../../auth/login/login_screen.dart';

class ProfileTab extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var passwordController = TextEditingController();
  var addressController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  bool isObsecure = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 17.w),
            child: Form(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10.h,
                    ),
                    Row(
                      children: [
                        Image.asset(
                          MyAssets.logo,
                          alignment: Alignment.topLeft,
                        ),
                        IconButton(
                            onPressed: () {
                              SharedPreferenceUtils.removeData(kTokenKey);
                              Navigator.pushReplacementNamed(
                                  context, LoginScreen.routeName);
                            },
                            icon: const Icon(Icons.logout))
                      ],
                    ),
                    SizedBox(
                      height: 18.h,
                    ),
                    Text(
                      "WELCOME, Mohamed",
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(color: AppColors.primaryColor),
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    Text(
                      "Mohamed@gmail.com",
                      style: TextStyle(color: AppColors.blueGreyColor),
                    ),
                    SizedBox(
                      height: 40.h,
                    ),
                    CustomTextFieldItem(
                      fieldName: 'Your Full Name',
                      hintText: 'Mohamed Mostafa Ahmed',
                      controller: nameController,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'please enter full name';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.text,
                      suffixIconFunction: () {},
                    ),
                    CustomTextFieldItem(
                      fieldName: 'Your E-mail',
                      hintText: 'Mohamed@gmail.com',
                      controller: emailController,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'please enter your email address';
                        }
                        bool emailValid = RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(value);
                        if (!emailValid) {
                          return 'invalid email';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.emailAddress,
                      suffixIconFunction: () {},
                    ),
                    CustomTextFieldItem(
                      fieldName: 'Your Password',
                      hintText: '********',
                      controller: passwordController,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'please enter password';
                        }
                        if (value.trim().length < 6 ||
                            value.trim().length > 30) {
                          return 'password should be >6 & <30';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.text,
                      suffixIconFunction: () {},
                    ),
                    CustomTextFieldItem(
                      fieldName: 'Your Mobile Number',
                      hintText: '01021212121',
                      controller: phoneController,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'please enter your mobile no';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.text,
                      suffixIconFunction: () {},
                    ),
                    CustomTextFieldItem(
                      fieldName: 'Your Address',
                      hintText: 'Address',
                      controller: addressController,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'please enter address';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.text,
                      suffixIconFunction: () {},
                    ),
                  ],
                ),
              ),
            )),
      ),
    );
  }
}

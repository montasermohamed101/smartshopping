import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/use_cases/login_use_case.dart';
import 'login_states.dart';

class LoginScreenViewModel extends Cubit<LoginStates> {
  LoginScreenViewModel({required this.loginUseCase})
      : super(LoginInitialState());
  var formKey = GlobalKey<FormState>();
  var passwordController = TextEditingController();
  var emailController = TextEditingController();
  bool isObscure = true;
  LoginUseCase loginUseCase;
  // todo: hold data - handle logic

  void login() async {
    if (formKey.currentState?.validate() == true) {
      // register
      emit(LoginLoadingState(loadingMessage: 'Loading...'));
      var either = await loginUseCase.invoke(
        emailController.text,
        passwordController.text,
      );
      either.fold((l) {
        emit(LoginErrorState(errorMessage: l.errorMessage));
      }, (response) {
        emit(LoginSuccessState(response: response));
      });
    }
  }
}

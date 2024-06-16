

import '../../../../domain/entities/auth_result_entity.dart';

abstract class LoginStates {}

class LoginInitialState extends LoginStates {}

class LoginLoadingState extends LoginStates {
  String? loadingMessage;
  LoginLoadingState({this.loadingMessage});
}

class LoginErrorState extends LoginStates {
  String? errorMessage;
  LoginErrorState({this.errorMessage});
}

class LoginSuccessState extends LoginStates {
  AuthResultEntity response;
  LoginSuccessState({required this.response});
}

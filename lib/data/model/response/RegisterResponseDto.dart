import '../../../domain/entities/auth_result_entity.dart';
import 'UserDto.dart';

class RegisterResponseDto {
  RegisterResponseDto({
    this.message,
    this.user,
    this.statusMsg,
    this.error,
    this.token,
  });

  String? message;
  UserDto? user;
  String? token;
  String? statusMsg;
  Error? error;

  RegisterResponseDto.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    statusMsg = json['statusMsg'];
    user = json['user'] != null ? UserDto.fromJson(json['user']) : null;
    error = json['errors'] != null ? Error.fromJson(json['errors']) : null;
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['statusMsg'] = statusMsg;
    if (user != null) {
      data['user'] = user?.toJson();
    }
    if (error != null) {
      data['errors'] = error?.toJson();
    }
    data['token'] = token;
    return data;
  }

  AuthResultEntity toAuthResultEntity() {
    return AuthResultEntity(
      userEntity: user?.toUserEntity(),
      token: token,
    );
  }
}

class Error {
  Error({
    this.value,
    this.msg,
    this.param,
    this.location,
  });

  String? value;
  String? msg;
  String? param;
  String? location;

  Error.fromJson(Map<String, dynamic> json) {
    value = json['value'];
    msg = json['msg'];
    param = json['param'];
    location = json['location'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['value'] = value;
    data['msg'] = msg;
    data['param'] = param;
    data['location'] = location;
    return data;
  }
}

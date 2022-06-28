import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:nanoshop/src/core/utils/log/log.dart';
import 'package:nanoshop/src/domain/entities/user_login/user_login.dart';

part 'user_login_response_model.g.dart';

@JsonSerializable()
class UserLoginResponseModel {
  int? code;
  UserLogin? data;
  String? message;
  String? error;

  UserLoginResponseModel({this.code, this.data, this.message, this.error});

  factory UserLoginResponseModel.fromJson(Map<String, dynamic> json) {


    return _$UserLoginResponseModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$UserLoginResponseModelToJson(this);
}

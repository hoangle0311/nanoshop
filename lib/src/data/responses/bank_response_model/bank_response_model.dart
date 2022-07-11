import 'package:json_annotation/json_annotation.dart';
import 'package:nanoshop/src/data/models/bank/bank_model.dart';
import 'package:nanoshop/src/domain/entities/bank/bank.dart';

part 'bank_response_model.g.dart';

@JsonSerializable()
class BankResponseModel {
  int? code;
  List<BankModel>? data;
  String? message;
  String? error;

  BankResponseModel({this.code, this.data, this.message, this.error});

  factory BankResponseModel.fromJson(Map<String, dynamic> json) =>
      _$BankResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$BankResponseModelToJson(this);
}

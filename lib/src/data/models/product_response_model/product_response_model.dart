import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../core/utils/log/log.dart';
import 'group_data_response_model.dart';

part 'product_response_model.g.dart';

@JsonSerializable()
class ProductResponseModel extends Equatable {
  final int? code;
  final GroupData? data;
  final String? message;
  final String? error;

  const ProductResponseModel({this.code, this.data, this.message, this.error});

  factory ProductResponseModel.fromJson(Map<String, dynamic> json) {
    try {
      return _$ProductResponseModelFromJson(json);
    } catch (e) {
      return ProductResponseModel.empty.copyWith(
        code: json['code'],
        message: json['message'],
        error: json['error'],
      );
    }
  }

  static const empty = ProductResponseModel(
    code: 0,
    message: "Lỗi dữ liệu",
  );

  ProductResponseModel copyWith({
    int? code,
    String? message,
    String? error,
  }) {
    return ProductResponseModel(
      code: code ?? this.code,
      message: message ?? this.message,
      error: error ?? this.error,
    );
  }

  Map<String, dynamic> toJson() => _$ProductResponseModelToJson(this);

  @override
  List<Object?> get props => [
        code,
        data,
        error,
        message,
      ];
}

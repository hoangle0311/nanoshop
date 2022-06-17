import 'package:json_annotation/json_annotation.dart';
import 'package:nanoshop/src/domain/entities/product/product.dart';

part 'detail_product_response_model.g.dart';

@JsonSerializable()
class DetailProductResponseModel {
  final int? code;
 final Product? data;
 final String? message;
 final String? error;

 const DetailProductResponseModel({this.code, this.data, this.message, this.error});

  DetailProductResponseModel copyWith({
    int? code,
    String? message,
    String? error,
  }) {
    return DetailProductResponseModel(
      code: code ?? this.code,
      message: message ?? this.message,
      error: error ?? this.error,
    );
  }

  factory DetailProductResponseModel.fromJson(Map<String, dynamic> json) {
    try {
      return _$DetailProductResponseModelFromJson(json);
    } catch (e) {
      return DetailProductResponseModel.empty.copyWith(
        code: json['code'],
        message: json['message'],
        error: json['error'],
      );
    }
  }

  static const empty = DetailProductResponseModel(
    code: 0,
    message: "Lỗi dữ liệu",
  );

  Map<String, dynamic> toJson() => _$DetailProductResponseModelToJson(this);
}
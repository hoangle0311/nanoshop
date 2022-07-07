import 'package:json_annotation/json_annotation.dart';
import 'package:nanoshop/src/domain/entities/page_content/page_content_model.dart';

part 'page_content_response.g.dart';

@JsonSerializable()
class PageContentResponse {
  final int? code;
  final PageContentModel? data;
  final String? message;
  final String? error;

  const PageContentResponse({this.code, this.data, this.message, this.error});

  PageContentResponse copyWith({
    int? code,
    String? message,
    String? error,
  }) {
    return PageContentResponse(
      code: code ?? this.code,
      message: message ?? this.message,
      error: error ?? this.error,
    );
  }

  factory PageContentResponse.fromJson(Map<String, dynamic> json) {
    try {
      return _$PageContentResponseFromJson(json);
    } catch (e) {
      return PageContentResponse.empty.copyWith(
        code: json['code'],
        message: json['message'],
        error: json['error'],
      );
    }
  }

  static const empty = PageContentResponse(
    code: 0,
    message: "Lỗi dữ liệu",
  );

  Map<String, dynamic> toJson() => _$PageContentResponseToJson(this);
}
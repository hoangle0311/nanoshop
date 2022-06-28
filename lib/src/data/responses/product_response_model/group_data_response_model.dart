import 'package:json_annotation/json_annotation.dart';

import '../../../domain/entities/product/product.dart';

part 'group_data_response_model.g.dart';

@JsonSerializable()
class GroupData {
  List<Product>? data;

  GroupData({this.data});
  factory GroupData.fromJson(Map<String, dynamic> json) =>
      _$GroupDataFromJson(json);

  Map<String, dynamic> toJson() => _$GroupDataToJson(this);
}

import 'package:json_annotation/json_annotation.dart';

import '../../../domain/entities/transport/transport.dart';

part 'transport_response_model.g.dart';

@JsonSerializable()
class TransportResponseModel {
  int? code;
  List<Transport>? data;
  String? message;
  String? error;

  TransportResponseModel({this.code, this.data, this.message, this.error});

  factory TransportResponseModel.fromJson(Map<String, dynamic> json) =>
      _$TransportResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$TransportResponseModelToJson(this);
}

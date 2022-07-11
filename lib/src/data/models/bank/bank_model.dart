import 'package:json_annotation/json_annotation.dart';
import 'package:nanoshop/src/domain/entities/bank/bank.dart';

part 'bank_model.g.dart';

@JsonSerializable()
class BankModel extends Bank {
  const BankModel({
    String? id,
    String? bankName,
    String? number,
    String? name,
  }) : super(
          id: id,
          bankName: bankName,
          number: number,
          name: name,
        );

  factory BankModel.fromJson(Map<String, dynamic> json) =>
      _$BankModelFromJson(json);

  Map<String, dynamic> toJson() => _$BankModelToJson(this);
}

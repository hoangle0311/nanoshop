import 'package:json_annotation/json_annotation.dart';
import 'package:nanoshop/src/data/models/bank/bank_model.dart';
import 'package:nanoshop/src/domain/entities/payment/payment.dart';

part 'payment_model.g.dart';

@JsonSerializable()
class PaymentModel extends Payment {
  @JsonKey(name: "listBank")
  final List<BankModel> banks;

  const PaymentModel({
    int? id,
    String? name,
    this.banks = const [],
  }) : super(
          id: id,
          name: name,
          listBank: banks,
        );

  factory PaymentModel.fromJson(Map<String, dynamic> json) {
    return _$PaymentModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$PaymentModelToJson(this);
}

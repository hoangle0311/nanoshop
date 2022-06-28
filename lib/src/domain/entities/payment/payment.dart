import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../bank/bank.dart';

part 'payment.g.dart';

@JsonSerializable()
class Payment extends Equatable {
  final int? id;
  final String? name;
  final List<Bank> listBank;

  const Payment({
    this.id,
    this.name,
    this.listBank = const [],
  });

  Payment copyWith({
    List<Bank>? listBank,
  }) {
    return Payment(
      id: id,
      name: name,
      listBank: listBank ?? this.listBank,
    );
  }

  factory Payment.fromJson(Map<String, dynamic> json) {
    return _$PaymentFromJson(json);
  }

  static const empty = Payment(
    id: -1,
    name: '-',
  );

  Map<String, dynamic> toJson() => _$PaymentToJson(this);

  @override
  List<Object?> get props => [
        id,
        name,
        listBank,
      ];
}

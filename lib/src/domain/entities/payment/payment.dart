import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'payment.g.dart';

@JsonSerializable()
class Payment extends Equatable{
  final int? id;
  final String? name;

  const Payment({
    this.id,
    this.name,
  });

  factory Payment.fromJson(Map<String, dynamic> json) {
    return _$PaymentFromJson(json);
  }

  static const empty = Payment(
    id: -1,
    name: '-',
  );

  Map<String, dynamic> toJson() => _$PaymentToJson(this);

  @override
  // TODO: implement props
  List<Object?> get props => [
    id,
    name,
  ];
}

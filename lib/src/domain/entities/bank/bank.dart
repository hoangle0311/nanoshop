import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'bank.g.dart';

@JsonSerializable()
class Bank extends Equatable {
  final String? id;
  final String? name;
  @JsonKey(name: "bank_name")
  final String? bankName;
  final String? number;
  final String? createdTime;
  final String? updatedTime;
  final String? status;
  final String? siteId;

  const Bank({
    this.id,
    this.name,
    this.bankName,
    this.number,
    this.createdTime,
    this.updatedTime,
    this.status,
    this.siteId,
  });

  static const empty = Bank(
    id: '-',
    name: '-',
  );

  factory Bank.fromJson(Map<String, dynamic> json) => _$BankFromJson(json);

  Map<String, dynamic> toJson() => _$BankToJson(this);

  @override
  List<Object?> get props => [
        id,
        name,
      ];
}

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

class Bank extends Equatable {
  final String? id;
  final String? name;
  @JsonKey(name: "bank_name")
  final String? bankName;
  final String? number;

  const Bank({
    this.id,
    this.name,
    this.bankName,
    this.number,
  });

  static const empty = Bank(
    id: '-',
    name: '-',
  );

  @override
  List<Object?> get props => [
        id,
        name,
      ];
}

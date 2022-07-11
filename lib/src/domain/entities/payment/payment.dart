import 'package:equatable/equatable.dart';

import '../bank/bank.dart';


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

  static const empty = Payment(
    id: -1,
    name: '-',
  );


  @override
  List<Object?> get props => [
        id,
        name,
        listBank,
      ];
}

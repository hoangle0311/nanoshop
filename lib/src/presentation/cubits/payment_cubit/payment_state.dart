part of 'payment_cubit.dart';

enum PaymentStatus {
  initial,
  loading,
  success,
  failure,
}

class PaymentState extends Equatable {
  final Payment payment;
  final List<Payment> listPayment;
  final List<Bank> listBank;
  final PaymentStatus status;
  final Bank bank;

  const PaymentState({
    this.payment = Payment.empty,
    this.bank = Bank.empty,
    this.listPayment = const [],
    this.listBank = const [],
    this.status = PaymentStatus.initial,
  });

  PaymentState copyWith({
    Payment? payment,
    List<Payment>? listPayment,
    List<Bank>? listBank,
    PaymentStatus? status,
    Bank? bank,
  }) {
    return PaymentState(
      payment: payment ?? this.payment,
      bank: bank ?? this.bank,
      listBank: listBank ?? this.listBank,
      listPayment: listPayment ?? this.listPayment,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [
    payment,
    listPayment,
    status,
    bank,
  ];
}

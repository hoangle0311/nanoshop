part of 'checkout_cubit.dart';

enum CheckoutStatus {
  initial,
  loading,
  success,
  failure,
}

class CheckoutState extends Equatable {
  final String? message;
  final CheckoutStatus status;

  const CheckoutState({
    this.message,
    this.status = CheckoutStatus.initial,
  });

  CheckoutState copyWith({
    String? message,
    CheckoutStatus? status,
  }) {
    return CheckoutState(
      message: message ?? this.message,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [
        message,
        status,
      ];
}

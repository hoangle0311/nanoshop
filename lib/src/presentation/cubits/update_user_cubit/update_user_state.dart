part of 'update_user_cubit.dart';

enum UpdateUserStatus {
  initial,
  loading,
  success,
  fail,
}

class UpdateUserState extends Equatable {
  final UpdateUserStatus status;
  final String message;
  final String? userName;
  final String? email;
  final String? address;

  const UpdateUserState({
    this.status = UpdateUserStatus.initial,
    this.message = 'Lỗi',
    this.userName,
    this.email,
    this.address,
  });

  UpdateUserState copyWith({
    UpdateUserStatus? status,
    String? userName,
    String? email,
    String? address,
    String? message,
  }) {
    return UpdateUserState(
      status: status ?? this.status,
      email: email ?? this.email,
      userName: userName ?? this.userName,
      message: message ?? this.message,
      address: address ?? this.address,
    );
  }

  @override
  List<Object?> get props => [
        message,
        email,
        userName,
        status,
        address,
      ];
}

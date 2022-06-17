class ChangePasswordParam {
  final String token;
  final String userId;
  final String oldPassword;
  final String password;
  final String passwordConfirm;

  ChangePasswordParam({
    required this.token,
    required this.userId,
    required this.oldPassword,
    required this.password,
    required this.passwordConfirm,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};

    data['user_id'] = userId;
    data['oldPassword'] = oldPassword;
    data['password'] = password;
    data['passwordConfirm'] = passwordConfirm;

    return data;
  }
}

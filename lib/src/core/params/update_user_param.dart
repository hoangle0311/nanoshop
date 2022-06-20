import 'dart:io';

class UpdateUserParam {
  final String token;
  final File? file;
  final String userId;
  final String? userName;
  final String? email;
  final String? address;

  UpdateUserParam({
    required this.token,
    required this.userId,
    this.file,
    this.userName,
    this.email,
    this.address,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    data['user_id'] = userId;

    return data;
  }
}

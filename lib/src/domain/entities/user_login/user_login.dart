import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_login.g.dart';

@JsonSerializable()
class UserLogin extends Equatable {
  @JsonKey(name: "user_id")
  final String? userId;
  final String? siteId;
  final String? name;
  final String? email;
  final String? password;
  final String? sex;
  final String? birthday;
  final String? address;
  final String? status;
  final String? phone;
  final String? provinceId;
  final String? districtId;
  final String? wardId;
  final String? active;
  final String? createdTime;
  final String? modifiedTime;
  final String? identityCard;
  final String? createdIdentityCard;
  final String? addressIdentityCard;
  final String? frontIdentityCard;
  final String? backIdentityCard;
  final String? bankId;
  final String? bankName;
  final String? bankBranch;
  final String? userIntroduceId;
  final String? phoneIntroduce;
  final String? type;
  final String? verifiedEmail;
  final String? verifiedCode;
  final String? fbid;
  final String? googleId;
  @JsonKey(name: "avatar_path")
  final String? avatarPath;
  @JsonKey(name: "avatar_name")
  final String? avatarName;
  final String? bonusPoint;
  final String? donate;
  final String? country;
  final String? companyName;
  final String? zipcode;
  final String? state;
  final String? city;
  final String? facebookUrl;
  final String? firstName;
  final String? typeUser;
  final String? saleUserId;
  final String? tokenApp;

  const UserLogin(
      {this.userId,
      this.siteId,
      this.name,
      this.email,
      this.password,
      this.sex,
      this.birthday,
      this.address,
      this.status,
      this.phone,
      this.provinceId,
      this.districtId,
      this.wardId,
      this.active,
      this.createdTime,
      this.modifiedTime,
      this.identityCard,
      this.createdIdentityCard,
      this.addressIdentityCard,
      this.frontIdentityCard,
      this.backIdentityCard,
      this.bankId,
      this.bankName,
      this.bankBranch,
      this.userIntroduceId,
      this.phoneIntroduce,
      this.type,
      this.verifiedEmail,
      this.verifiedCode,
      this.fbid,
      this.googleId,
      this.avatarPath,
      this.avatarName,
      this.bonusPoint,
      this.donate,
      this.country,
      this.companyName,
      this.zipcode,
      this.state,
      this.city,
      this.facebookUrl,
      this.firstName,
      this.typeUser,
      this.saleUserId,
      this.tokenApp});

  factory UserLogin.fromJson(Map<String, dynamic> json) =>
      _$UserLoginFromJson(json);

  Map<String, dynamic> toJson() => _$UserLoginToJson(this);

  static const empty = UserLogin(
    userId: '-',
    avatarName: '-',
    avatarPath: '-',
    name: '-',
  );

  @override
  List<Object?> get props => [
        userId,
        name,
        email,
        phone,
      ];
}

import 'package:equatable/equatable.dart';

class GetListShopParam extends Equatable{
  final String token;
  final String? provinceId;

  GetListShopParam({
    required this.token,
    this.provinceId,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};

    if(provinceId != null){
      data['province_id'] = provinceId;
    }

    return data;
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
    token,
    provinceId,
  ];
}

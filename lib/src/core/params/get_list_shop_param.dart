import 'package:equatable/equatable.dart';

class GetListShopParam extends Equatable{
  final String? provinceId;

  GetListShopParam({
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
  List<Object?> get props => [
    provinceId,
  ];
}

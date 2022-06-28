import 'package:nanoshop/src/core/params/banner_param.dart';
import 'package:nanoshop/src/core/resource/data_state.dart';

import '../../../data/responses/banner_response_model.dart/banner_response_model.dart';

abstract class BannerRepository {
  Future<DataState<BannerResponseModel>> getListBanner(
    BannerParam param,
  );
}

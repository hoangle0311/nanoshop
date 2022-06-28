import 'package:nanoshop/src/core/params/banner_param.dart';
import 'package:nanoshop/src/core/resource/data_state.dart';
import 'package:nanoshop/src/core/usecases/usecase_with_future.dart';

import '../../../data/responses/banner_response_model.dart/banner_response_model.dart';
import '../../repositories/banner_repository/banner_repository.dart';

class GetBannerUsecase
    extends UseCaseWithFuture<DataState<BannerResponseModel>, BannerParam> {
  final BannerRepository _categoryRepository;
  GetBannerUsecase(
    this._categoryRepository,
  );

  // Truyen groupId vao de lay banner
  @override
  Future<DataState<BannerResponseModel>> call(BannerParam params) {
    return _categoryRepository.getListBanner(params);
  }
}

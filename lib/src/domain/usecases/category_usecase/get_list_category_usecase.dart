import 'package:nanoshop/src/core/params/category_param.dart';
import 'package:nanoshop/src/core/resource/data_state.dart';
import 'package:nanoshop/src/core/usecases/usecase_with_future.dart';
import 'package:nanoshop/src/domain/entities/category/category.dart';

import '../../../data/responses/category_response_model/category_response_model.dart';
import '../../repositories/category_repository/category_repository.dart';

class GetListCategoryUsecase
    extends UseCaseWithFuture<DataState<List<Category>>, CategoryParam> {
  final CategoryRepository _categoryRepository;
  GetListCategoryUsecase(
    this._categoryRepository,
  );

  @override
  Future<DataState<List<Category>>> call(CategoryParam params) {
    return _categoryRepository.getListCategory(params);
  }
}

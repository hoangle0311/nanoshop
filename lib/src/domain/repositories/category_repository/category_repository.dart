import 'package:nanoshop/src/core/params/category_param.dart';
import 'package:nanoshop/src/core/resource/data_state.dart';

import '../../../data/models/category_response_model/category_response_model.dart';

abstract class CategoryRepository {
  Future<DataState<CategoryResponseModel>> getListCategory(
    CategoryParam params,
  );
}

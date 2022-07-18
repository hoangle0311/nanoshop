import 'package:nanoshop/src/core/params/category_param.dart';
import 'package:nanoshop/src/core/resource/data_state.dart';
import 'package:nanoshop/src/domain/entities/category/category.dart';

import '../../../data/responses/category_response_model/category_response_model.dart';

abstract class CategoryRepository {
  Future<DataState<List<Category>>> getListCategory(
    CategoryParam params,
  );
}

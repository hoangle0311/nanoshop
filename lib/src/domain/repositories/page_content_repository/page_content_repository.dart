import 'package:nanoshop/src/core/params/page_content_param.dart';
import 'package:nanoshop/src/core/resource/data_state.dart';
import 'package:nanoshop/src/domain/entities/page_content/page_content_model.dart';

abstract class PageContentRepository {
  Future<DataState<PageContentModel>> getPageContent(PageContentParam param);
}

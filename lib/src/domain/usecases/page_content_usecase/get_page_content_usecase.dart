import 'package:nanoshop/src/core/params/page_content_param.dart';
import 'package:nanoshop/src/core/resource/data_state.dart';
import 'package:nanoshop/src/core/usecases/usecase_with_future.dart';
import 'package:nanoshop/src/domain/entities/page_content/page_content_model.dart';
import '../../repositories/page_content_repository/page_content_repository.dart';

class GetPageContentUsecase
    extends UseCaseWithFuture<DataState<PageContentModel>, PageContentParam> {
  final PageContentRepository _pageContentRepository;

  GetPageContentUsecase(
    this._pageContentRepository,
  );

  @override
  Future<DataState<PageContentModel>> call(PageContentParam params) {
    return _pageContentRepository.getPageContent(params);
  }
}

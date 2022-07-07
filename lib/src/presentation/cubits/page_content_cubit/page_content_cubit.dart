import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nanoshop/src/core/params/page_content_param.dart';
import 'package:nanoshop/src/core/params/token_param.dart';
import 'package:nanoshop/src/core/resource/data_state.dart';
import 'package:nanoshop/src/domain/entities/page_content/page_content_model.dart';
import 'package:nanoshop/src/domain/usecases/page_content_usecase/get_page_content_usecase.dart';

part 'page_content_state.dart';

class PageContentCubit extends Cubit<PageContentState> {
  final GetPageContentUsecase _getPageContentUsecase;

  PageContentCubit(
    this._getPageContentUsecase,
  ) : super(const PageContentState());

  onGetPageContent(
    TokenParam tokenParam,
    String id,
    String type,
  ) async {
    emit(
      state.copyWith(
        status: PageContentStatus.loading,
      ),
    );

    try {
      DataState<PageContentModel> dataState = await _getPageContentUsecase.call(
        PageContentParam(token: tokenParam.token, id: id, type: type),
      );

      if (dataState is DataSuccess) {
        emit(
          state.copyWith(
            status: PageContentStatus.success,
            pageContentModel: dataState.data,
          ),
        );
      } else {
        emit(
          state.copyWith(status: PageContentStatus.failure),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(status: PageContentStatus.failure),
      );
    }
  }
}

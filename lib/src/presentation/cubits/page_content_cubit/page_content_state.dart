part of 'page_content_cubit.dart';

enum PageContentStatus {
  initial,
  loading,
  success,
  failure,
}

class PageContentState extends Equatable {
  final PageContentStatus status;
  final PageContentModel? pageContentModel;

  const PageContentState({
    this.status = PageContentStatus.initial,
    this.pageContentModel,
  });

  PageContentState copyWith({
    PageContentStatus? status,
    PageContentModel? pageContentModel,
  }) {
    return PageContentState(
      status: status ?? this.status,
      pageContentModel: pageContentModel ?? this.pageContentModel,
    );
  }

  @override
  List<Object?> get props => [
        status,
        pageContentModel,
      ];
}

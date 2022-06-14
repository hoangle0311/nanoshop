part of 'get_category_bloc.dart';

abstract class GetCategoryState extends Equatable {
  const GetCategoryState();

  @override
  List<Object> get props => [];
}

class GetCategoryLoading extends GetCategoryState {}

class GetCategoryDone extends GetCategoryState {
  final List<Category> categories;
  const GetCategoryDone({
    required this.categories,
  });
}

class GetCategoryFailed extends GetCategoryState {
  final DioError? error;

  const GetCategoryFailed({
    this.error,
  });
}

// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'get_category_bloc.dart';

abstract class GetCategoryEvent extends Equatable {
  const GetCategoryEvent();

  @override
  List<Object> get props => [];
}

class GetListCategoryEvent extends GetCategoryEvent {
  GetListCategoryEvent();
}

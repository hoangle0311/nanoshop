part of 'post_bloc.dart';

abstract class PostEvent extends Equatable {
  const PostEvent();

  @override
  List<Object> get props => [];
}

class GetListPost extends PostEvent {

  const GetListPost();
}

class LoadMorePost extends PostEvent {

  const LoadMorePost();
}

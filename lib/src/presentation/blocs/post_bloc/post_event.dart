part of 'post_bloc.dart';

abstract class PostEvent extends Equatable {
  const PostEvent();

  @override
  List<Object> get props => [];
}

class GetListPost extends PostEvent {
  final TokenParam tokenParam;

  const GetListPost({
    required this.tokenParam,
  });
}

class LoadMorePost extends PostEvent {
  final TokenParam tokenParam;

  const LoadMorePost({
    required this.tokenParam,
  });
}

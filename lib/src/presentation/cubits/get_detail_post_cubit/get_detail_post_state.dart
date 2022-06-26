part of 'get_detail_post_cubit.dart';

enum GetDetailPostStatus {
  initial,
  loading,
  success,
  fail,
}

class GetDetailPostState extends Equatable {
  final GetDetailPostStatus status;
  final Post post;

  const GetDetailPostState({
    this.status = GetDetailPostStatus.initial,
    this.post = Post.empty,
  });

  GetDetailPostState copyWith({
    Post? post,
    GetDetailPostStatus? status,
  }) {
    return GetDetailPostState(
      post: post ?? this.post,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [
        post,
        status,
      ];
}

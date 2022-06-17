part of 'get_list_comment_cubit.dart';

enum GetListCommentStatus {
  initial,
  loading,
  success,
  failure,
}

class GetListCommentState extends Equatable {
  final int page;
  final int limit;
  final List<Comment> comments;
  final GetListCommentStatus status;
  final bool hasMore;
  final GetListCommentParam? param;

  const GetListCommentState({
    required this.page,
    this.limit = 5,
    this.comments = const [],
    this.hasMore = true,
    this.status = GetListCommentStatus.initial,
    this.param,
  });

  GetListCommentState copyWith({
    int? page,
    int? limit,
    List<Comment>? comments,
    GetListCommentStatus? status,
    GetListCommentParam? param,
    bool? hasMore,
  }) {
    return GetListCommentState(
      page: page ?? this.page,
      hasMore: hasMore ?? this.hasMore,
      limit: limit ?? this.limit,
      comments: comments ?? this.comments,
      status: status ?? this.status,
      param: param ?? this.param,
    );
  }

  @override
  List<Object?> get props => [
        page,
        limit,
        comments,
        status,
        hasMore,
      ];
}

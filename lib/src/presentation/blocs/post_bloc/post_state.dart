part of 'post_bloc.dart';

// abstract class PostState extends Equatable {
//   final List<Post> posts;
//
//   final bool hasMore;
//
//   PostState({
//     this.hasMore = false,
//     required this.posts,
//   });
// }
//
// class PostLoading extends PostState {
//   PostLoading() : super(posts: []);
//
//   @override
//   List<Object?> get props => throw UnimplementedError();
// }
//
// class PostDone extends PostState {
//   PostDone({
//     required List<Post> posts,
//     required bool hasMore,
//   }) : super(
//           posts: posts,
//           hasMore: hasMore,
//         );
//
//   PostDone copyWith({
//     required List<Post> posts,
//     required bool hasMore,
//   }) {
//     return PostDone(posts: posts, hasMore: hasMore);
//   }
//
//   @override
//   List<Object> get props => [
//         posts,
//       ];
// }
//
// class PostFailed extends PostState {
//   final DioError? dioError;
//
//   PostFailed({
//     this.dioError,
//   }) : super(
//           posts: [],
//         );
//
//   @override
//   // TODO: implement props
//   List<Object?> get props => throw UnimplementedError();
// }

enum PostStatus { initial, loading, success, failure }

class PostState extends Equatable {
  final List<Post> posts;
  final PostStatus status;
  final bool hasMore;

  const PostState({
    this.posts = const [],
    this.hasMore = false,
    this.status = PostStatus.initial,
  });

  PostState copyWith({
    PostStatus? status,
    List<Post>? posts,
    bool? hasMore,
  }) {
    return PostState(
      status: status ?? this.status,
      posts: posts ?? this.posts,
      hasMore: hasMore ?? this.hasMore,
    );
  }

  @override
  List<Object?> get props => [
    posts,
    status,
    hasMore,
  ];
}

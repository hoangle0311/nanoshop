part of 'add_comment_bloc.dart';

abstract class AddCommentEvent extends Equatable {
  const AddCommentEvent();

  @override
  List<Object> get props => [];
}

class RatingChanged extends AddCommentEvent {
  final double rating;

  const RatingChanged(this.rating);

  @override
  List<Object> get props => [rating];
}

class UsernameChanged extends AddCommentEvent {
  final String name;

  const UsernameChanged(this.name);

  @override
  List<Object> get props => [name];
}

class PhoneChanged extends AddCommentEvent {
  final String phone;

  const PhoneChanged(this.phone);

  @override
  List<Object> get props => [phone];
}

class ContentChanged extends AddCommentEvent {
  final String content;

  const ContentChanged(this.content);

  @override
  List<Object> get props => [content];
}

class CommentSubmitted extends AddCommentEvent {
  final TokenParam tokenParam;
  final String userId;
  final String productId;

  const CommentSubmitted({
    required this.tokenParam,
    required this.userId,
    required this.productId,
  });
}

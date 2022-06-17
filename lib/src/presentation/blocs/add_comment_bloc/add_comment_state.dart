part of 'add_comment_bloc.dart';

class AddCommentState extends Equatable {
  const AddCommentState({
    this.status = FormzStatus.pure,
    // this.phone = const UsernameInput.pure(),
    // this.name = const FullNameInput.pure(),
    this.content = const ContentInput.pure(),
    this.rating = 3,
    this.message = '',
  });

  final FormzStatus status;
  // final UsernameInput phone;
  // final FullNameInput name;
  final ContentInput content;
  final double rating;
  final String message;

  AddCommentState copyWith({
    FormzStatus? status,
    // UsernameInput? phone,
    // FullNameInput? name,
    ContentInput? content,
    double? rating,
    String? message,
  }) {
    return AddCommentState(
      status: status ?? this.status,
      // phone: phone ?? this.phone,
      // name: name ?? this.name,
      content: content ?? this.content,
      rating: rating ?? this.rating,
      message: message ?? this.message,
    );
  }

  @override
  List<Object> get props => [
        status,
        // phone,
        // name,
        content,
        rating,
      ];
}

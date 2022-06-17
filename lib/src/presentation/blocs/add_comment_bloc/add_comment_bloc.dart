import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:meta/meta.dart';
import 'package:nanoshop/src/core/form_model/add_comment/content_input.dart';
import 'package:nanoshop/src/core/form_model/sign_up/fullname_input.dart';
import 'package:nanoshop/src/core/params/add_comment_param.dart';
import 'package:nanoshop/src/data/models/add_comment_response/add_comment_response_model.dart';
import 'package:nanoshop/src/domain/usecases/product_usecase/add_comment_usecase.dart';

import '../../../core/form_model/login/username_input.dart';
import '../../../core/params/token_param.dart';
import '../../../core/resource/data_state.dart';

part 'add_comment_event.dart';

part 'add_comment_state.dart';

class AddCommentBloc extends Bloc<AddCommentEvent, AddCommentState> {
  final AddCommentUsecase _addCommentUsecase;

  AddCommentBloc(
    this._addCommentUsecase,
  ) : super(const AddCommentState()) {
    on<RatingChanged>(_onRatingChanged);
    // on<UsernameChanged>(_onUsernameChanged);
    // on<PhoneChanged>(_onPhoneChanged);
    on<ContentChanged>(_onContentChanged);
    on<CommentSubmitted>(_onCommentSubmitted);
  }

  _onRatingChanged(
    RatingChanged event,
    emit,
  ) {
    emit(
      state.copyWith(
        rating: event.rating,
      ),
    );
  }

  // _onUsernameChanged(
  //   UsernameChanged event,
  //   emit,
  // ) {
  //   final username = FullNameInput.dirty(
  //     event.name,
  //   );
  //
  //   emit(
  //     state.copyWith(
  //       name: username,
  //       status: Formz.validate(
  //         [
  //           state.content,
  //           state.phone,
  //           username,
  //         ],
  //       ),
  //     ),
  //   );
  // }
  //
  // _onPhoneChanged(
  //   PhoneChanged event,
  //   emit,
  // ) {
  //   final phone = UsernameInput.dirty(
  //     event.phone,
  //   );
  //
  //   emit(
  //     state.copyWith(
  //       phone: phone,
  //       status: Formz.validate(
  //         [
  //           state.content,
  //           state.name,
  //           phone,
  //         ],
  //       ),
  //     ),
  //   );
  // }

  _onContentChanged(
    ContentChanged event,
    emit,
  ) {
    final content = ContentInput.dirty(
      event.content,
    );

    emit(
      state.copyWith(
        content: content,
        status: Formz.validate(
          [
            // state.phone,
            // state.name,
            content,
          ],
        ),
      ),
    );
  }

  _onCommentSubmitted(
    CommentSubmitted event,
    emit,
  ) async {
    if (state.status.isValidated) {
      emit(
        state.copyWith(
          status: FormzStatus.submissionInProgress,
        ),
      );

      DataState<AddCommentResponseModel> dataState =
          await _addCommentUsecase.call(
        AddCommentParam(
          token: event.tokenParam.token,
          type: '1',
          // phone: state.phone.value,
          content: state.content.value,
          // name: state.name.value,
          countRate: state.rating,
          userId: event.userId,
          productId: event.productId,
        ),
      );

      if (dataState is DataSuccess) {
        emit(
          state.copyWith(
            status: FormzStatus.submissionSuccess,
            message: dataState.data!.message,
          ),
        );
      }

      if (dataState is DataFailed) {
        emit(
          state.copyWith(
            status: FormzStatus.submissionFailure,
            message: "Gửi bình luận thất bại",
          ),
        );
      }
    }
  }
}

import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:nanoshop/src/core/params/token_param.dart';
import 'package:nanoshop/src/core/params/update_user_param.dart';
import 'package:nanoshop/src/core/resource/data_state.dart';
import 'package:nanoshop/src/data/models/default_response_model/default_response_model.dart';
import 'package:nanoshop/src/domain/usecases/auth_usecase/update_user_remote_usecase.dart';

part 'update_user_state.dart';

class UpdateUserCubit extends Cubit<UpdateUserState> {
  final UpdateUserRemoteUsecase _updateUserRemoteUsecase;

  UpdateUserCubit(
    this._updateUserRemoteUsecase,
  ) : super(
          const UpdateUserState(),
        );

  void onChangeUserName(String? userName) {
    emit(
      state.copyWith(
        userName: userName,
      ),
    );
  }

  void onChangeEmail(String? email) {
    emit(
      state.copyWith(
        email: email,
      ),
    );
  }

  void onChangeAddress(String? address) {
    emit(
      state.copyWith(
        address: address,
      ),
    );
  }

  void updateUser({
    required TokenParam tokenParam,
    required String userId,
    File? avatar,
    String? name,
    String? email,
    String? address,
  }) async {
    emit(
      state.copyWith(status: UpdateUserStatus.loading),
    );

    try {
      DataState<DefaultResponseModel> dataState =
          await _updateUserRemoteUsecase.call(
        UpdateUserParam(
          token: tokenParam.token,
          file: avatar,
          userId: userId,
          userName: name,
          email: email,
          address: address,
        ),
      );

      if (dataState is DataSuccess) {
        if (dataState.data!.code! == 1) {
          emit(
            state.copyWith(
              status: UpdateUserStatus.success,
              message: dataState.data!.message,
            ),
          );
        } else {
          emit(
            state.copyWith(
              status: UpdateUserStatus.fail,
              message: dataState.data!.message,
            ),
          );
        }
      } else {
        emit(
          state.copyWith(
            status: UpdateUserStatus.fail,
            message: dataState.data!.message,
          ),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(
          status: UpdateUserStatus.fail,
        ),
      );
    }
  }
}

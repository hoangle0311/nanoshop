import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';
import 'package:nanoshop/src/core/params/token_param.dart';
import 'package:nanoshop/src/domain/entities/token/token.dart';
import 'package:nanoshop/src/domain/usecases/token_usecase/get_token_usecase.dart';

import '../../../core/resource/data_state.dart';
import '../../../data/responses/token_response_model/token_response_model.dart';

part 'get_token_event.dart';

part 'get_token_state.dart';

class GetTokenBloc extends Bloc<GetTokenEvent, GetTokenState> {
  final GetTokenUsecase _getTokenUsecase;

  GetTokenBloc(
    this._getTokenUsecase,
  ) : super(GetTokenLoading()) {
    on<GetToken>(_onGetToken);
  }

  FutureOr<void> _onGetToken(
    GetToken event,
    Emitter<GetTokenState> emit,
  ) async {
    DataState<TokenResponseModel> dataState = await _getTokenUsecase.call(
      TokenParam(
        string: event.string,
        token: event.token,
      ),
    );

    if (dataState is DataSuccess) {
      emit(
        GetTokenDone(token: dataState.data!.data!),
      );
    }

    if (dataState is DataFailed) {
      emit(
        GetTokenFailed(dataState.error),
      );
    }
  }
}

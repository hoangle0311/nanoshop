import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:nanoshop/src/core/params/banner_param.dart';
import 'package:nanoshop/src/core/params/token_param.dart';

import 'package:nanoshop/src/core/resource/data_state.dart';
import 'package:nanoshop/src/core/utils/log/log.dart';

import '../../../data/responses/banner_response_model.dart/banner_response_model.dart';
import '../../../domain/entities/banner/banner.dart';
import '../../../domain/usecases/banner_usecase/get_banner_usecase.dart';

part 'get_banner_event.dart';

part 'get_banner_state.dart';

class GetBannerBloc extends Bloc<GetBannerEvent, GetBannerState> {
  final GetBannerUsecase _getBannerUsecase;

  GetBannerBloc(
    this._getBannerUsecase,
  ) : super(GetBannerLoading()) {
    on<GetBannerByGroupId>(_getBannerByGroupId);
  }

  _getBannerByGroupId(
    GetBannerByGroupId event,
    Emitter emit,
  ) async {
    try {
      DataState<List<Banner>> dataState = await _getBannerUsecase.call(
        BannerParam(
          groupId: event.groupId,
          limit: "10",
        ),
      );

      if (kDebugMode) {
        await Future.delayed(
          const Duration(seconds: 3),
        );
      }

      if (dataState is DataSuccess) {
        emit(
          GetBannerDone(
            banners: dataState.data!,
          ),
        );
      }

      if (dataState is DataFailed) {
        emit(
          GetBannerFailed(
            error: dataState.error,
          ),
        );
      }
    } catch (e) {
      Log.i(e.toString());
      emit(
        GetBannerFailed(),
      );
    }
  }
}

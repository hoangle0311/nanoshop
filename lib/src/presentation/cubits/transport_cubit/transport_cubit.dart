import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:nanoshop/src/core/resource/data_state.dart';
import 'package:nanoshop/src/domain/entities/transport/transport.dart';

import '../../../data/responses/transport_response_model/transport_response_model.dart';
import '../../../domain/usecases/payment_usecase/get_transport_usecase.dart';

part 'transport_state.dart';

class TransportCubit extends Cubit<TransportState> {
  final GetTransportUsecase _getTransportUsecase;

  TransportCubit(
    this._getTransportUsecase,
  ) : super(const TransportState());

  void onChooseTransport(Transport transport) {
    emit(
      state.copyWith(
        transport: transport,
      ),
    );
  }

  void onGetListTransPort() async {
    emit(
      state.copyWith(
        status: TransportStatus.loading,
      ),
    );

    DataState<TransportResponseModel> dataState =
        await _getTransportUsecase.call(null);

    if (dataState is DataSuccess) {
      emit(
        state.copyWith(
          status: TransportStatus.success,
          listTransport: dataState.data!.data!,
        ),
      );
    }

    if (dataState is DataFailed) {
      emit(
        state.copyWith(
          status: TransportStatus.failure,
        ),
      );
    }
  }
}

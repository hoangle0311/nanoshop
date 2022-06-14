import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'time_state.dart';

class TimeCubit extends Cubit<TimeState> {
  StreamSubscription<int>? _timeSubscription;

  TimeCubit()
      : super(
          const TimeState(time: 0),
        );

  void running({
    required int totalTime,
  }) {
    emit(
      state.copyWith(
        time: totalTime,
      ),
    );

    _timeSubscription = _changeTime(totalTime).listen(
      (duration) {
        emit(
          state.copyWith(
            time: duration,
            status: duration <= 0 ? TimeStatus.compelte : TimeStatus.running,
          ),
        );
      },
    );
  }

  Stream<int> _changeTime(int time) {
    return Stream.periodic(const Duration(seconds: 1), (x) => time - x - 1)
        .take(time);
  }
}

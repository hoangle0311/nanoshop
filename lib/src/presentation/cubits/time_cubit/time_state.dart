part of 'time_cubit.dart';

enum TimeStatus {
  initial,
  running,
  compelte,
}

class TimeState extends Equatable {
  final int time;
  final TimeStatus status;

  const TimeState({
    this.time = 0,
    this.status = TimeStatus.initial,
  });

  TimeState copyWith({
    int? time,
    TimeStatus? status,
  }) {
    return TimeState(
      time: time ?? this.time,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [
        time,
      ];
}

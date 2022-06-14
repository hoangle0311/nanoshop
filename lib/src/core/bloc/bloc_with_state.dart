import 'package:flutter_bloc/flutter_bloc.dart';

enum BlocProcessState {
  idle,
  busy,
}

abstract class BlocWithState<E, S> extends Bloc<E, S> {
  BlocWithState(S initialState) : super(initialState);

  BlocProcessState _blocProcessState = BlocProcessState.idle;

  BlocProcessState get processState => _blocProcessState;

  Stream<S> runBlocProcess(Stream<S> Function() process) async* {
    if (_blocProcessState == BlocProcessState.idle) {
      _blocProcessState = BlocProcessState.busy;
      yield* process();
      _blocProcessState = BlocProcessState.idle;
    }
  }
}

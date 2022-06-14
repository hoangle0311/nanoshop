import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'bottom_nav_state.dart';

class BottomNavCubit extends Cubit<BottomNavState> {
  BottomNavCubit()
      : super(
          BottomNavInitial(
            index: 0,
          ),
        );

  void onTapBottomNav(int index) {
    emit(
      BottomNavInitial(
        index: index,
      ),
    );
  }
}

part of 'bottom_nav_cubit.dart';

abstract class BottomNavState extends Equatable {
  final int index;

  BottomNavState({
    required this.index,
  });

  @override
  List<Object> get props => [index];
}

class BottomNavInitial extends BottomNavState {
  BottomNavInitial({required int index}) : super(index: index);
}

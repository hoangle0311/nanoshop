import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'get_list_coupon_state.dart';

class GetListCouponCubit extends Cubit<GetListCouponState> {
  GetListCouponCubit() : super(GetListCouponInitial());
}

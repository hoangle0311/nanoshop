import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'send_payment_state.dart';

class SendPaymentCubit extends Cubit<SendPaymentState> {
  SendPaymentCubit() : super(SendPaymentInitial());
}

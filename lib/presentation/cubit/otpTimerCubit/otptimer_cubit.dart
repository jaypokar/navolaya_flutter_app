import 'package:bloc/bloc.dart';

class OTPTimerCubit extends Cubit<int> {
  OTPTimerCubit() : super(0);

  void timerTick(int tick) {
    emit(tick);
  }
}

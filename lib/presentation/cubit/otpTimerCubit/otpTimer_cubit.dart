import 'package:flutter_bloc/flutter_bloc.dart';

class OTPTimerCubit extends Cubit<int> {
  OTPTimerCubit() : super(0);

  void timerTick(int tick) {
    emit(tick);
  }
}

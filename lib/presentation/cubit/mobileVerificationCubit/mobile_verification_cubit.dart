import 'package:bloc/bloc.dart';

class MobileVerificationCubit extends Cubit<String> {
  MobileVerificationCubit() : super('number');

  void changeNumber(String number) {
    emit(number);
  }
}

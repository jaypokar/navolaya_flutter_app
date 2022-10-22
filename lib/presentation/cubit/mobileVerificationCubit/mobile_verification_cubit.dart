import 'package:flutter_bloc/flutter_bloc.dart';

class MobileVerificationCubit extends Cubit<String> {
  MobileVerificationCubit() : super('number');

  void changeNumber(String number) {
    emit(number);
  }
}

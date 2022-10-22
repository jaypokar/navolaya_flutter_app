import 'package:flutter_bloc/flutter_bloc.dart';

class DashBoardTabChangeNotifierCubit extends Cubit<int> {
  DashBoardTabChangeNotifierCubit() : super(0);

  void changeTab(int pos) {
    emit(pos);
  }
}

import 'package:flutter_bloc/flutter_bloc.dart';

class HomeTabsNotifierCubit extends Cubit<int> {
  HomeTabsNotifierCubit() : super(0);

  void changeHomeTabs(int pos) {
    emit(pos);
  }
}

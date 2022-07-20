import 'package:bloc/bloc.dart';

class PageIndicatorPageCubit extends Cubit<int> {
  PageIndicatorPageCubit() : super(0);

  void changePage(int position) {
    emit(position);
  }
}

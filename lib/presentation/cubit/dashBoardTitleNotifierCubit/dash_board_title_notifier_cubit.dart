import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navolaya_flutter/resources/string_resources.dart';

class DashBoardTitleNotifierCubit extends Cubit<String> {
  DashBoardTitleNotifierCubit() : super(StringResources.discover);

  void changeTitle(String title) {
    emit(title);
  }
}

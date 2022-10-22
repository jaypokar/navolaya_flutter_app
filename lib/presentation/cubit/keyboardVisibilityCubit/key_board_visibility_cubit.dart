import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

class KeyBoardVisibilityCubit extends Cubit<bool> {
  StreamSubscription<bool>? keyboardSubscription;
  final keyboardVisibilityController = KeyboardVisibilityController();

  KeyBoardVisibilityCubit() : super(false) {
    keyboardSubscription = keyboardVisibilityController.onChange.listen((bool visible) {
      emit(visible);
    });
  }

  @override
  Future<void> close() async {
    if (keyboardSubscription != null) await keyboardSubscription!.cancel();
    return super.close();
  }
}

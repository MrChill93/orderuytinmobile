import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../register/register_page.dart';

part 'login_event.dart';
part 'login_state.dart';

const initIsChecked = false;
const initHidePw = true;

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  bool _hidePw = initHidePw;
  bool _isChecked = initIsChecked;
  late BuildContext _context;
  LoginBloc()
      : super(LoginInitial(hidePw: initHidePw, isChecked: initIsChecked)) {
    on<ToggleHidePwValue>((event, emitter) {
      _hidePw = !_hidePw;
      emitter(LoginInitial(hidePw: _hidePw, isChecked: _isChecked));
    });

    on<ToggleIsCheckedValue>((event, emitter) {
      _isChecked = !_isChecked;
      emitter(LoginInitial(isChecked: _isChecked, hidePw: _hidePw));
    });

    on<ChangeIsCheckedValue>((event, emitter) {
      _isChecked = event.newCheckedState;
      emitter(LoginInitial(isChecked: _isChecked, hidePw: _hidePw));
    });

    on<NavigateToRegisterPage>((event, emitter) {
      Navigator.of(event.context).push(
        MaterialPageRoute(
          builder: (_) => const RegisterPage(),
        ),
      );
    });
  }
}

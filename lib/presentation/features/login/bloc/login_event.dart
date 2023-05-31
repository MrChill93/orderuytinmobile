// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'login_bloc.dart';

@immutable
abstract class LoginEvent extends Equatable {}

class ToggleHidePwValue extends LoginEvent {
  @override
  List<Object?> get props => [];
}

class ToggleIsCheckedValue extends LoginEvent {
  @override
  List<Object?> get props => [];
}

class ChangeIsCheckedValue extends LoginEvent {
  final bool newCheckedState;
  ChangeIsCheckedValue({
    required this.newCheckedState,
  });
  @override
  List<Object?> get props => [newCheckedState];
}

class NavigateToRegisterPage extends LoginEvent {
  final BuildContext context;
  NavigateToRegisterPage({
    required this.context,
  });
  @override
  List<Object?> get props => [context];
}

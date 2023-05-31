// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'login_bloc.dart';

@immutable
abstract class LoginState extends Equatable {}

class LoginInitial extends LoginState {
  final bool hidePw;
  final bool isChecked;
  LoginInitial({
    required this.hidePw,
    required this.isChecked,
  });

  @override
  List<Object?> get props => [hidePw, isChecked];
}

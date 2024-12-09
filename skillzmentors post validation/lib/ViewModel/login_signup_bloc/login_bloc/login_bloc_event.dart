part of 'login_bloc_bloc.dart';

@immutable
sealed class LoginBlocEvent {}

class LoginButtonClickedEvent extends LoginBlocEvent {
  final String email;
  final String password;
  LoginButtonClickedEvent({required this.email, required this.password});
}

class LoginButtonNavigateEvent extends LoginBlocEvent {}

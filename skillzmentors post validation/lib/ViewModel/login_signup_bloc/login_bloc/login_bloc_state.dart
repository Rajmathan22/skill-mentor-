part of 'login_bloc_bloc.dart';

@immutable
sealed class LoginBlocState {}

final class LoginBlocInitial extends LoginBlocState {}

final class LoginLoading extends LoginBlocState {}

final class LoginSuccess extends LoginBlocState {
  
}

final class LoginFailure extends LoginBlocState {}

final class LoginNavigate extends LoginBlocState {}


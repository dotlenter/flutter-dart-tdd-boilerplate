part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AuthSessionEvent extends AuthEvent {}

class AuthRegisterUserEvent extends AuthEvent {
  final String emailAddress;
  final String password;
  final String name;
  final String birthDate;

  AuthRegisterUserEvent(this.emailAddress, this.password, this.name, this.birthDate);
}

class AuthLoginEvent extends AuthEvent{
  final String emailAddress;
  final String password;

  AuthLoginEvent(this.emailAddress, this.password);
}

class EmailChanged extends AuthEvent {
  final String emailAddress;

  EmailChanged(this.emailAddress);
}
class AuthCancel extends AuthEvent {}

class PasswordChanged extends AuthEvent {
  final String password;

  PasswordChanged(this.password);
}

class AuthLogoutEvent extends AuthEvent {}
part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class AuthUserSession extends AuthState {
  final bool isActiveSession;

  AuthUserSession({@required this.isActiveSession});

  @override
  List<Object> get props => [isActiveSession];
}

class Loading extends AuthState {}

class AuthLoaded extends AuthState {
  final User user;

  AuthLoaded({@required this.user});

  @override
  List<Object> get props => [user];
}

class AuthLogoutLoaded extends AuthState {}

class Email extends AuthState {
  final String emailAddress;

  Email({@required this.emailAddress});

  @override
  List<Object> get props => [emailAddress];
}

class Error extends AuthState {
  final String message;

  Error({@required this.message});

  @override
  List<Object> get props => [message];
}

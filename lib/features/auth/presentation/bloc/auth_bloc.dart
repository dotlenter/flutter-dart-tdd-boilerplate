import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:hanapp/core/usecases/usecase.dart';
import 'package:hanapp/core/validators/birthdate.dart';
import 'package:hanapp/core/validators/email_address.dart';
import 'package:hanapp/core/validators/name.dart';
import 'package:hanapp/core/validators/password.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/user.dart';
import '../../domain/usecases/check_user_session.dart';
import '../../domain/usecases/login_user_with_email_and_password.dart'
    as loginUsecase;
import '../../domain/usecases/logout_user.dart';
import '../../domain/usecases/register_user.dart' as registerUsecase;
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String CACHE_FAILURE_MESSAGE = 'Cache Failure';
const String INVALID_EMAIL_MESSAGE = 'The email is invalid';
const String INVALID_PASSWORD_MESSAGE =
    'Password must be 6 or more characters long and must contain 1 digit and 1 number.';
const String NO_USER_FOUND_MESSAGE = 'Invalid email or password.';
const String EMAIL_TAKEN_MESSAGE = 'Email already taken.';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final loginUsecase.LoginUserWithEmailAndPassword
      loginUserWithEmailAndPassword;
  final registerUsecase.RegisterUser registerUser;
  final CheckUserSession checkUserSession;
  final LogoutUser logoutUser;
  final EmailAddress emailAddress;
  final Password password;
  final Birthdate birthdate;
  final Name name;

  AuthBloc({
    @required loginUsecase.LoginUserWithEmailAndPassword login,
    @required registerUsecase.RegisterUser register,
    @required CheckUserSession session,
    @required LogoutUser logout,
    @required this.emailAddress,
    @required this.password,
    @required this.birthdate,
    @required this.name,
  })  : assert(login != null),
        assert(register != null),
        assert(session != null),
        assert(logout != null),
        assert(emailAddress != null),
        assert(password != null),
        assert(name != null),
        assert(birthdate != null),
        loginUserWithEmailAndPassword = login,
        registerUser = register,
        checkUserSession = session,
        logoutUser = logout;

  @override
  AuthState get initialState => AuthInitial();

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    if (event is AuthSessionEvent) {
      yield Loading();

      final userSession = await checkUserSession(NoParams());

      yield* userSession.fold((failure) async* {
        yield Error(message: CACHE_FAILURE_MESSAGE);
      }, (isLoggedIn) async* {
        yield AuthUserSession(isActiveSession: isLoggedIn);
      });
    } else if (event is EmailChanged) {
      final validEmail = emailAddress.isValid(event.emailAddress);

      yield* validEmail.fold(
        (failure) async* {
          yield Error(message: INVALID_EMAIL_MESSAGE);
        },
        (email) async* {
          yield Email(emailAddress: email);
        },
      );
    } else if (event is AuthLoginEvent) {
      final failureOrUser =
          await loginUserWithEmailAndPassword(loginUsecase.Params(
        email: event.emailAddress,
        password: event.password,
      ));
      yield* _eitherLoadedOrErrorState(failureOrUser);
    } else if (event is AuthRegisterUserEvent) {
      final validEmail = emailAddress.isValid(event.emailAddress);
      final validPassword = password.isValid(event.password);
      final validName = name.isValid(event.name);
      final validBirthdate = birthdate.isValid(event.birthDate);

      if (validEmail.isRight() &&
          validPassword.isRight() &&
          validName.isRight() &&
          validBirthdate.isRight()) {

        yield Loading();

        final failureOrUser = await registerUser(registerUsecase.Params(
          name: validName,
          email: validEmail,
          password: validPassword,
          birthDate: validBirthdate,
        ));

        yield* _eitherLoadedOrErrorState(failureOrUser);
      }
    }
  }

  Stream<AuthState> _eitherLoadedOrErrorState(
    Either<Failure, User> failureOrUser,
  ) async* {
    yield failureOrUser.fold(
      (failure) => Error(message: _mapFailureToMessage(failure)),
      (user) => AuthLoaded(user: user),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case CacheFailure:
        return CACHE_FAILURE_MESSAGE;
      case NoUserFoundFailure:
        return NO_USER_FOUND_MESSAGE;
      case EmailTakenFailure:
        return EMAIL_TAKEN_MESSAGE;
      default:
        return 'Unexpected error';
    }
  }
}

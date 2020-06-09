import 'package:dartz/dartz.dart';
import 'package:hanapp/core/error/failures.dart';

class Password {
  Either<Failure, String> isValid(String password) {
    return ((RegExp(r'^[a-zA-Z]').hasMatch(password) ||
            RegExp(r'^\d').hasMatch(password)) && (password.length > 6))
        ? Right(password)
        : Left(InvalidPasswordFailure());
  }
}

class InvalidPasswordFailure extends Failure {}

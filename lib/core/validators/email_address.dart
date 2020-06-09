import 'package:dartz/dartz.dart';
import 'package:hanapp/core/error/failures.dart';

class EmailAddress {
  Either<Failure, String> isValid(String emailAddress) {
    String emailRegex =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

    if (RegExp(emailRegex).hasMatch(emailAddress)) {
      return Right(emailAddress);
    } else {
      return Left(InvalidEmailFailure());
    }
  }
}

class InvalidEmailFailure extends Failure {}

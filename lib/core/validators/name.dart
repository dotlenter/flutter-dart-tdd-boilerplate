import 'package:dartz/dartz.dart';
import 'package:hanapp/core/error/failures.dart';

class Name {
  Either<Failure, String> isValid(String name) {
    return (name.length < 2) ? Right(name) : Left(InvalidNameFailure());
  }
}

class InvalidNameFailure extends Failure {}

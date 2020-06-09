import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

import '../error/failures.dart';
import '../util/value_validators.dart';
import 'birthdate.dart';
import 'email_address.dart';
import 'name.dart';
import 'password.dart';

class ValueValidatorImpl implements ValueValidator {
  final EmailAddress emailAddress;
  final Password password;
  final Name name;
  final Birthdate birthdate;

  ValueValidatorImpl({
    @required this.emailAddress,
    @required this.password,
    @required this.name,
    @required this.birthdate,
  });

  @override
  Future<Either<Failure, String>> isValidBirthDate(String birthDate) {
    
  }

  @override
  Future<Either<Failure, String>> isValidEmail(String emailAddress) {
    // TODO: implement isValidEmail
    return null;
  }

  @override
  Future<Either<Failure, String>> isValidName(String name) {
    // TODO: implement isValidName
    return null;
  }

  @override
  Future<Either<Failure, String>> isValidPassword(String password) {
    // TODO: implement isValidPassword
    return null;
  }
}

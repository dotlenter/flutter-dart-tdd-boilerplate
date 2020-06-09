import 'package:dartz/dartz.dart';
import 'package:hanapp/core/error/failures.dart';

abstract class ValueValidator{
  Future<Either<Failure, String>> isValidEmail(String emailAddress);
  Future<Either<Failure, String>> isValidPassword(String password);
  Future<Either<Failure, String>> isValidName(String name);
  Future<Either<Failure, String>> isValidBirthDate(String birthDate);
}
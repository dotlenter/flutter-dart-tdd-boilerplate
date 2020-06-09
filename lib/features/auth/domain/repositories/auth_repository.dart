import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/token.dart';
import '../entities/user.dart';

abstract class AuthRepository {
  Future<Either<Failure, User>> registerUser(
    String email,
    String password,
    String name,
    String birthDate,
  );
  Future<Either<Failure, User>> loginUserWithEmailAndPassword(
    String email,
    String password,
  );
  Future<Either<Failure, User>> resetPassword(
    String token,
    String newPassword,
  );
  Future<Either<Failure, Token>> refreshAuthToken(String refreshToken);
  Future<Either<Failure, User>> forgotPassword(String email);
  Future<Either<Failure, bool>> checkUserSession();
  Future<Either<Failure, bool>> logoutUser();
}

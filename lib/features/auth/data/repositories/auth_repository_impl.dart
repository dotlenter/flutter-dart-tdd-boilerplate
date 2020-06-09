import 'package:dartz/dartz.dart';
import 'package:hanapp/core/error/exceptions.dart';
import 'package:hanapp/features/auth/data/datasources/auth_local_data_source.dart';
import 'package:meta/meta.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/token.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final AuthLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  AuthRepositoryImpl({
    @required this.remoteDataSource,
    @required this.networkInfo,
    @required this.localDataSource,
  });

  @override
  Future<Either<Failure, User>> forgotPassword(String email) {
    return null;
  }

  @override
  Future<Either<Failure, User>> loginUserWithEmailAndPassword(
      String email, String password) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteUser = await remoteDataSource.loginUserWithEmailAndPassword(
            email, password);
        await localDataSource.cacheUserSession(remoteUser);
        return Right(remoteUser);
      } on ServerException {
        return Left(ServerFailure());
      } on InvalidEmailOrPasswordException {
        return Left(NoUserFoundFailure());
      }
    } else {
      return Left(InternetFailure());
    }
  }

  @override
  Future<Either<Failure, Token>> refreshAuthToken(String refreshToken) async {
    if (await networkInfo.isConnected) {
      try {
        return Right(await remoteDataSource.refreshAuthToken(refreshToken));
      } on ServerException {
        return Left(ServerFailure());
      }
    }else{
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, User>> resetPassword(
      String token, String newPassword) {
    return null;
  }

  @override
  Future<Either<Failure, bool>> checkUserSession() async {
    return Right(await localDataSource.isUserLoggedIn());
  }

  @override
  Future<Either<Failure, bool>> logoutUser() async {
    if (await networkInfo.isConnected) {
      try {
        return Right(await localDataSource.logoutUser());
      } on ServerException {
        return Left(ServerFailure());
      } on EmailAlreadyTakenException {
        return Left(EmailTakenFailure());
      }
    } else {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, User>> registerUser(
      String email, String password, String name, String birthDate) async {
    if (await networkInfo.isConnected) {
      try {
        return Right(await remoteDataSource.registerUser(
            email, password, name, birthDate));
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ServerFailure());
    }
  }
}

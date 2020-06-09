import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import '../../../../core/error/failures.dart';
import '../entities/token.dart';
import '../repositories/auth_repository.dart';

class RefreshAuthToken {
  final AuthRepository repository;
  RefreshAuthToken(this.repository);

  Future<Either<Failure, Token>> call(Params params) async {
    return await repository.refreshAuthToken(params.refreshToken);
  }
}

class Params extends Equatable {
  final String refreshToken;

  Params({@required this.refreshToken});

  @override
  List<Object> get props => [refreshToken];
}

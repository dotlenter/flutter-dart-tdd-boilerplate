import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import '../../../../core/error/failures.dart';
import '../entities/user.dart';
import '../repositories/auth_repository.dart';

class ResetPassword {
  final AuthRepository repository;

  ResetPassword(this.repository);
  Future<Either<Failure, User>> call(Params params) async {
    return await repository.resetPassword(params.token, params.newPassword);
  }
}

class Params extends Equatable {
  final token;
  final newPassword;

  Params({
    @required this.token,
    @required this.newPassword,
  });

  @override
  List<Object> get props => [token, newPassword];
}

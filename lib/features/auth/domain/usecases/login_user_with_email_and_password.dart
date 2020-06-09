import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:hanapp/core/usecases/usecase.dart';
import 'package:meta/meta.dart';

import '../../../../core/error/failures.dart';
import '../entities/user.dart';
import '../repositories/auth_repository.dart';

class LoginUserWithEmailAndPassword implements UseCase<User, Params>{
  final AuthRepository repository;

  LoginUserWithEmailAndPassword(this.repository);

  Future<Either<Failure, User>> call(Params params) async{
    return await repository.loginUserWithEmailAndPassword(params.email, params.password);
  }
}

class Params extends Equatable {
  final email;
  final password;

  Params({
    @required this.email,
    @required this.password,
  });

  @override
  List<Object> get props => [email, password];
}

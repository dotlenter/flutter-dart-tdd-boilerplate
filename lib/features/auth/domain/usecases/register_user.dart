import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/user.dart';
import '../repositories/auth_repository.dart';

class RegisterUser implements UseCase<User, Params>{
  final AuthRepository repository;

  RegisterUser(this.repository);
  Future<Either<Failure, User>> call(Params params) async {
    return await repository.registerUser(
      params.email,
      params.password,
      params.name,
      params.birthDate,
    );
  }
}

class Params extends Equatable {
  final email;
  final password;
  final name;
  final birthDate;

  Params({
    @required this.email,
    @required this.password,
    @required this.name,
    @required this.birthDate,
  });

  @override
  List<Object> get props => [
        email,
        password,
        name,
        birthDate,
      ];
}

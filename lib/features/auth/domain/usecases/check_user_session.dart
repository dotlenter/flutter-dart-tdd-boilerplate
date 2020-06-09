import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/auth_repository.dart';

class CheckUserSession implements UseCase<bool, NoParams> {
  final AuthRepository repository;

  CheckUserSession(this.repository);

  @override
  Future<Either<Failure, bool>> call(NoParams params) async {
    return await repository.checkUserSession();
  }
}

import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable{
  List properties;

  @override
  List<Object> get props => [properties];
}

class ServerFailure extends Failure {}

class CacheFailure extends Failure {}

class NoUserFoundFailure extends Failure {}

class InternetFailure extends Failure {}

class EmailTakenFailure extends Failure {}
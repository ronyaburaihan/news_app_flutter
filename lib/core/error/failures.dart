import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  @override
  List<Object> get props => [];
}

// General failures
class ServerFailure extends Failure {
  @override
  String toString() => 'Server Failure';
}

class CacheFailure extends Failure {
  @override
  String toString() => 'Cache Failure';
}

class UnexpectedFailure extends Failure {
  @override
  String toString() => 'Unexpected Error';
}

class NotAuthenticatedFailure extends Failure {
  @override
  String toString() => 'User not authenticated';
}

class InvalidCredentialsFailure extends Failure {
  @override
  String toString() => 'Invalid email or password';
}

class EmailAlreadyInUseFailure extends Failure {
  @override
  String toString() => 'Email is already in use';
}

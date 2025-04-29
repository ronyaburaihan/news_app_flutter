import 'package:dartz/dartz.dart';

import '../../core/error/failures.dart';
import '../../core/usecases/usecase.dart';
import '../entities/user.dart';
import '../repositories/auth_repository.dart';

class GetAuthStateChangesUseCase implements StreamUseCase<AppUser?, NoParams> {
  final AuthRepository repository;

  GetAuthStateChangesUseCase(this.repository);

  @override
  Stream<Either<Failure, AppUser?>> call(NoParams params) {
    return repository.authStateChanges.map((user) => Right(user)); // Assuming AuthRepository handles errors
  }
}
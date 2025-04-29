import 'package:dartz/dartz.dart';

import '../../core/error/failures.dart';
import '../entities/user.dart';

abstract class AuthRepository {
  Future<Either<Failure, AppUser>> signInWithEmailAndPassword(String email, String password);
  Future<Either<Failure, AppUser>> signUpWithEmailAndPassword(String email, String password);
  Future<Either<Failure, void>> signOut();
  Stream<AppUser?> get authStateChanges;
  AppUser? getCurrentUser();
}
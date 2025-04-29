import 'package:dartz/dartz.dart';

import '../../core/error/exceptions.dart';
import '../../core/error/failures.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/remote/firebase_auth_datasource.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, AppUser>> signInWithEmailAndPassword(String email, String password) async {
    try {
      final userCredential = await remoteDataSource.signInWithEmailAndPassword(email, password);
      return Right(AppUser(uid: userCredential.user!.uid, email: userCredential.user!.email));
    } on InvalidCredentialsException {
      return Left(InvalidCredentialsFailure());
    } on ServerException {
      return Left(ServerFailure());
    } catch (e) {
      return Left(UnexpectedFailure());
    }
  }

  @override
  Future<Either<Failure, AppUser>> signUpWithEmailAndPassword(String email, String password) async {
    try {
      final userCredential = await remoteDataSource.createUserWithEmailAndPassword(email, password);
      return Right(AppUser(uid: userCredential.user!.uid, email: userCredential.user!.email));
    } on EmailAlreadyInUseException {
      return Left(EmailAlreadyInUseFailure());
    } on ServerException {
      return Left(ServerFailure());
    } catch (e) {
      return Left(UnexpectedFailure());
    }
  }

  @override
  Future<Either<Failure, void>> signOut() async {
    try {
      await remoteDataSource.signOut();
      return Right(null);
    } on ServerException {
      return Left(ServerFailure());
    } catch (e) {
      return Left(UnexpectedFailure());
    }
  }

  @override
  Stream<AppUser?> get authStateChanges {
    return remoteDataSource.authStateChanges.map((firebaseUser) {
      if (firebaseUser != null) {
        return AppUser(uid: firebaseUser.uid, email: firebaseUser.email);
      }
      return null;
    });
  }

  @override
  AppUser? getCurrentUser() {
    final firebaseUser = remoteDataSource.getCurrentFirebaseUser();
    if (firebaseUser != null) {
      return AppUser(uid: firebaseUser.uid, email: firebaseUser.email);
    }
    return null;
  }
}
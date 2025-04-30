import 'package:dartz/dartz.dart';

import '../../core/error/exceptions.dart';
import '../../core/error/failures.dart';
import '../../domain/entities/article.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/repositories/bookmark_repository.dart';
import '../datasources/local/hive_bookmark_datasource.dart';
import '../datasources/remote/firestore_bookmark_datasource.dart';
import '../models/article_model.dart';

class BookmarkRepositoryImpl implements BookmarkRepository {
  final HiveBookmarkDataSource localDataSource;
  final BookmarkRemoteDataSource remoteDataSource;
  final AuthRepository authRepository;

  BookmarkRepositoryImpl({
    required this.localDataSource,
    required this.remoteDataSource,
    required this.authRepository,
  });

  String? get currentUserId => authRepository.getCurrentUser()?.uid;

  @override
  Future<Either<Failure, void>> addBookmark(Article article) async {
    if (currentUserId == null) {
      return Left(NotAuthenticatedFailure());
    }
    try {
      final articleModel = ArticleModel.fromEntity(article);
      await synchronizeBookmarks();
      await localDataSource.addBookmark(articleModel);
      await remoteDataSource.addBookmark(currentUserId!, article);
      return Right(null);
    } on CacheException {
      return Left(CacheFailure());
    } on ServerException {
      return Left(ServerFailure());
    } catch (e) {
      return Left(UnexpectedFailure());
    }
  }

  @override
  Future<Either<Failure, void>> removeBookmark(String articleUrl) async {
    if (currentUserId == null) {
      return Left(NotAuthenticatedFailure());
    }
    try {
      await synchronizeBookmarks();
      await localDataSource.removeBookmark(articleUrl);
      await remoteDataSource.removeBookmark(currentUserId!, articleUrl);
      return Right(null);
    } on CacheException {
      return Left(CacheFailure());
    } on ServerException {
      return Left(ServerFailure());
    } catch (e) {
      return Left(UnexpectedFailure());
    }
  }

  @override
  Stream<Either<Failure, List<Article>>> getUserBookmarks() async* {
    if (currentUserId == null) {
      yield Left(NotAuthenticatedFailure());
      return;
    }
    try {
      final localBookmarks = localDataSource.getBookmarks();
      yield Right(localBookmarks.map((model) => model.toEntity()).toList());
    } on CacheException {
      yield Left(CacheFailure());
    }

    await for (final remoteResult in remoteDataSource.getUserBookmarks(
      currentUserId!,
    )) {
      try {
        await localDataSource.clearBookmarks();
        for (final articleModel in remoteResult) {
          print(articleModel.title);
          await localDataSource.addBookmark(articleModel);
        }
        yield Right(remoteResult.map((model) => model.toEntity()).toList());
      } on CacheException {
        yield Left(CacheFailure());
      } on ServerException {
        yield Left(ServerFailure());
      } catch (e) {
        yield Left(UnexpectedFailure());
      }
    }
  }

  @override
  Future<Either<Failure, bool>> isArticleBookmarked(String articleUrl) async {
    try {
      final isBookmarkedLocally = await localDataSource.isArticleBookmarked(
        articleUrl,
      );
      if (isBookmarkedLocally) {
        return Right(true);
      }
    } on CacheException {
      return Left(CacheFailure());
    }

    if (currentUserId != null) {
      try {
        final isBookmarkedRemotely = await remoteDataSource.isArticleBookmarked(
          currentUserId!,
          articleUrl,
        );
        if (isBookmarkedRemotely) {
          return Right(true);
        }
      } on ServerException {
        return Left(ServerFailure());
      }
    }
    return Right(false);
  }

  @override
  Future<Either<Failure, void>> synchronizeBookmarks() async {
    if (currentUserId == null) {
      return Left(NotAuthenticatedFailure());
    }
    try {
      final localBookmarks = localDataSource.getBookmarks();
      final remoteBookmarksStream = remoteDataSource.getUserBookmarks(
        currentUserId!,
      );
      final remoteBookmarks = await remoteBookmarksStream.first;

      final urlsLocal = localBookmarks.map((article) => article.url).toSet();
      final urlsRemote = remoteBookmarks.map((article) => article.url).toSet();

      final bookmarksToAddRemotely =
          localBookmarks
              .where((article) => !urlsRemote.contains(article.url))
              .toList();
      for (final articleModel in bookmarksToAddRemotely) {
        await remoteDataSource.addBookmark(
          currentUserId!,
          articleModel.toEntity(),
        );
      }

      localDataSource.clearBookmarks();
      for (final articleModel in remoteBookmarks) {
        await localDataSource.addBookmark(articleModel);
      }
      return Right(null);
    } on CacheException {
      return Left(CacheFailure());
    } on ServerException {
      return Left(ServerFailure());
    } catch (e) {
      return Left(UnexpectedFailure());
    }
  }
}

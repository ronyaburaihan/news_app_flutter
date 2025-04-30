import 'package:dartz/dartz.dart';

import '../../core/error/failures.dart';
import '../entities/article.dart';

abstract class BookmarkRepository {
  Future<Either<Failure, void>> addBookmark(Article article);
  Future<Either<Failure, void>> removeBookmark(String articleUrl);
  Stream<Either<Failure, List<Article>>> getUserBookmarks();
  Future<Either<Failure, bool>> isArticleBookmarked(String articleUrl);
  Future<Either<Failure, void>> synchronizeBookmarks(); // For syncing local and remote
}
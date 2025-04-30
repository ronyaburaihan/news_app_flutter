import '../../../domain/entities/article.dart';
import '../../models/article_model.dart';

abstract class BookmarkRemoteDataSource {
  Future<void> addBookmark(String userId, Article article);

  Future<void> removeBookmark(String userId, String articleUrl);

  Stream<List<ArticleModel>> getUserBookmarks(
    String userId,
  );
  Future<bool> isArticleBookmarked(String userId, String articleUrl);
}

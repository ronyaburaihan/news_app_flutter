import '../../models/article_model.dart';

abstract class HiveBookmarkDataSource {
  Future<void> init();
  Future<void> addBookmark(ArticleModel article);
  Future<void> removeBookmark(String articleUrl);
  List<ArticleModel> getBookmarks();
  Future<bool> isArticleBookmarked(String articleUrl);
  Future<void> clearBookmarks();
}
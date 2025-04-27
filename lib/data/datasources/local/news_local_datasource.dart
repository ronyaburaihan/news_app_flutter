import '../../models/article_model.dart';

abstract class NewsLocalDataSource {
  Future<void> cacheArticles(List<ArticleModel> articles);
  List<ArticleModel> getCachedArticles();
  Future<void> clearCache();
}
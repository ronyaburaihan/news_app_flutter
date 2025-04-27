import 'package:news_app/data/models/article_model.dart';
import 'package:hive/hive.dart';
import '../../../core/error/exceptions.dart';
import 'news_local_datasource.dart';

class HiveNewsDataSourceImpl implements NewsLocalDataSource {
  static const String _boxName = 'news_articles';
  late Box<ArticleModel> _newsBox;

  Future<void> init() async {
    if (!Hive.isAdapterRegistered(ArticleModelAdapter().typeId)) {
      Hive.registerAdapter(ArticleModelAdapter());
    }
    _newsBox = await Hive.openBox<ArticleModel>(_boxName);
  }

  @override
  Future<void> cacheArticles(List<ArticleModel> articles) async {
    try {
      await _newsBox.clear(); // Clear previous cache
      await _newsBox.addAll(articles); // Add new articles
    } catch (e) {
      print('Error caching articles: $e');
    }
  }

  @override
  List<ArticleModel> getCachedArticles() {
    try {
      return _newsBox.values.toList();
    } catch (e) {
      throw CacheException();
    }
  }

  @override
  Future<void> clearCache() async {
    try {
      await _newsBox.clear();
    } catch (e) {
      throw CacheException();
    }
  }
}
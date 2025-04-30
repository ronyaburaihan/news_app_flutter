import 'package:hive/hive.dart';

import '../../../core/error/exceptions.dart';
import '../../models/article_model.dart';
import 'hive_bookmark_datasource.dart';

class HiveBookmarkDataSourceImpl implements HiveBookmarkDataSource {
  static const String _boxName = 'bookmarks';
  late Box<ArticleModel> _bookmarkBox;

  @override
  Future<void> init() async {
    if (!Hive.isAdapterRegistered(ArticleModelAdapter().typeId)) {
      Hive.registerAdapter(ArticleModelAdapter());
    }
    _bookmarkBox = await Hive.openBox<ArticleModel>(_boxName);
  }

  @override
  Future<void> addBookmark(ArticleModel article) async {
    try {
      await _bookmarkBox.put(article.url.replaceAll(RegExp(r'[^\w\s]+'), ''), article);
    } catch (e) {
      throw CacheException();
    }
  }

  @override
  Future<void> removeBookmark(String articleUrl) async {
    try {
      await _bookmarkBox.delete(articleUrl.replaceAll(RegExp(r'[^\w\s]+'), ''));
    } catch (e) {
      throw CacheException();
    }
  }

  @override
  List<ArticleModel> getBookmarks() {
    try {
      return _bookmarkBox.values.toList();
    } catch (e) {
      throw CacheException();
    }
  }

  @override
  Future<bool> isArticleBookmarked(String articleUrl) async {
    try {
      return _bookmarkBox.containsKey(articleUrl.replaceAll(RegExp(r'[^\w\s]+'), ''));
    } catch (e) {
      throw CacheException();
    }
  }

  @override
  Future<void> clearBookmarks() async {
    try {
      await _bookmarkBox.clear();
    } catch (e) {
      throw CacheException();
    }
  }
}
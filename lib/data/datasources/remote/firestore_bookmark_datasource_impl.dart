import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../core/error/exceptions.dart';
import '../../../domain/entities/article.dart';
import '../../models/article_model.dart';
import 'firestore_bookmark_datasource.dart';

class FirestoreBookmarkDataSourceImpl implements BookmarkRemoteDataSource {
  final FirebaseFirestore _firestore;

  FirestoreBookmarkDataSourceImpl(this._firestore);

  @override
  Future<void> addBookmark(String userId, Article article) async {
    try {
      final articleModel = ArticleModel(
        author: article.author,
        title: article.title,
        description: article.description,
        url: article.url,
        urlToImage: article.urlToImage,
        publishedAt: article.publishedAt,
        content: article.content,
        sourceName: article.sourceName,
      );
      await _firestore
          .collection('users')
          .doc(userId)
          .collection('bookmarks')
          .doc(article.url.replaceAll(RegExp(r'[^\w\s]+'), ''))
          .set(articleModel.toJson());
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<void> removeBookmark(String userId, String articleUrl) async {
    try {
      await _firestore
          .collection('users')
          .doc(userId)
          .collection('bookmarks')
          .doc(articleUrl.replaceAll(RegExp(r'[^\w\s]+'), ''))
          .delete();
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Stream<List<ArticleModel>> getUserBookmarks(String userId) {
    return _firestore
        .collection('users')
        .doc(userId)
        .collection('bookmarks')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => ArticleModel.fromFirebase(doc.data())).toList();
    });
  }

  @override
  Future<bool> isArticleBookmarked(String userId, String articleUrl) async {
    try {
      final doc = await _firestore
          .collection('users')
          .doc(userId)
          .collection('bookmarks')
          .doc(articleUrl.replaceAll(RegExp(r'[^\w\s]+'), ''))
          .get();
      return doc.exists;
    } catch (e) {
      throw ServerException();
    }
  }
}
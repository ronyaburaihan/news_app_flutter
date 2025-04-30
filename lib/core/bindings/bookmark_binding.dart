import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:news_app/presentation/controllers/bookmarks_controller.dart';

import '../../data/datasources/local/hive_bookmark_datasource.dart';
import '../../data/datasources/local/hive_bookmark_datasource_impl.dart';
import '../../data/datasources/remote/firebase_auth_datasource.dart';
import '../../data/datasources/remote/firebase_auth_datasource_impl.dart';
import '../../data/datasources/remote/firestore_bookmark_datasource.dart';
import '../../data/datasources/remote/firestore_bookmark_datasource_impl.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../data/repositories/bookmark_repository_impl.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/repositories/bookmark_repository.dart';
import '../../domain/usecases/get_bookmarked_articles.dart';
import '../../domain/usecases/unbookmark_article_usecase.dart';

class BookmarkBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FirebaseAuth.instance);
    Get.lazyPut(() => FirebaseFirestore.instance);

    Get.lazyPut<AuthRemoteDataSource>(
      () => FirebaseAuthDataSourceImpl(Get.find()),
    );

    Get.lazyPut<AuthRepository>(
      () => AuthRepositoryImpl(remoteDataSource: Get.find()),
    );

    Get.lazyPut<BookmarkRemoteDataSource>(
      () => FirestoreBookmarkDataSourceImpl(Get.find()),
    );
    Get.lazyPut<HiveBookmarkDataSource>(
      () => Get.find<HiveBookmarkDataSourceImpl>(),
    );

    Get.lazyPut<BookmarkRepository>(
      () => BookmarkRepositoryImpl(
        localDataSource: Get.find(),
        remoteDataSource: Get.find(),
        authRepository: Get.find(),
      ),
    );
    Get.put(
      BookmarksController(
        getBookmarkedArticlesUseCase: GetBookmarkedArticlesUseCase(Get.find()),
        unBookmarkArticleUseCase: UnBookmarkArticleUseCase(Get.find()),
      ),
    );
  }
}

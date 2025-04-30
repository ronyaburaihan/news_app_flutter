import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

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
import '../../domain/usecases/bookmark_article_usecase.dart';
import '../../domain/usecases/get_auth_state_changes_usecase.dart';
import '../../domain/usecases/get_current_user_usecase.dart';
import '../../domain/usecases/is_article_bookmarked.dart';
import '../../domain/usecases/sign_in_usecase.dart';
import '../../domain/usecases/sign_out_usecase.dart';
import '../../domain/usecases/sign_up_usecase.dart';
import '../../domain/usecases/unbookmark_article_usecase.dart';
import '../../presentation/controllers/article_detail_controller.dart';
import '../../presentation/controllers/auth_controller.dart';

class ArticleDetailBinding extends Bindings {
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

    Get.lazyPut(() => SignInUseCase(Get.find()));
    Get.lazyPut(() => SignUpUseCase(Get.find()));
    Get.lazyPut(() => SignOutUseCase(Get.find()));
    Get.lazyPut(() => GetAuthStateChangesUseCase(Get.find()));
    Get.lazyPut(() => GetCurrentUserUseCase(Get.find()));

    Get.lazyPut(
          () => AuthController(
        signInUseCase: Get.find(),
        signUpUseCase: Get.find(),
        signOutUseCase: Get.find(),
        getAuthStateChangesUseCase: Get.find(),
        getCurrentUserUseCase: Get.find(),
      ),
    );

    Get.put<ArticleDetailController>(
      ArticleDetailController(
        bookmarkArticleUseCase: BookmarkArticleUseCase(Get.find()),
        unBookmarkArticleUseCase: UnBookmarkArticleUseCase(Get.find()),
        isArticleBookmarkedUseCase: IsArticleBookmarkedUseCase(Get.find()),
      ),
    );
  }
}

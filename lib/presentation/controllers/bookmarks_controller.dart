import 'package:get/get.dart';

import '../../core/usecases/usecase.dart';
import '../../domain/entities/article.dart';
import '../../domain/usecases/get_bookmarked_articles.dart';
import '../../domain/usecases/unbookmark_article_usecase.dart';

class BookmarksController extends GetxController {
  final GetBookmarkedArticlesUseCase getBookmarkedArticlesUseCase;
  final UnBookmarkArticleUseCase unBookmarkArticleUseCase;

  BookmarksController({
    required this.getBookmarkedArticlesUseCase,
    required this.unBookmarkArticleUseCase,
  });

  var bookmarks = <Article>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    loadBookmarks();
  }

  void loadBookmarks() {
    isLoading.value = true;
    getBookmarkedArticlesUseCase(NoParams()).listen((result) {
      result.fold(
        (_) => bookmarks.value = [],
        (articles) => bookmarks.value = articles,
      );
      isLoading.value = false;
    });
  }

  void removeBookmark(String articleUrl) async {
    final result = await unBookmarkArticleUseCase(
      UnBookmarkParams(articleUrl: articleUrl),
    );
    result.fold(
      (failure) => Get.snackbar('Error', 'Failed to remove bookmark'),
      (_) {
        bookmarks.removeWhere((article) => article.url == articleUrl);
        Get.snackbar('Success', 'Bookmark removed');
      },
    );
  }
}

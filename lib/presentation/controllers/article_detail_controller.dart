import 'package:get/get.dart';

import '../../domain/entities/article.dart';
import '../../domain/usecases/bookmark_article_usecase.dart';
import '../../domain/usecases/is_article_bookmarked.dart';
import '../../domain/usecases/unbookmark_article_usecase.dart';

class ArticleDetailController extends GetxController {
  final BookmarkArticleUseCase bookmarkArticleUseCase;
  final UnBookmarkArticleUseCase unBookmarkArticleUseCase;
  final IsArticleBookmarkedUseCase isArticleBookmarkedUseCase;

  final RxBool isBookmarked = false.obs;
  late final Article article;

  ArticleDetailController({
    required this.bookmarkArticleUseCase,
    required this.unBookmarkArticleUseCase,
    required this.isArticleBookmarkedUseCase,
  });

  @override
  void onInit() {
    super.onInit();
    article = Get.arguments as Article;
    checkIfBookmarked();
  }

  void checkIfBookmarked() async {
    final result = await isArticleBookmarkedUseCase(
      IsBookmarkedParams(articleUrl: article.url),
    );
    result.fold(
      (failure) {
        print('Error checking bookmark status: $failure');
      },
      (isBookmarkedStatus) {
        isBookmarked.value = isBookmarkedStatus;
      },
    );
  }

  void toggleBookmark() async {
    if (isBookmarked.value) {
      final result = await unBookmarkArticleUseCase(
        UnBookmarkParams(articleUrl: article.url),
      );
      result.fold(
        (failure) {
          Get.snackbar(
            'Error',
            'Failed to remove bookmark: ${failure.toString()}',
            snackPosition: SnackPosition.BOTTOM,
          );
        },
        (_) {
          isBookmarked.value = false;
          Get.snackbar(
            'Success',
            'Bookmark removed',
            snackPosition: SnackPosition.BOTTOM,
          );
        },
      );
    } else {
      // Add bookmark
      final result = await bookmarkArticleUseCase(
        BookmarkParams(article: article),
      );
      result.fold(
        (failure) {
          Get.snackbar(
            'Error',
            'Failed to add bookmark: ${failure.toString()}',
            snackPosition: SnackPosition.BOTTOM,
          );
        },
        (_) {
          isBookmarked.value = true;
          Get.snackbar(
            'Success',
            'Article bookmarked',
            snackPosition: SnackPosition.BOTTOM,
          );
        },
      );
    }
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/bookmarks_controller.dart';
import '../widgets/article_list_item.dart';

class BookmarksPage extends GetView<BookmarksController> {
  const BookmarksPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Bookmarked Articles')),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.bookmarks.isEmpty) {
          return const Center(child: Text('No bookmarked articles yet.'));
        }

        return ListView.builder(
          itemCount: controller.bookmarks.length,
          itemBuilder: (context, index) {
            final article = controller.bookmarks[index];
            return ArticleListItem(article: article);
          },
        );
      }),
    );
  }
}

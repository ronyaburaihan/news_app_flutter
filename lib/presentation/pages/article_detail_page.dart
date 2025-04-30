import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/article_detail_controller.dart';
import '../controllers/auth_controller.dart';

class ArticleDetailPage extends GetView<ArticleDetailController> {
  const ArticleDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.find();

    return Scaffold(
      appBar: AppBar(
        title: Text("News Details"),
        actions: [
          Obx(
            () =>
                authController.isAuthenticated()
                    ? Obx(
                      () => IconButton(
                        icon: Icon(
                          controller.isBookmarked.value
                              ? Icons.bookmark
                              : Icons.bookmark_border,
                          color:
                              controller.isBookmarked.value
                                  ? Colors.yellow
                                  : null,
                        ),
                        onPressed: () => controller.toggleBookmark(),
                        tooltip:
                            controller.isBookmarked.value
                                ? 'Remove Bookmark'
                                : 'Bookmark Article',
                      ),
                    )
                    : Container(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              controller.article.title,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (controller.article.author != null)
                  Expanded(
                    child: Text(
                      '${controller.article.author} • ',
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                Text(
                  '${controller.article.sourceName} • ',
                  style: TextStyle(fontSize: 14),
                ),
                Text(
                  controller.article.publishedAt.toLocal().toString().split(
                    ' ',
                  )[0],
                  style: TextStyle(fontSize: 14),
                ),
              ],
            ),
            const SizedBox(height: 16),
            if (controller.article.urlToImage != null)
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.network(
                  controller.article.urlToImage!,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder:
                      (context, error, stackTrace) => Container(
                        height: 200,
                        width: MediaQuery.of(context).size.width,
                        color: Colors.grey[300],
                        child: Icon(Icons.image_not_supported, size: 50),
                      ),
                ),
              ),
            const SizedBox(height: 16),
            Text(
              controller.article.content,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

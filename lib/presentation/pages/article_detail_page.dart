import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../domain/entities/article.dart';

class ArticleDetailPage extends StatelessWidget {
  const ArticleDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Article article = Get.arguments as Article;

    return Scaffold(
      appBar: AppBar(title: Text("News Details")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              article.title,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                if (article.author != null)
                  Text('${article.author} • ', style: TextStyle(fontSize: 14)),
                Text(
                  '${article.sourceName} • ',
                  style: TextStyle(fontSize: 14),
                ),
                Text(
                  article.publishedAt.toLocal().toString().split(' ')[0],
                  style: TextStyle(fontSize: 14),
                ),
              ],
            ),
            const SizedBox(height: 16),
            if (article.urlToImage != null)
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.network(
                  article.urlToImage!,
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
            Text(article.content, style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

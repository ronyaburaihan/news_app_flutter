import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app/presentation/controllers/home_controller.dart';

import '../widgets/article_list_item.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('News Headlines')),
      body: controller.obx(
        (articles) => ListView.builder(
          itemCount: articles!.length,
          itemBuilder: (context, index) {
            final article = articles[index];
            return ArticleListItem(article: article);
          },
        ),
        onError: (error) => Center(child: Text(error!)),
        onLoading: const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}

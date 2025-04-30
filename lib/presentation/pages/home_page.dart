import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app/presentation/controllers/home_controller.dart';

import '../controllers/auth_controller.dart';
import '../widgets/article_list_item.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.find();

    return Scaffold(
      appBar: AppBar(
        title: const Text('News Headlines'),
        actions: [
          Obx(() =>
                authController.isAuthenticated()
                    ? IconButton(
                      icon: const Icon(Icons.logout),
                      onPressed: () => authController.signOut(),
                      tooltip: 'Sign Out',
                    )
                    : IconButton(
                      icon: const Icon(Icons.login),
                      onPressed: () => Get.toNamed('/signIn'),
                      tooltip: 'Sign In',
                    ),
          ),
          // Bookmarks button (show only if authenticated)
          Obx(() =>
                authController.isAuthenticated()
                    ? IconButton(
                      icon: const Icon(Icons.bookmark),
                      onPressed: () => Get.toNamed("/bookmarks"),
                      tooltip: 'Bookmarks',
                    ) : Container(),
          ),
        ],
      ),
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

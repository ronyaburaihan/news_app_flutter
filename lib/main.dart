import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:news_app/data/models/article_model.dart';
import 'package:news_app/core/bindings/article_detail_binding.dart';
import 'package:news_app/core/bindings/bookmark_binding.dart';
import 'package:news_app/presentation/pages/article_detail_page.dart';
import 'package:news_app/presentation/pages/bookmarks_page.dart';
import 'package:news_app/presentation/pages/home_page.dart';
import 'package:news_app/presentation/pages/sign_in_page.dart';
import 'package:news_app/presentation/pages/sign_up_page.dart';
import 'package:path_provider/path_provider.dart';

import 'core/bindings/initial_binding.dart';
import 'data/datasources/local/hive_bookmark_datasource_impl.dart';
import 'data/datasources/local/hive_news_datasource_impl.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Initialize Hive
  final appDocumentDir = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path);
  if (!Hive.isAdapterRegistered(ArticleModelAdapter().typeId)) {
    Hive.registerAdapter(ArticleModelAdapter());
  }

  final hiveBookmarkDataSource = HiveBookmarkDataSourceImpl();
  await hiveBookmarkDataSource.init();
  Get.put<HiveBookmarkDataSourceImpl>(hiveBookmarkDataSource, permanent: true);

  final hiveNewsDataSource = HiveNewsDataSourceImpl();
  await hiveNewsDataSource.init();
  Get.put<HiveNewsDataSourceImpl>(hiveNewsDataSource, permanent: true);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Newspaper App',
      initialBinding: InitialBinding(),
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => const HomePage()),
        GetPage(
          name: '/articleDetail',
          page: () => const ArticleDetailPage(),
          binding: ArticleDetailBinding(),
        ),
        GetPage(name: '/signIn', page: () => const SignInPage()),
        GetPage(name: '/signUp', page: () => const SignUpPage()),
        GetPage(
          name: '/bookmarks',
          page: () => const BookmarksPage(),
          binding: BookmarkBinding(),
        ),
      ],
    );
  }
}

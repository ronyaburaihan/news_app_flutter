import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../data/datasources/local/hive_bookmark_datasource.dart';
import '../../data/datasources/local/hive_bookmark_datasource_impl.dart';
import '../../data/datasources/local/hive_news_datasource_impl.dart';
import '../../data/datasources/local/news_local_datasource.dart';
import '../../data/datasources/remote/firebase_auth_datasource.dart';
import '../../data/datasources/remote/firebase_auth_datasource_impl.dart';
import '../../data/datasources/remote/firestore_bookmark_datasource.dart';
import '../../data/datasources/remote/firestore_bookmark_datasource_impl.dart';
import '../../data/datasources/remote/news_api_datasource_impl.dart';
import '../../data/datasources/remote/news_remote_datasource.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../data/repositories/bookmark_repository_impl.dart';
import '../../data/repositories/news_repository_impl.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/repositories/bookmark_repository.dart';
import '../../domain/repositories/news_repository.dart';
import '../../domain/usecases/bookmark_article_usecase.dart';
import '../../domain/usecases/get_auth_state_changes_usecase.dart';
import '../../domain/usecases/get_bookmarked_articles.dart';
import '../../domain/usecases/get_current_user_usecase.dart';
import '../../domain/usecases/get_top_headlines.dart';
import '../../domain/usecases/is_article_bookmarked.dart';
import '../../domain/usecases/sign_in_usecase.dart';
import '../../domain/usecases/sign_out_usecase.dart';
import '../../domain/usecases/sign_up_usecase.dart';
import '../../domain/usecases/unbookmark_article_usecase.dart';
import '../../presentation/controllers/auth_controller.dart';
import '../../presentation/controllers/bookmarks_controller.dart';
import '../../presentation/controllers/home_controller.dart';

class Injector {
  static Future<void> init() async {

  }
}

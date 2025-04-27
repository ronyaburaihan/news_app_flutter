import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../data/datasources/local/hive_news_datasource_impl.dart';
import '../../data/datasources/local/news_local_datasource.dart';
import '../../data/datasources/remote/news_api_datasource_impl.dart';
import '../../data/datasources/remote/news_remote_datasource.dart';
import '../../data/repositories/news_repository_impl.dart';
import '../../domain/repositories/news_repository.dart';
import '../../domain/usecases/get_top_headlines.dart';
import '../../presentation/controllers/home_controller.dart';

class Injector {
  static Future<void> init() async {

    // --- External Dependencies ---
    Get.lazyPut(() => http.Client());

    // --- Data Sources ---
    // News
    Get.lazyPut<NewsRemoteDataSource>(() => NewsApiDataSourceImpl(Get.find()));
    Get.lazyPut<NewsLocalDataSource>(() => Get.find<HiveNewsDataSourceImpl>());


    // --- Repositories ---
    // News
    Get.lazyPut<NewsRepository>(() => NewsRepositoryImpl(remoteDataSource: Get.find(), localDataSource: Get.find()));

    // --- Use Cases ---
    // News
    Get.lazyPut(() => GetTopHeadlinesUseCase(Get.find()));

    // --- Controllers ---
    // News
    Get.lazyPut(() => HomeController(getTopHeadlinesUseCase: Get.find()));
  }
}
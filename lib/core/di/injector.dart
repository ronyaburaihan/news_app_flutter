import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../data/datasources/local/hive_news_datasource_impl.dart';
import '../../data/datasources/local/news_local_datasource.dart';
import '../../data/datasources/remote/firebase_auth_datasource.dart';
import '../../data/datasources/remote/firebase_auth_datasource_impl.dart';
import '../../data/datasources/remote/news_api_datasource_impl.dart';
import '../../data/datasources/remote/news_remote_datasource.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../data/repositories/news_repository_impl.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/repositories/news_repository.dart';
import '../../domain/usecases/get_auth_state_changes_usecase.dart';
import '../../domain/usecases/get_current_user_usecase.dart';
import '../../domain/usecases/get_top_headlines.dart';
import '../../domain/usecases/sign_in_usecase.dart';
import '../../domain/usecases/sign_out_usecase.dart';
import '../../domain/usecases/sign_up_usecase.dart';
import '../../presentation/controllers/auth_controller.dart';
import '../../presentation/controllers/home_controller.dart';

class Injector {
  static Future<void> init() async {

    // --- External Dependencies ---
    Get.lazyPut(() => http.Client());
    Get.lazyPut(() => FirebaseAuth.instance);
    Get.lazyPut(() => FirebaseFirestore.instance);

    // --- Data Sources ---
    // News
    Get.lazyPut<NewsRemoteDataSource>(() => NewsApiDataSourceImpl(Get.find()));
    Get.lazyPut<NewsLocalDataSource>(() => Get.find<HiveNewsDataSourceImpl>());

    // Auth
    Get.lazyPut<AuthRemoteDataSource>(() => FirebaseAuthDataSourceImpl(Get.find()));

    // --- Repositories ---
    // News
    Get.lazyPut<NewsRepository>(() => NewsRepositoryImpl(remoteDataSource: Get.find(), localDataSource: Get.find()));

    // Auth
    Get.lazyPut<AuthRepository>(() => AuthRepositoryImpl(remoteDataSource: Get.find()));

    // --- Use Cases ---
    // News
    Get.lazyPut(() => GetTopHeadlinesUseCase(Get.find()));

    // Auth
    Get.lazyPut(() => SignInUseCase(Get.find()));
    Get.lazyPut(() => SignUpUseCase(Get.find()));
    Get.lazyPut(() => SignOutUseCase(Get.find()));
    Get.lazyPut(() => GetAuthStateChangesUseCase(Get.find()));
    Get.lazyPut(() => GetCurrentUserUseCase(Get.find()));

    // --- Controllers ---
    // News
    Get.lazyPut(() => HomeController(getTopHeadlinesUseCase: Get.find()));

    // Auth
    Get.lazyPut(() => AuthController(
      signInUseCase: Get.find(),
      signUpUseCase: Get.find(),
      signOutUseCase: Get.find(),
      getAuthStateChangesUseCase: Get.find(),
      getCurrentUserUseCase: Get.find(),
    ));
  }
}
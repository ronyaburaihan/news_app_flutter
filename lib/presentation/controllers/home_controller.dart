import 'package:get/get.dart';

import '../../core/usecases/usecase.dart';
import '../../domain/entities/article.dart';
import '../../domain/usecases/get_top_headlines.dart';

class HomeController extends GetxController with StateMixin<List<Article>> {
  final GetTopHeadlinesUseCase getTopHeadlinesUseCase;

  HomeController({required this.getTopHeadlinesUseCase});

  @override
  void onInit() {
    super.onInit();
    fetchTopHeadlines();
  }

  void fetchTopHeadlines() async {
    change(null, status: RxStatus.loading());
    final result = await getTopHeadlinesUseCase(NoParams());
    result.fold(
      (failure) =>
          change(null, status: RxStatus.error('Failed to load articles')),
      (articles) => change(articles, status: RxStatus.success()),
    );
  }
}

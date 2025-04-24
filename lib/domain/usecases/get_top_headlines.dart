import 'package:dartz/dartz.dart';

import '../../core/error/failures.dart';
import '../../core/usecases/usecase.dart';
import '../entities/article.dart';
import '../repositories/news_repository.dart';

class GetTopHeadlinesUseCase implements UseCase<List<Article>, NoParams> {
  final NewsRepository repository;

  GetTopHeadlinesUseCase(this.repository);

  @override
  Future<Either<Failure, List<Article>>> call(NoParams params) async {
    return await repository.getTopHeadlines();
  }
}
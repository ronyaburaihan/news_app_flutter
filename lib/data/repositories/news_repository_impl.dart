import 'package:dartz/dartz.dart';

import '../../core/error/exceptions.dart';
import '../../core/error/failures.dart';
import '../../domain/entities/article.dart';
import '../../domain/repositories/news_repository.dart';
import '../datasources/local/news_local_datasource.dart';
import '../datasources/remote/news_remote_datasource.dart';

class NewsRepositoryImpl implements NewsRepository {
  final NewsRemoteDataSource remoteDataSource;
  final NewsLocalDataSource localDataSource;

  NewsRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, List<Article>>> getTopHeadlines() async {
    try {
      final localArticles = localDataSource.getCachedArticles();
      if (localArticles.isNotEmpty) {
        print('Returning articles from cache');
        return Right(localArticles.map((model) => model.toEntity()).toList());
      }
    } on CacheException {
      print('Error getting articles from cache');
    }

    try {
      print('Fetching articles from remote');
      final remoteArticles = await remoteDataSource.getTopHeadlines();
      await localDataSource.cacheArticles(remoteArticles);
      return Right(remoteArticles.map((model) => model.toEntity()).toList());
    } on ServerException {
      print('Server failed to fetch articles');
      return Left(ServerFailure());
    }
  }
}

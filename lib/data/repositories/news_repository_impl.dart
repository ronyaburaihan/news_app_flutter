import 'package:dartz/dartz.dart';

import '../../core/error/exceptions.dart';
import '../../core/error/failures.dart';
import '../../domain/entities/article.dart';
import '../../domain/repositories/news_repository.dart';
import '../datasources/remote/news_remote_datasource.dart';

class NewsRepositoryImpl implements NewsRepository {
  final NewsRemoteDataSource remoteDataSource;
  // final NewsLocalDataSource localDataSource;

  NewsRepositoryImpl({required this.remoteDataSource /*, required this.localDataSource*/});

  @override
  Future<Either<Failure, List<Article>>> getTopHeadlines() async {
    try {
      final remoteArticles = await remoteDataSource.getTopHeadlines();
      // Cache articles locally here if needed: await localDataSource.cacheArticles(remoteArticles);
      return Right(remoteArticles.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
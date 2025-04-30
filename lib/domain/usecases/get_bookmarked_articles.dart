import 'package:dartz/dartz.dart';

import '../../core/error/failures.dart';
import '../../core/usecases/usecase.dart';
import '../entities/article.dart';
import '../repositories/bookmark_repository.dart';

class GetBookmarkedArticlesUseCase
    implements StreamUseCase<List<Article>, NoParams> {
  final BookmarkRepository repository;

  GetBookmarkedArticlesUseCase(this.repository);

  @override
  Stream<Either<Failure, List<Article>>> call(NoParams params) {
    return repository.getUserBookmarks();
  }
}

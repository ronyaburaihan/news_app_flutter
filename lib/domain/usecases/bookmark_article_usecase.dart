import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../core/error/failures.dart';
import '../../core/usecases/usecase.dart';
import '../entities/article.dart';
import '../repositories/bookmark_repository.dart';

class BookmarkArticleUseCase implements UseCase<void, BookmarkParams> {
  final BookmarkRepository repository;

  BookmarkArticleUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(BookmarkParams params) async {
    return await repository.addBookmark(params.article);
  }
}

class BookmarkParams extends Equatable {
  final Article article;

  const BookmarkParams({required this.article});

  @override
  List<Object?> get props => [article];
}

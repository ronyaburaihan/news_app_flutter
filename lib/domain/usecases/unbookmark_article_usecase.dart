import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../core/error/failures.dart';
import '../../core/usecases/usecase.dart';
import '../repositories/bookmark_repository.dart';

class UnBookmarkArticleUseCase implements UseCase<void, UnBookmarkParams> {
  final BookmarkRepository repository;

  UnBookmarkArticleUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(UnBookmarkParams params) async {
    return await repository.removeBookmark(params.articleUrl);
  }
}

class UnBookmarkParams extends Equatable {
  final String articleUrl;

  const UnBookmarkParams({required this.articleUrl});

  @override
  List<Object?> get props => [articleUrl];
}
import 'package:equatable/equatable.dart';

class Article extends Equatable {
  final String? author;
  final String title;
  final String description;
  final String url;
  final String? urlToImage;
  final DateTime publishedAt;
  final String content;
  final String sourceName;

  const Article({
    this.author,
    required this.title,
    required this.description,
    required this.url,
    this.urlToImage,
    required this.publishedAt,
    required this.content,
    required this.sourceName,
  });

  @override
  List<Object?> get props => [
    author,
    title,
    description,
    url,
    urlToImage,
    publishedAt,
    content,
    sourceName,
  ];
}

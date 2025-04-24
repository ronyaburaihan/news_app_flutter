import '../../domain/entities/article.dart';

class ArticleModel extends Article {
  final String? author;
  final String title;
  final String description;
  final String url;
  final String? urlToImage;
  final DateTime publishedAt;
  final String content;
  final String sourceName;

  const ArticleModel({
    this.author,
    required this.title,
    required this.description,
    required this.url,
    this.urlToImage,
    required this.publishedAt,
    required this.content,
    required this.sourceName,
  }) : super(
    author: author,
    title: title,
    description: description,
    url: url,
    urlToImage: urlToImage,
    publishedAt: publishedAt,
    content: content,
    sourceName: sourceName,
  );

  factory ArticleModel.fromJson(Map<String, dynamic> json) {
    return ArticleModel(
      author: json['author'],
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      url: json['url'] ?? '',
      urlToImage: json['urlToImage'],
      publishedAt: DateTime.parse(json['publishedAt']),
      content: json['content'] ?? '',
      sourceName: json['source']['name'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'author': author,
      'title': title,
      'description': description,
      'url': url,
      'urlToImage': urlToImage,
      'publishedAt': publishedAt.toIso8601String(),
      'content': content,
      'sourceName': sourceName,
    };
  }

  // Method to convert to Domain entity
  Article toEntity() {
    return Article(
      author: author,
      title: title,
      description: description,
      url: url,
      urlToImage: urlToImage,
      publishedAt: publishedAt,
      content: content,
      sourceName: sourceName,
    );
  }

  // Method to convert from Domain entity (useful for local storage)
  factory ArticleModel.fromEntity(Article article) {
    return ArticleModel(
      author: article.author,
      title: article.title,
      description: article.description,
      url: article.url,
      urlToImage: article.urlToImage,
      publishedAt: article.publishedAt,
      content: article.content,
      sourceName: article.sourceName,
    );
  }
}

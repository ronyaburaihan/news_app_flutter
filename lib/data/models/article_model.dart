import 'package:hive/hive.dart';

import '../../domain/entities/article.dart';

part 'article_model.g.dart';

@HiveType(typeId: 0)
class ArticleModel extends Article {
  @HiveField(0)
  final String? author;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final String description;
  @HiveField(3)
  final String url;
  @HiveField(4)
  final String? urlToImage;
  @HiveField(5)
  final DateTime publishedAt;
  @HiveField(6)
  final String content;
  @HiveField(7)
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

  factory ArticleModel.fromFirebase(Map<String, dynamic> json) {
    return ArticleModel(
      author: json['author'],
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      url: json['url'] ?? '',
      urlToImage: json['urlToImage'],
      publishedAt: DateTime.parse(json['publishedAt']),
      content: json['content'] ?? '',
      sourceName: json['sourceName'] ?? '',
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

  // Method to convert from Domain entity
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

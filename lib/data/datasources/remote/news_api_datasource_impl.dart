import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../core/error/exceptions.dart';
import '../../models/article_model.dart';
import 'news_remote_datasource.dart';

class NewsApiDataSourceImpl implements NewsRemoteDataSource {
  final http.Client client;
  final String apiKey = 'YOUR_API_KEY';
  final String baseUrl = 'https://newsapi.org/v2';

  NewsApiDataSourceImpl(this.client);

  @override
  Future<List<ArticleModel>> getTopHeadlines() async {
    final url = Uri.parse('$baseUrl/top-headlines?country=us&apiKey=$apiKey');
    final response = await client.get(url);

    if (response.statusCode == 200) {
      final Map<String, dynamic> json = jsonDecode(response.body);
      final List<dynamic> articlesJson = json['articles'];
      return articlesJson.map((json) => ArticleModel.fromJson(json)).toList();
    } else {
      throw ServerException();
    }
  }
}

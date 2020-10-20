import 'package:demonews/models/article_response.dart';
import 'package:demonews/models/source_response.dart';
import 'package:dio/dio.dart';

class NewsRepository {
  static String mainUrl = "https://newsapi.org/v2";
  final String apiKey = "151fa032ee4c4a3197bf826d40888633";
  final Dio _dio = Dio();
  var getSourceUrl = "$mainUrl/sources";
  var getTopHeadLinesUrl = "$mainUrl/top-headlines";
  var getEverythingUrl = "$mainUrl/everything";

  Future<SourceResponce> getSources() async {
    var params = {
      "apiKey": apiKey,
      "language": "en",
      "country": "in",
    };
    try {
      Response response = await _dio.get(getSourceUrl, queryParameters: params);
      return SourceResponce.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured : $error stacktrace :$stacktrace");
      return SourceResponce.withError(error);
      
    }
  }

  Future<ArticleResponce> getTopHeadlines() async {
    var params = {
      "apiKey": apiKey,
      // "language": "en",
      "country": "in",
    };
    try {
      Response response = await _dio.get(getTopHeadLinesUrl, queryParameters: params);
      return ArticleResponce.fromJson(response.data);
    } catch (error) {
      // print("Exception occured : $error stacktrace :$stacktrace");
      return ArticleResponce.withError(error);
      
    }
  }

   Future<ArticleResponce> getHotNews() async {
    var params = {
      "apiKey": apiKey,
      "q": "apple",
      "sortBy": "popularity",
    };
    try {
      Response response = await _dio.get(getEverythingUrl, queryParameters: params);
      return ArticleResponce.fromJson(response.data);
    } catch (error) {
      // print("Exception occured : $error stacktrace :$stacktrace");
      return ArticleResponce.withError(error);
      
    }
  }

    Future<ArticleResponce> getSourceNews(String sourceId) async {
    var params = {
      "apiKey": apiKey,
      "sources": sourceId,
    };
    try {
      Response response = await _dio.get(getSourceUrl, queryParameters: params);
      return ArticleResponce.fromJson(response.data);
    } catch (error) {
      // print("Exception occured : $error stacktrace :$stacktrace");
      return ArticleResponce.withError(error);
      
    }
  }

  Future<ArticleResponce> search(String searchValue) async {
    var params = {
      "apiKey": apiKey,
      "q": searchValue,
    };
    try {
      Response response = await _dio.get(getTopHeadLinesUrl, queryParameters: params);
      return ArticleResponce.fromJson(response.data);
    } catch (error) {
      // print("Exception occured : $error stacktrace :$stacktrace");
      return ArticleResponce.withError(error);
      
    }
  }
}

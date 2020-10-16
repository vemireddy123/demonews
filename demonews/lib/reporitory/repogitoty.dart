import 'package:demonews/models/source_response.dart';
import 'package:dio/dio.dart';

class NewsRepository {
  static String mainUrl = "https://newsapi.org/v2";
  final String apiKey = "151fa032ee4c4a3197bf826d40888633";
  final Dio _dio = Dio();
  var getSourceUrl = "$mainUrl/sources";
  var getTopHeadLines = "$mainUrl/top-headlines";
  var getEverythingUrl = "$mainUrl/everything";

  Future<SourceResponce> getSources() async {
    var params = {
      "apiKey": apiKey,
      "language": "en",
      "country": "us",
    };
    try {
      
    } catch (e) {
    }
  }
}

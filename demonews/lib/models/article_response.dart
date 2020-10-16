import 'package:demonews/models/article.dart';

class ArticleResponce {
  final List<ArticleModel> articles;
  final String error;

  ArticleResponce(this.articles, this.error);
  ArticleResponce.fromJson(Map<String, dynamic> json)
      : articles = (json["articles"] as List)
            .map((i) => new ArticleModel.fromJson(i))
            .toList(),
        error = "";
  ArticleResponce.withError(String errorValue)
      : articles = List(),
        error = errorValue;
}

import 'package:demonews/models/article.dart';

class SourceResponce {
  final List<ArticleModel> articles;
  final String error;

  SourceResponce(this.articles, this.error);
  SourceResponce.fromJson(Map<String, dynamic> json)
      : articles = (json["articles"] as List)
            .map((i) => new ArticleModel.fromJson(i))
            .toList(),
        error = "";
  SourceResponce.withError(String errorValue)
      : articles = List(),
        error = errorValue;
}

import 'package:demonews/models/article.dart';
import 'package:demonews/models/sources.dart';

class SourceResponce {
  final List<SourceModel> sources;
  final String error;

  SourceResponce(this.sources, this.error);
  SourceResponce.fromJson(Map<String, dynamic> json)
      : sources = (json["sources"] as List)
            .map((i) => new SourceModel.fromJson(i))
            .toList(),
        error = "";
  SourceResponce.withError(String errorValue)
      : sources = List(),
        error = errorValue;
}

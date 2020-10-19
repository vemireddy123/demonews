import 'package:demonews/models/article_response.dart';
import 'package:demonews/reporitory/repogitoty.dart';
import 'package:rxdart/subjects.dart';

class GetHotNewsBloc {
  final NewsRepository _repository = NewsRepository();
  final BehaviorSubject<ArticleResponce> _subject =
      BehaviorSubject<ArticleResponce>();

  getHotNews() async {
    ArticleResponce responce = await _repository.getHotNews();
    _subject.sink.add(responce);
  }

  dispose() {
    _subject.close();
  }

  BehaviorSubject<ArticleResponce> get subject => _subject;
}

final gethotNewBloc = GetHotNewsBloc();

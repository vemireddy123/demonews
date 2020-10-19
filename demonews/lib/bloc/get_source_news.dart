import 'package:demonews/models/article_response.dart';
import 'package:demonews/reporitory/repogitoty.dart';
import 'package:flutter/widgets.dart';
import 'package:rxdart/subjects.dart';

class GetSourceNewsBloc {
  final NewsRepository _repository = NewsRepository();
  final BehaviorSubject<ArticleResponce> _subject =
      BehaviorSubject<ArticleResponce>();

  getSourceNews(String sourceId) async {
    ArticleResponce responce = await _repository.getSourceNews(sourceId);
    _subject.sink.add(responce);
  }

  void drainStream() {
    _subject.value = null;
  }
  @mustCallSuper
  void dispose() async {
    await _subject.drain();
    _subject.close();
  }
  BehaviorSubject<ArticleResponce> get subject => _subject;
}
final getSourceNewsBloc = GetSourceNewsBloc();

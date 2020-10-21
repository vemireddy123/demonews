import 'package:demonews/models/article_response.dart';
import 'package:demonews/reporitory/repogitoty.dart';
import 'package:rxdart/subjects.dart';

class GetSearch {
  final NewsRepository _repository = NewsRepository();
  final BehaviorSubject<ArticleResponce> _subject =
      BehaviorSubject<ArticleResponce>();

 getSearch(String value) async {
    ArticleResponce responce = await _repository.search(value);
    _subject.sink.add(responce);
  }


 
  dispose() {
     
    _subject.close();
  }
  BehaviorSubject<ArticleResponce> get subject => _subject;
}
final getSearchBloc = GetSearch();

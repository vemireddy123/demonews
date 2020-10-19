import 'package:demonews/models/source_response.dart';
import 'package:demonews/reporitory/repogitoty.dart';
import 'package:rxdart/subjects.dart';

class GetSourdesBloc {
  final NewsRepository _repository = NewsRepository();
  final BehaviorSubject<SourceResponce> _subject =
      BehaviorSubject<SourceResponce>();

  getSourdes() async {
    SourceResponce responce = await _repository.getSources();
    _subject.sink.add(responce);
  }

  dispose() {
    _subject.close();
  }
  BehaviorSubject<SourceResponce> get subject => _subject;
}

final getSourcesBloc = GetSourdesBloc();

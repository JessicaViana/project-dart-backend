import '../models/news_model.dart';
import 'generic_service.dart';

class NewsService implements GenericService<NewsModel> {
  final List<NewsModel> _fakeDB = [];
  @override
  Future<bool> delete(int id) async {
    _fakeDB.removeWhere((e) => e.id == id);
    return true;
  }

  @override
  List<NewsModel> findAll() {
    return _fakeDB;
  }

  @override
  NewsModel findOne(int id) {
    NewsModel element = _fakeDB.firstWhere((e) => e.id == id);
    return element;
  }

  @override
  Future<bool> saveOrUpdate(NewsModel value) async {
    bool existInDB = _fakeDB.any((element) => element.id == value.id);
    if (existInDB) {
      _fakeDB.insert(value.id, value);
    } else {
      _fakeDB.add(value);
    }

    return true;
  }
}

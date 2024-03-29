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
  Future<List<NewsModel>> findAll() async {
    return _fakeDB;
  }

  @override
  Future<NewsModel> findOne(int id) async {
    NewsModel element = _fakeDB.firstWhere((e) => e.id == id);
    return element;
  }

  @override
  Future<bool> saveOrUpdate(NewsModel value) async {
    int index = _fakeDB.indexWhere(((element) => element.id == value.id));
    if (index >= 0) {
      _fakeDB.insert(index, value);
    } else {
      _fakeDB.add(value);
    }

    return true;
  }
}

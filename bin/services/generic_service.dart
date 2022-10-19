abstract class GenericService<T> {
  T findOne(int id);
  List<T> findAll();
  Future<bool> saveOrUpdate(T value);
  Future<bool> delete(int id);
}

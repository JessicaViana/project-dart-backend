abstract class DAO<T> {
  Future<bool> create(T value);
  Future<bool> delete(int id);
  Future<bool> update(T value);
  Future<T> findOne(int id);
  Future<List<T>> findAll();
}

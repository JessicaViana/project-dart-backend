import '../infra/database/db_connection.dart';
import '../models/user_model.dart';
import 'dao.dart';

class UserDAO implements DAO<UserModel> {
  final DbConnection _dbConnection;

  UserDAO(this._dbConnection);

  @override
  Future<bool> create(UserModel value) async {
    var results = await _execQuery(
      'INSERT INTO usuarios (nome, email, password) VALUES (?,?,?);',
      [value.name, value.email, value.password],
    );
    return results.affectedRows > 0;
  }

  @override
  Future<bool> delete(int id) async {
    var results = await _execQuery(
      'DELETE from usuarios where id = ?',
      [id],
    );
    return results.affectedRows > 0;
  }

  @override
  Future<List<UserModel>> findAll() async {
    var results = await _execQuery(
      'SELECT * FROM usuarios',
    );
    return results
        .map((row) => UserModel.fromMap(row.fields))
        .toList()
        .cast<UserModel>();
  }

  @override
  Future<UserModel> findOne(int id) async {
    var results = await _execQuery(
      'SELECT * FROM usuarios where id = ?',
      [id],
    );
    return UserModel.fromMap(
      results.first.fields,
    );
  }

  @override
  Future<bool> update(UserModel value) async {
    var results = await _execQuery(
      'UPDATE usuarios set nome = ?, password = ? where id = ?',
      [value.name, value.password, value.id],
    );
    return results.affectedRows > 0;
  }

  Future _execQuery(String sql, [List? params]) async {
    var connection = await _dbConnection.connection;
    var results = await connection.query(sql, params);
    return results;
  }
}

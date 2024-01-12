import '../dao/user_dao.dart';
import '../models/user_model.dart';
import 'generic_service.dart';

class UserService implements GenericService<UserModel> {
  final UserDAO _userDAO;

  UserService(
    this._userDAO,
  );

  @override
  Future<bool> delete(int id) async => _userDAO.delete(id);

  @override
  Future<List<UserModel>> findAll() async => _userDAO.findAll();

  @override
  Future<UserModel> findOne(int id) async => _userDAO.findOne(id);

  @override
  Future<bool> saveOrUpdate(UserModel value) async {
    return value.id == null
        ? await _userDAO.create(value)
        : await _userDAO.update(value);
  }
}

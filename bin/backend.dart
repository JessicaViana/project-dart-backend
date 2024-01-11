import 'package:shelf/shelf.dart';

import 'apis/blog_api.dart';
import 'apis/login_api.dart';
import 'dao/user_dao.dart';
import 'infra/custom_server.dart';
import 'infra/database/db_connection.dart';
import 'infra/dependency_injector/injection.dart';
import 'infra/middleware_interception.dart';
import 'infra/utils/custom_env_helper.dart';
import 'models/user_model.dart';

void main(List<String> arguments) async {
  final di = Injection.initialize();

  var conexao = di.get<DbConnection>();
  var userDAO = UserDAO(conexao);

  var userMarcos = UserModel.create()
    ..id = 5
    ..name = 'Marcos'
    ..email = 'marquinhos@email.com'
    ..password = '321';

  // print('CREATE'); // user(Marcos ...)
  // await userDAO.create(userMarcos).then(print);
  // print('FINDALL'); // todos os users
  //   await userDAO.create(userMarcos).then(print);
  // print('DELETE'); //! true
  // await userDAO.delete(4).then(print);
  print('FINDALL'); // todos os users
  await userDAO.findAll().then(print);
  print('UPDATE'); //! true
  userMarcos
    ..isActive = false
    ..name = 'Marcos Vinicius';
  await userDAO.update(userMarcos).then(print);
  print('FINDONE');
  await userDAO.findOne(5).then(print);

  final handlerCascade = Cascade()
      .add(
        di.get<LoginApi>().getHandler(),
      )
      .add(
        di.get<BlogApi>().getHandler(isProtected: true),
      );

  final handlerPipeline = Pipeline() //* Middlewares Globais
      .addMiddleware(logRequests())
      .addMiddleware(MiddlewareInterception().middleware)
      .addHandler((handlerCascade.handler));

  await CustomServer().inicialize(
    handler: handlerPipeline,
    address: await CustomEnvHelper.get<String>(key: 'SERVER_ADDRESS'),
    port: await CustomEnvHelper.get<int>(key: 'SERVER_PORT'),
  );
}

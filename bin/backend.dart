import 'package:mysql1/mysql1.dart';
import 'package:shelf/shelf.dart';

import 'apis/blog_api.dart';
import 'apis/login_api.dart';
import 'infra/custom_server.dart';
import 'infra/database/db_connection.dart';
import 'infra/dependency_injector/injection.dart';
import 'infra/middleware_interception.dart';
import 'infra/utils/custom_env_helper.dart';
import 'models/user_model.dart';

void main(List<String> arguments) async {
  final di = Injection.initialize();

  MySqlConnection connection = await di.get<DbConnection>().connection;

  var results = await connection.query('SELECT * from usuarios');

  for (var row in results) {
    var user = UserModel.fromMap(row.fields);
    print(user.toString());
  }

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

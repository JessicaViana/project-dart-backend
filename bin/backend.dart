import 'package:shelf/shelf.dart';

import 'api/blog_api.dart';
import 'api/login_api.dart';
import 'infra/custom_server.dart';
import 'infra/utils/env_helper.dart';

void main(List<String> arguments) async {
  final handlerCascade = Cascade()
      .add(
        BlogApi().blog,
      )
      .add(
        LoginApi().login,
      );

  final handlerPipeline = Pipeline()
      .addMiddleware(logRequests())
      .addHandler((handlerCascade.handler));

  await CustomServer().inicialize(
    handler: handlerPipeline,
    address: await CustomEnvHelper.get(key: 'SERVER_ADDRESS'),
    port: await CustomEnvHelper.get(key: 'SERVER_PORT'),
  );
}

import 'package:shelf/shelf.dart';

import 'api/blog_api.dart';
import 'api/login_api.dart';
import 'infra/custom_server.dart';

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

  await CustomServer().inicialize(handlerPipeline);
}

import 'package:shelf/shelf.dart';

import 'apis/blog_api.dart';
import 'apis/login_api.dart';
import 'infra/custom_server.dart';
import 'infra/middleware_interception.dart';
import 'infra/security/security_service.dart';
import 'infra/security/security_service_impl.dart';
import 'infra/utils/custom_env_helper.dart';
import 'services/news_service.dart';

void main(List<String> arguments) async {
  SecurityService securityService = SecurityServiceImpl();

  final handlerCascade = Cascade()
      .add(
        BlogApi(NewsService()).getHandler(middlewares: [
          securityService.authorization,
          securityService.validateJWT,
        ]),
      )
      .add(
        LoginApi(securityService).getHandler(middlewares: []),
      );

  final handlerPipeline = Pipeline()
      .addMiddleware(logRequests())
      .addMiddleware(MiddlewareInterception().middleware)
      // .addMiddleware(securityService.authorization)
      // .addMiddleware(securityService.validateJWT)
      .addHandler((handlerCascade.handler));

  await CustomServer().inicialize(
    handler: handlerPipeline,
    address: await CustomEnvHelper.get<String>(key: 'SERVER_ADDRESS'),
    port: await CustomEnvHelper.get<int>(key: 'SERVER_PORT'),
  );
}

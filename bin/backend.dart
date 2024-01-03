import 'package:shelf/shelf.dart';

import 'apis/blog_api.dart';
import 'apis/login_api.dart';
import 'infra/custom_server.dart';
import 'infra/dependency_injector/dependency_injector.dart';
import 'infra/middleware_interception.dart';
import 'infra/security/security_service.dart';
import 'infra/security/security_service_impl.dart';
import 'infra/utils/custom_env_helper.dart';
import 'services/news_service.dart';

void main(List<String> arguments) async {
  DependencyInjector di = DependencyInjector();

  di.register<SecurityService>(() => SecurityServiceImpl(), isSingleton: true);

  var securityService = di.get<SecurityService>();

  final handlerCascade = Cascade()
      .add(
        LoginApi(securityService).getHandler(),
      )
      .add(
        BlogApi(NewsService()).getHandler(isProtected: true),
      );

  final handlerPipeline = Pipeline() //* Middlewares Globais
      .addMiddleware(logRequests())
      .addMiddleware(MiddlewareInterception().middleware)
      // .addMiddleware(securityService.authorization) //gloval
      // .addMiddleware(securityService.validateJWT)
      .addHandler((handlerCascade.handler));

  await CustomServer().inicialize(
    handler: handlerPipeline,
    address: await CustomEnvHelper.get<String>(key: 'SERVER_ADDRESS'),
    port: await CustomEnvHelper.get<int>(key: 'SERVER_PORT'),
  );
}

import 'package:shelf/shelf.dart';

import '../infra/dependency_injector/dependency_injector.dart';
import '../infra/security/security_service.dart';

abstract class Api {
  Handler getHandler({
    List<Middleware>? middlewares,
    bool isProtected = false,
  });

  Handler createHandler({
    required Handler router,
    required List<Middleware>? middlewares,
    bool isProtected = false,
  }) {
    middlewares ??= [];

    if (isProtected) {
      var securityService = DependencyInjector().get<SecurityService>();
      middlewares.addAll(
        [
          securityService.authorization,
          securityService.validateJWT,
        ],
      );
    }

    Pipeline pipe = Pipeline();

    for (var m in middlewares) {
      pipe = pipe.addMiddleware(m);
    }

    return pipe.addHandler(router);
  }
}

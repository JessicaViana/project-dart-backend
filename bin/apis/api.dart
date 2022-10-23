import 'package:shelf/shelf.dart';

abstract class Api {
  Handler getHandler({List<Middleware>? middlewares});

  Handler createHandler({
    required Handler router,
    required List<Middleware>? middlewares,
  }) {
    middlewares ??= [];
    Pipeline pipe = Pipeline();
    for (var m in middlewares) {
      pipe = pipe.addMiddleware(m);
    }
    return pipe.addHandler(router);
  }
}

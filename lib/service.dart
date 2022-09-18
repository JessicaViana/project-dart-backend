import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

class Service {
  Handler get handler {
    final router = Router();

    router.get('/', (Request request) {
      return Response.ok('inicial');
    });

    router.get('/user/<user>', (Request request, String user) {
      return Response.ok('bem vinda $user');
    });

    router.get('/query', (Request request) {
      String? name = '${request.url.queryParameters['name']}';
      String? age = '${request.url.queryParameters['age']}';
      return Response.ok('nome = $name \nidade: $age');
    });

    return router;
  }
}

import 'dart:convert';

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

    router.post('/login', (Request request) async {
      // { user: admin, password = 123}
      String body = await request.readAsString();
      Map login = jsonDecode(body);

      if (login['user'] == 'admin' && login['password'] == '123') {
        Map responseMap = {'token': '12312', 'user_id': '7'};
        String responseJson = jsonEncode(responseMap);

        return Response.ok(responseJson,
            headers: {'content-type': 'application/json'});
      } else {
        return Response(401, body: 'Usuário ou Senha Inválidos');
      }
    });

    router.get('/html', (Request request) {
      return Response.ok(
        '<h1>Titulo da página<h1>',
        headers: {'content-type': 'text/html'},
      );
    });

    return router;
  }
}

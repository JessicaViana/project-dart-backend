import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

class LoginApi {
  final Router router = Router();

  Handler get login {
    router.post('/login', (Request req) async {
      final String reqBody = await req.readAsString();
      final Map loginData = jsonDecode(reqBody);

      final String user = loginData['user'];
      final String password = loginData['password'];

      if (user == 'susan' && password == '123') {
        return Response.ok('Seja bem vindo');
      } else {
        return Response.forbidden('usuário ou senha inválidos');
      }
    });
    return router;
  }
}

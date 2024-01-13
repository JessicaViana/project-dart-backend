import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import '../models/user_model.dart';
import '../services/user_service.dart';
import 'api.dart';

class UserApi extends Api {
  final UserService _userService;

  UserApi(
    this._userService,
  );

  @override
  Handler getHandler({
    List<Middleware>? middlewares,
    bool isProtected = false,
  }) {
    final Router router = Router();

    router.post('/users', (Request req) async {
      String reqBody = await req.readAsString();
      if (reqBody.isEmpty) return Response.badRequest();
      Map body = jsonDecode(reqBody);
      var result = await _userService.saveOrUpdate(
        UserModel.fromRequest(body),
      );
      return result
          ? Response.ok('Usuário salvo')
          : Response.internalServerError();
    });

    router.get('/users', (Request req) async {
      var users = await _userService.findAll();
      return Response.ok(users);
    });

    //TODO Implementar delete

    return createHandler(
      router: router,
      middlewares: middlewares,
    );
  }
}

import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import '../dto/auth_dto.dart';
import '../infra/security/security_service.dart';
import '../services/login_service.dart';
import 'api.dart';

class LoginApi extends Api {
  final SecurityService _securityService;
  final LoginService _loginService;

  LoginApi(
    this._securityService,
    this._loginService,
  );

  @override
  Handler getHandler({
    List<Middleware>? middlewares,
    bool isProtected = false,
  }) {
    final Router router = Router();

    router.post(
      '/login',
      (Request req) async {
        String reqBody = await req.readAsString();
        var authDTO = AuthDTO.fromRequest(reqBody);
        int userID = await _loginService.authenticate(authDTO);

        if (userID > 0) {
          var jwt = await _securityService.generateJWT(
            userID.toString(),
          );
          return Response.ok(
            jsonEncode(
              {'token': jwt},
            ),
          );
        } else {
          return Response.unauthorized('Email ou senha incorretos');
        }
      },
    );
    return router;
  }
}

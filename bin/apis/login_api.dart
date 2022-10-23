import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import '../infra/security/security_service.dart';

class LoginApi {
  final Router router = Router();
  final SecurityService _securityService;

  LoginApi(this._securityService);

  Handler get login {
    router.post('/login', (Request req) async {
      var token = await _securityService.generateJWT('1');
      var result = await _securityService.verifyJWT('token');
      return Response.ok(token);
    });
    return router;
  }
}

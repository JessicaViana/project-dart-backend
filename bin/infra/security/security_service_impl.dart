import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:shelf/shelf.dart';

import '../utils/custom_env_helper.dart';
import 'security_service.dart';

class SecurityServiceImpl implements SecurityService<JWT> {
  @override
  Future<String> generateJWT(String userID) async {
    var jwt = JWT(
      //claims
      {
        'iat': DateTime.now().millisecondsSinceEpoch, //data de criaçãp do token
        //clains pernonalizada
        'userID': userID,
        'roles': ['admin', 'user']
      },
    );
    String key = await CustomEnvHelper.get(key: 'JWT_KEY');
    String token = jwt.sign(SecretKey(key));
    return token;
  }

  @override
  Future<JWT?> verifyJWT(String token) async {
    String key = await CustomEnvHelper.get(key: 'JWT_KEY');
    try {
      return JWT.verify(token, SecretKey(key));
    } on JWTInvalidError {
      return null;
    } on JWTExpiredError {
      return null;
    } on JWTInvalidError {
      return null;
    } on JWTNotActiveError {
      return null;
    } on JWTUndefinedError {
      return null;
    } catch (e) {
      return null;
    }
  }

  @override
  Middleware get authorization {
    return (Handler handler) {
      return (Request req) async {
        var authorizationHeader = req.headers['Authorization'];
        JWT? jwt;

        if (authorizationHeader != null) {
          if (authorizationHeader.startsWith('Bearer ')) {
            String token = authorizationHeader.substring(7);
            jwt = await verifyJWT(token);
          }
        }
        var request = req.change(context: {'jwt': jwt});
        return handler(request);
      };
    };
  }

  @override
  // TODO: implement validateJWT
  Middleware get validateJWT => throw UnimplementedError();
}

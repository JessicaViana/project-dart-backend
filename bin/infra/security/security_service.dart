import 'package:shelf/shelf.dart';

abstract class SecurityService<T> {
  Future<String> generateJWT(String userID);
  Future<T?> verifyJWT(String token);
  Middleware get validateJWT;
  Middleware get authorization;
}

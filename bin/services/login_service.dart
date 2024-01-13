import 'dart:developer';

import 'package:password_dart/password_dart.dart';

import '../dto/auth_dto.dart';
import 'user_service.dart';

class LoginService {
  final UserService _userService;

  LoginService(this._userService);

  Future<int> authenticate(AuthDTO dto) async {
    //TODO devolver um enum talvez
    try {
      var user = await _userService.findByEmail(dto.email);
      if (user == null) return -1;
      return Password.verify(
        dto.password,
        user.password!,
      )
          ? user.id ?? 0
          : -1;
    } catch (e) {
      log('[ERRO] -> in Authenticate method by email ${dto.email} ');
    }
    return -1;
  }
}

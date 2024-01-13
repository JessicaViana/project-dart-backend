import 'dart:convert';

class AuthDTO {
  final int? id;
  final String email;
  final String password;

  AuthDTO(
    this.id,
    this.email,
    this.password,
  );

  factory AuthDTO.fromRequest(String body) {
    var map = jsonDecode(body);
    return AuthDTO(
      map['id'],
      map['email'],
      map['password'],
    );
  }
}

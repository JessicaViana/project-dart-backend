import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first

class UserModel {
  final int id;
  final String name;
  final String email;
  final String password;
  final bool isActive;
  final DateTime dtCreated;
  final DateTime dtUpdated;

  UserModel(
    this.id,
    this.name,
    this.email,
    this.password,
    this.isActive,
    this.dtCreated,
    this.dtUpdated,
  );

  @override
  String toString() {
    return 'UserModel(id: $id, name: $name, email: $email, password: $password, isActive: $isActive, dtCreated: $dtCreated, dtUpdated: $dtUpdated)';
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'nome': name,
      'email': email,
      'password': password,
      'is_ativo': isActive,
      'dt_criacao': dtCreated,
      'dt_autalizacao': dtUpdated,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      map['id'].toInt() as int,
      map['nome'] ?? '',
      map['email'] ?? '',
      map['password'] ?? '',
      map['is_ativo'] == 1,
      map['dt_criacao'] as DateTime,
      map['dt_autalizacao'] as DateTime,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

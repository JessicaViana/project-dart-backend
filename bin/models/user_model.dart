// ignore_for_file: public_member_api_docs, sort_constructors_first
class UserModel {
  int? id;
  String? name;
  String? email;
  String? password;
  bool? isActive;
  DateTime? dtCreated;
  DateTime? dtUpdated;

  UserModel({
    this.id,
    this.name,
    this.email,
    this.password,
    this.isActive,
    this.dtCreated,
    this.dtUpdated,
  });

  UserModel.create({
    this.id,
    this.name,
    this.email,
    this.isActive,
    this.dtCreated,
    this.dtUpdated,
  });

  @override
  String toString() {
    return 'UserModel(id: $id, name: $name, email: $email, isActive: $isActive, dtCreated: $dtCreated, dtUpdated: $dtUpdated)';
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel.create(
      id: map['id'].toInt() as int,
      name: map['nome'] ?? '',
      email: map['email'] ?? '',
      isActive: map['is_ativo'] == 1,
      dtCreated: map['dt_criacao'],
      dtUpdated: map['dt_autalizacao'],
    );
  }

  factory UserModel.fromRequest(Map map) {
    return UserModel()
      ..name = map['name']
      ..email = map['email']
      ..password = map['password'];
  }

  factory UserModel.fromEmail(Map map) {
    return UserModel()
      ..id = map['id'].toInt()
      ..password = map['password'];
  }
}

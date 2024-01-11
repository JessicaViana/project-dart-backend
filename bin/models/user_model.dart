class UserModel {
  int? id;
  String? name;
  String? email;
  String? password;
  bool? isActive;
  DateTime? dtCreated;
  DateTime? dtUpdated;

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
}

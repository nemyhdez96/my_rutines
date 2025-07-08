import 'package:my_routines/domain/entities/user/user.dart';

class UserModel extends User{
  UserModel({
    required super.id, 
    required super.nombre, 
    required super.email, 
    required super.activo}
  );

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    id: json["id"], nombre: json["nombre"], email: json["email"], activo: json["activo"]
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "nombre": nombre,
    "email": email,
    "activo": activo
  };

  factory UserModel.fromEntity(User user) => UserModel(id: user.id, nombre: user.nombre, email: user.email, activo: user.activo);
}
import 'package:my_routines/domain/entities/user/user_my.dart';

class UserModel extends UserMy {
  UserModel({
    required super.uuid,
    required super.nombre,
    required super.email,
    required super.activo,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    uuid: json["uuid"],
    nombre: json["nombre"],
    email: json["email"],
    activo: json["activo"],
  );

  Map<String, dynamic> toJson() => {
    "uuid": uuid,
    "nombre": nombre,
    "email": email,
    "activo": activo,
  };

  factory UserModel.fromEntity(UserMy user) => UserModel(
    uuid: user.uuid,
    nombre: user.nombre,
    email: user.email,
    activo: user.activo,
  );
}

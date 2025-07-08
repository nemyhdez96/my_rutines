import 'package:my_routines/domain/entities/auth/auth.dart';
import 'package:my_routines/infrastructure/models/user/user_model.dart';

class AuthModel extends Auth{
  AuthModel({
    required super.token, 
    required super.usuario
  });

  factory AuthModel.fromJson(json) => AuthModel(token: json["token"], usuario: UserModel.fromJson(json["usuario"]));
  
   Map<String, dynamic> toJson()=>{
    "token": token,
    "usuario": UserModel.fromEntity(usuario).toJson() 
  };

  factory AuthModel.fromEntity(Auth auth) => AuthModel(token: auth.token, usuario: auth.usuario);


}
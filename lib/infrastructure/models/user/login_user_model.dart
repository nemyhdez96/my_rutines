
import 'package:my_routines/domain/entities/user/login_user.dart';

class LoginUserModel extends LoginUser {
  LoginUserModel({
    required super.email, 
    required super.password
  });

  factory LoginUserModel.fromJson(json) => LoginUserModel(
    email: json["email"], 
    password: json["password"]
  );
  
  Map<String, dynamic> toJson() => {
    "email": email,
    "password": password
  };

  factory LoginUserModel.fromEntity(LoginUser loginUser) => LoginUserModel(
    email: loginUser.email, 
    password: loginUser.password
  );

}
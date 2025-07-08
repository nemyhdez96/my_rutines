
import 'package:my_routines/domain/entities/user/loginUser.dart';

class LoginUserModel extends Loginuser {
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

  factory LoginUserModel.fromEntity(Loginuser loginUser) => LoginUserModel(
    email: loginUser.email, 
    password: loginUser.password
  );

}
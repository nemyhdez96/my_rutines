import 'package:my_routines/domain/entities/user/user_my.dart';

class Auth {
  final String token;
  final userMy usuario;

  Auth({
    required this.token, 
    required this.usuario
  });
}
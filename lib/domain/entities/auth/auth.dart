import 'package:my_routines/domain/entities/user/user.dart';

class Auth {
  final String token;
  final User usuario;

  Auth({
    required this.token, 
    required this.usuario
  });
}
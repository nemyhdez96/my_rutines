import 'package:dartz/dartz.dart';
import 'package:my_routines/domain/entities/auth/auth.dart';
import 'package:my_routines/domain/entities/response/response_api.dart';
import 'package:my_routines/domain/entities/response/response_api_error.dart';
import 'package:my_routines/domain/entities/user/loginUser.dart';

abstract class LoginDatasource {

  Future<Either<ResponseApiError, ResponseApi<Auth>>> loginUser(Loginuser loginUser);
}
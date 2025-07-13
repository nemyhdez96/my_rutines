import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:my_routines/config/api_constants.dart';
import 'package:my_routines/domain/datasources/auth/login_datasource.dart';
import 'package:my_routines/domain/entities/auth/auth.dart';
import 'package:my_routines/domain/entities/response/response_api.dart';
import 'package:my_routines/domain/entities/response/response_api_error.dart';
import 'package:my_routines/domain/entities/user/login_user.dart';
import 'package:my_routines/infrastructure/models/auth/auth_model.dart';
import 'package:my_routines/infrastructure/models/response/response_api_error_model.dart';
import 'package:my_routines/infrastructure/models/user/login_user_model.dart';

class LoginDatasourceImpl extends LoginDatasource {
  final _dio = Dio(
    BaseOptions(
      baseUrl: ApiConstants.baseUrl,
      connectTimeout: Duration(seconds: 10),
      receiveTimeout: Duration(seconds: 10),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ),
  );

  @override
  Future<Either<ResponseApiError, ResponseApi<Auth>>> loginUser(
    LoginUser loginUser,
  ) async {
    try {
      final response = await _dio.post(
        "/auth/login",
        data: LoginUserModel.fromEntity(loginUser).toJson(),
      );
      final Auth authUserDataReponse = AuthModel.fromJson(
        response.data["data"],
      );
      final ResponseApi<Auth> responseAuth = ResponseApi(
        status: response.data["status"],
        data: authUserDataReponse,
      );
      return Right(responseAuth);
    } on DioException catch (e) {
      if (e.response?.data is Map<String, dynamic>) {
        return Left(ResponseApiErrorModel.fromJson(e.response?.data));
      } else {
        return Left(
          ResponseApiErrorModel(
            error: e.response!.statusMessage!,
            mensaje:
                'Ocurrió un error al intentar comunicarse con el servidor. Por favor, verifica tu conexión a internet o intenta nuevamente más tarde. Codigo: ${e.response?.statusCode!}',
          ),
        );
      }
    } catch (e) {
      return Left(
        ResponseApiErrorModel(
          error: "Ocurrió un error inesperado",
          mensaje: e.toString(),
        ),
      );
    }
  }
}

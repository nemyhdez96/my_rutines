import 'dart:convert';

import 'package:my_routines/domain/entities/response/response_api_error.dart';

class ResponseApiErrorModel extends ResponseApiError{
  ResponseApiErrorModel({
    required super.error, 
    required super.mensaje
  });

  factory ResponseApiErrorModel.fromJson(json) => ResponseApiErrorModel(
    error: json["error"], 
    mensaje: json["mensaje"]
  );

}
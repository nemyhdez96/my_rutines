import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:my_routines/domain/datasources/auth/login_datasource.dart';
import 'package:my_routines/domain/entities/auth/auth.dart';
import 'package:my_routines/domain/entities/response/response_api.dart';
import 'package:my_routines/domain/entities/response/response_api_error.dart';
import 'package:my_routines/domain/entities/user/loginUser.dart';
import 'package:my_routines/infrastructure/models/auth/auth_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  final LoginDatasource loginDatasource;

  bool isLoading = false;
  Auth? authUser;
  ResponseApiError? responseApiError;

  AuthProvider({required this.loginDatasource});

  Future<void> loginUser(Loginuser loginUser) async {
    responseApiError = null;
    _notificarIsLoading(!isLoading);
    final response = await loginDatasource.loginUser(loginUser);
    response.fold(
      (ifLeft) {
        responseApiError = ifLeft;
      },
      (ifRight) {
        authUser = ifRight.data;
      },
    );
    if (authUser != null) {
      await _saveAuthUserToPrefs();
    }
    
    _notificarIsLoading(!isLoading);
  }
  
  Future<void> _saveAuthUserToPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final authJson = json.encode(AuthModel.fromEntity(authUser!).toJson());
    await prefs.setString('authUser', authJson);
  }

  Future<void> loadAuthUserFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final authString = prefs.getString('authUser');

    if (authString != null) {
      final jsonMap = json.decode(authString);
      authUser = AuthModel.fromJson(jsonMap);
      notifyListeners(); // notifica que ya hay usuario cargado
    }
  }

  Future<void> logout() async {

    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('authUser');
    notifyListeners();
  }

  _notificarIsLoading(bool loading) {
    isLoading = loading;
    notifyListeners();
  }
}

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:my_routines/domain/datasources/auth/login_datasource.dart';
import 'package:my_routines/domain/entities/auth/auth.dart';
import 'package:my_routines/domain/entities/response/response_api_error.dart';
import 'package:my_routines/domain/entities/user/login_user.dart';
import 'package:my_routines/domain/entities/user/user_my.dart';
import 'package:my_routines/infrastructure/models/auth/auth_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthProviderMy extends ChangeNotifier {
  final LoginDatasource loginDatasource;

  bool isLoading = false;
  Auth? authUser;
  ResponseApiError? responseApiError;

  AuthProviderMy({required this.loginDatasource});

  Future<void> loginUser(LoginUser loginUser) async {
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

  Future<void> loginFirebase(LoginUser loginUser, String action) async {
    _notificarIsLoading(!isLoading);
    responseApiError = null;
    UserCredential? userCredential;
    try {
      if (action == "LOGIN") {
        userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: loginUser.email,
          password: loginUser.password,
        );
      } else if (action == "CREATE") {
        userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
              email: loginUser.email,
              password: loginUser.password,
            );
      }
      //context.go("/home");
    } on FirebaseAuthException catch (e) {
      String error = 'Error de autenticación: ';
      String mensaje = '';
      switch (e.code) {
        case 'user-not-found':
          mensaje = 'No se encontró ningún usuario con ese correo electrónico.';
          break;
        case 'wrong-password':
          mensaje = 'La contraseña es incorrecta para ese usuario.';
          break;
        case 'email-already-in-use':
          mensaje = 'El correo electrónico ya está en uso por otra cuenta.';
          break;
        case 'weak-password':
          mensaje = 'La contraseña proporcionada es demasiado débil.';
          break;
        case 'invalid-credential':
          mensaje = 'Las credenciales proporcionadas son inválidas.';
          break;
        default:
          error += 'Error desconocido: ';
          mensaje = e.message!;
      }

      responseApiError = ResponseApiError(mensaje: mensaje, error: error);
    } catch (e) {
      String error = 'Error de autenticación: ';
      String mensaje = '';
      error += 'Error desconocido: ';
      mensaje = e.toString();
      responseApiError = ResponseApiError(mensaje: mensaje, error: error);
    }
    if (userCredential != null) {
      authUser = Auth(
        token: "",
        usuario: userMy(
          uuid: userCredential.user!.uid,
          email: userCredential.user!.email ?? '',
          nombre: userCredential.user!.displayName ?? '',
          activo: true,
        ),
      );
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
    final user = FirebaseAuth.instance.currentUser;
    if (authString != null) {
      final jsonMap = json.decode(authString);
      authUser = AuthModel.fromJson(jsonMap);
      notifyListeners(); // notifica que ya hay usuario cargado
    }
    else if (user != null) {
      authUser = null;
      authUser = Auth(
        token: "",
        usuario: userMy(
          uuid: user!.uid,
          email: user.email ?? '',
          nombre: user.displayName ?? '',
          activo: true,
        ),
      );
      await _saveAuthUserToPrefs();
      notifyListeners();
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

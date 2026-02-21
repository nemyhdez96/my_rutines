import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';
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
    _notificarIsLoading(true);
    try {
      responseApiError = null;
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
    } catch (e) {
      debugPrint('Error en loginUser: $e');
      responseApiError = ResponseApiError(
        mensaje: 'Ocurrió un error inesperado al iniciar sesión',
        error: e.toString(),
      );
    } finally {
      _notificarIsLoading(false);
    }
  }

  Future<void> loginFirebase(LoginUser loginUser, String action) async {
    _notificarIsLoading(true);
    try {
      responseApiError = null;
      UserCredential? userCredential;
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

      if (userCredential != null) {
        authUser = Auth(
          token: "",
          usuario: UserMy(
            uuid: userCredential.user!.uid,
            email: userCredential.user!.email ?? '',
            nombre: userCredential.user!.displayName ?? '',
            activo: true,
          ),
        );
        await _saveAuthUserToPrefs();
      }
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
          mensaje = e.message ?? 'Ocurrió un error de autenticación.';
      }
      responseApiError = ResponseApiError(mensaje: mensaje, error: error);
    } catch (e) {
      responseApiError = ResponseApiError(
        mensaje: 'Error inesperado',
        error: e.toString(),
      );
    } finally {
      _notificarIsLoading(false);
    }
  }

  Future<void> _saveAuthUserToPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final authJson = json.encode(AuthModel.fromEntity(authUser!).toJson());
    await prefs.setString('authUser', authJson);
  }

  Future<void> loadAuthUserFromPrefs() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final authString = prefs.getString('authUser');
      final user = FirebaseAuth.instance.currentUser;

      if (authString != null) {
        final jsonMap = json.decode(authString);
        authUser = AuthModel.fromJson(jsonMap);
      } else if (user != null) {
        authUser = Auth(
          token: "",
          usuario: UserMy(
            uuid: user.uid,
            email: user.email ?? '',
            nombre: user.displayName ?? '',
            activo: true,
          ),
        );
        await _saveAuthUserToPrefs();
      } else {
        authUser = null;
      }
    } catch (e) {
      debugPrint('Error loading auth user from prefs: $e');
      authUser = null;
    } finally {
      notifyListeners();
    }
  }

  Future<void> logout() async {
    _notificarIsLoading(true);
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('authUser');

      // Attempt to disconnect from Google if applicable
      try {
        final GoogleSignIn googleSignIn = GoogleSignIn();
        if (await googleSignIn.isSignedIn()) {
          await googleSignIn.disconnect();
        }
      } catch (e) {
        debugPrint('Error disconnecting Google: $e');
      }

      await FirebaseAuth.instance.signOut();
    } catch (e) {
      debugPrint('Error al cerrar sesión: $e');
    } finally {
      authUser = null;
      _notificarIsLoading(false);
    }
  }

  _notificarIsLoading(bool loading) {
    isLoading = loading;
    notifyListeners();
  }

  Future<void> signInWithGoogle() async {
    _notificarIsLoading(true);
    try {
      responseApiError = null;
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      if (googleUser == null) {
        // Login cancelado, salir silenciosamente
        return;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential = await FirebaseAuth.instance.signInWithCredential(
        credential,
      );

      authUser = Auth(
        token: "",
        usuario: UserMy(
          uuid: userCredential.user!.uid,
          email: userCredential.user!.email ?? '',
          nombre: userCredential.user!.displayName ?? '',
          activo: true,
        ),
      );
      await _saveAuthUserToPrefs();
    } catch (e) {
      String error = 'Error de autenticación con Google: ';
      String mensaje = e.toString();
      responseApiError = ResponseApiError(mensaje: mensaje, error: error);
      debugPrint('$error $mensaje');
    } finally {
      _notificarIsLoading(false);
    }
  }

  bool navegacion(BuildContext context) {
    if (authUser != null) {
      context.go("/home");
      return true;
    }
    if (responseApiError != null) {
      // Keep existing dialog for now, or could change to inline error
      return false;
    }
    return false;
  }
}

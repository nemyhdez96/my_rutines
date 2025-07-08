import 'dart:math';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_routines/presentation/providers/auth_provider.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(Object context) {
    return Scaffold(body: _SplashScreenVew());
  }
}

class _SplashScreenVew extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SplashScreenVewState();
}

class _SplashScreenVewState extends State<_SplashScreenVew> {
  @override
  void initState() {
    super.initState();

    // Espera al primer frame para evitar redirigir antes de que el splash se muestre
    cargarUsuario();
  
  }

  void cargarUsuario() async {
    final authProvider = context.read<AuthProvider>();
    await Future.delayed(const Duration(seconds: 1));
    await authProvider.loadAuthUserFromPrefs();
    navegar(authProvider);
  }

  void navegar(AuthProvider authProvider) {
    if (authProvider.authUser != null) {
      context.go('/home');
    } else {
      context.go('/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    // final authProvider = context.watch<AuthProvider>();
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/icons/rutina-de-ejercicio.png",
              width: size.width * 0.7,
              height: 150,
              fit: BoxFit.contain,
            ),
            SizedBox(height: 20),
            CircularProgressIndicator(),
            SizedBox(height: 10),
            Text('Cargando...', style: TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_routines/presentation/providers/auth_provider_my.dart';
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
    final authProvider = context.read<AuthProviderMy>();
    await Future.delayed(const Duration(seconds: 1));
    await authProvider.loadAuthUserFromPrefs();
    if (!mounted) return;
    navegar(authProvider);
  }

  void navegar(AuthProviderMy authProvider) {
    if (authProvider.authUser != null) {
      context.go('/home');
    } else {
      context.go('/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            // Logo Container
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: colorScheme.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Image.asset(
                "assets/icons/mancuerna.png",
                width: 60,
                height: 60,
                color: colorScheme.primary,
              ),
            ),
            const SizedBox(height: 30),
            // Title
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "My",
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: colorScheme.onSurface,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  "Motines",
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: colorScheme.primary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            // Subtitle
            Text(
              "TU RITMO, TU FUERZA",
              style: TextStyle(
                fontSize: 12,
                letterSpacing: 2.0,
                color: colorScheme.onSurface.withValues(alpha: 0.54),
                fontWeight: FontWeight.w600,
              ),
            ),
            const Spacer(),

            // Loading
            Text(
              'CARGANDO...',
              style: TextStyle(
                fontSize: 10,
                letterSpacing: 1.5,
                color: colorScheme.onSurface.withValues(alpha: 0.7),
              ),
            ),
            const SizedBox(height: 15),
            SizedBox(
              width: 150,
              child: LinearProgressIndicator(
                backgroundColor: colorScheme.surfaceContainerHighest,
                color: colorScheme.primary,
                minHeight: 4,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 100), // Bottom padding
          ],
        ),
      ),
    );
  }
}

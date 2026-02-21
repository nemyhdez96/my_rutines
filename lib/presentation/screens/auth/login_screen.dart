import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_routines/domain/entities/user/login_user.dart';
import 'package:my_routines/presentation/providers/auth_provider_my.dart';
import 'package:my_routines/presentation/widgets/dialog/defauld_dialog.dart';
import 'package:my_routines/presentation/widgets/loading_overlay.dart';
import 'package:my_routines/utils/utils.dart';
import 'package:provider/provider.dart';
import 'package:my_routines/presentation/widgets/inputs/custom_dark_text_field.dart';

/// Main screen for user authentication.
///
/// This screen handles both email/password login and Google sign-in.
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(Object context) {
    return Scaffold(body: _LoginView());
  }
}

/// The internal view for the login screen, managing form state and actions.
class _LoginView extends StatefulWidget {
  const _LoginView();

  @override
  State<StatefulWidget> createState() => _LoginViestate();
}

class _LoginViestate extends State<_LoginView> {
  // Controllers for form fields
  late TextEditingController emailController;
  late TextEditingController passwordController;

  // Error messages for validation
  String? _emailError;
  String? _passwordError;

  // Overall form validity state
  bool isValid = true;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    // Clean up controllers when the widget is removed
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProviderMy>();

    /// Validates the login form fields.
    ///
    /// Sets error messages for empty or invalid email/password formats.
    void validateForm() {
      // Reset validation state before check
      setState(() {
        _emailError = null;
        _passwordError = null;
      });
      isValid = true;

      // Email validation: required and format check
      if (emailController.text.trim().isEmpty) {
        setState(() {
          _emailError = "El correo es obligatorio";
        });
        isValid = false;
      } else if (!Utils.isValidEmail(emailController.text.trim())) {
        setState(() {
          _emailError = "Ingrese un correo válido";
        });
        isValid = false;
      }

      // Password validation: required and format check (via Utils)
      if (passwordController.text.isEmpty) {
        setState(() {
          _passwordError = "La contraseña es obligatoria";
        });
        isValid = false;
      } else if (!Utils.isValidPassword(passwordController.text)) {
        setState(() {
          _passwordError =
              "La contraseña debe tener al menos 8 caracteres, una letra y un número";
        });
        isValid = false;
      }
    }

    /// Handles the login process based on the specified [action].
    ///
    /// Can be "GOOGLE" for social login or any other string for standard login.
    void onLoginUser(String action) async {
      if (action == "GOOGLE") {
        // Trigger Google Sign-In flow
        await authProvider.signInWithGoogle();
        if (!context.mounted) return;
      } else {
        // Standard Firebase Email/Password login
        validateForm();
        if (!isValid) return;

        final loginUser = LoginUser(
          email: emailController.value.text,
          password: passwordController.value.text,
        );

        await authProvider.loginFirebase(loginUser, action);
        if (!context.mounted) return;
      }

      // Handle navigation or errors after the auth process
      if (!authProvider.navegacion(context)) {
        // Show error dialog if navigation fails/auth has an error
        if (authProvider.responseApiError != null) {
          errorDialog(
            context: context,
            mesaje: authProvider.responseApiError?.mensaje,
            icon: Icons.error,
          );
        }
      }
    }

    return Scaffold(
      body: LoadingOverlay(
        isLoading: authProvider.isLoading,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 40),
                  // App Branding Header
                  Text(
                    "My Motines",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Bienvenido de nuevo",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onSurface,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    "Tu viaje fitness continúa aquí.",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 40),

                  // Alternative Auth Options (Google)
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () => onLoginUser("GOOGLE"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/icons/google.png",
                            width: 24,
                            height: 24,
                          ),
                          const SizedBox(width: 10),
                          const Text(
                            "Continuar con Google",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),
                  // Visual divider for alternatives
                  Row(
                    children: [
                      Expanded(
                        child: Divider(
                          color: Theme.of(
                            context,
                          ).colorScheme.onSurface.withValues(alpha: 0.24),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          "o",
                          style: TextStyle(
                            color: Theme.of(
                              context,
                            ).colorScheme.onSurface.withValues(alpha: 0.54),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          color: Theme.of(
                            context,
                          ).colorScheme.onSurface.withValues(alpha: 0.24),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),

                  // Email Input Field
                  CustomDarkTextField(
                    controller: emailController,
                    hintText: "Correo electrónico",
                    icon: Icons.email_outlined,
                    obscureText: false,
                    errorText: _emailError,
                  ),
                  const SizedBox(height: 20),

                  // Password Input Field
                  CustomDarkTextField(
                    controller: passwordController,
                    hintText: "Contraseña",
                    icon: Icons.lock_outlined,
                    obscureText: true,
                    isPassword: true,
                    errorText: _passwordError,
                  ),

                  const SizedBox(height: 15),
                  // Link for password recovery
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () => context.push('/forgot-password'),
                      child: Text(
                        "¿Olvidaste tu contraseña?",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),

                  // Primary Login Action Button
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () => onLoginUser("LOGIN"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(
                          context,
                        ).colorScheme.primaryContainer,
                        foregroundColor: Theme.of(
                          context,
                        ).colorScheme.onPrimaryContainer,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: const Text(
                        "Iniciar sesión",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 50),

                  // Redirection to registration if no account exists
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "¿No tienes una cuenta?",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                      TextButton(
                        onPressed: () => context.push('/register'),
                        child: Text(
                          "Regístrate",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

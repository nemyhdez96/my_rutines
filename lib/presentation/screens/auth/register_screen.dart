import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_routines/presentation/providers/auth_provider_my.dart';
import 'package:my_routines/presentation/widgets/dialog/defauld_dialog.dart';
import 'package:my_routines/presentation/widgets/inputs/custom_dark_text_field.dart';
import 'package:my_routines/presentation/widgets/loading_overlay.dart';
import 'package:my_routines/utils/utils.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late TextEditingController nameController;
  late TextEditingController surnameController;
  late TextEditingController emailController;
  late TextEditingController passwordController;

  String? _nameError;
  String? _surnameError;
  String? _emailError;
  String? _passwordError;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    surnameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    nameController.dispose();
    surnameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void onRegister() {
    setState(() {
      _nameError = null;
      _surnameError = null;
      _emailError = null;
      _passwordError = null;
    });

    bool isValid = true;

    if (nameController.text.trim().isEmpty) {
      setState(() {
        _nameError = "El nombre es obligatorio";
      });
      isValid = false;
    }

    if (surnameController.text.trim().isEmpty) {
      setState(() {
        _surnameError = "Los apellidos son obligatorios";
      });
      isValid = false;
    }

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

    if (isValid) {
      print("Registrar usuario");
    }
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProviderMy>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Theme.of(context).colorScheme.onSurface,
          ),
          onPressed: () => context.pop(),
        ),
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // You can add the logo here if needed, but the design shows just text or logo+text centered
            // For now matching the "My Motines" app bar style if desired, or keeping it clean as per image
            Icon(
              Icons.fitness_center,
              color: Theme.of(context).colorScheme.primary,
            ),
            SizedBox(width: 8),
            Text(
              "My Motines",
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurface,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: LoadingOverlay(
        isLoading: authProvider.isLoading,
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 30),
                // Title
                Center(
                  child: Text(
                    "Crea tu cuenta",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onSurface,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Center(
                  child: Text(
                    "Únete a la comunidad de My Motines",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 14,
                    ),
                  ),
                ),
                const SizedBox(height: 40),

                // Form
                Text(
                  "Nombre",
                  style: TextStyle(
                    color: Theme.of(
                      context,
                    ).colorScheme.onSurface.withValues(alpha: 0.7),
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 8),
                CustomDarkTextField(
                  controller: nameController,
                  hintText: "Juan",
                  icon: Icons.person_outline,
                  errorText: _nameError,
                ),
                const SizedBox(height: 20),

                Text(
                  "Apellidos",
                  style: TextStyle(
                    color: Theme.of(
                      context,
                    ).colorScheme.onSurface.withValues(alpha: 0.7),
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 8),
                CustomDarkTextField(
                  controller: surnameController,
                  hintText: "Pérez",
                  icon: Icons.person_outline,
                  errorText: _surnameError,
                ),
                const SizedBox(height: 20),

                Text(
                  "Correo electrónico",
                  style: TextStyle(
                    color: Theme.of(
                      context,
                    ).colorScheme.onSurface.withValues(alpha: 0.7),
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 8),
                CustomDarkTextField(
                  controller: emailController,
                  hintText: "ejemplo@correo.com",
                  icon: Icons.email_outlined,
                  errorText: _emailError,
                ),
                const SizedBox(height: 20),

                Text(
                  "Contraseña",
                  style: TextStyle(
                    color: Theme.of(
                      context,
                    ).colorScheme.onSurface.withValues(alpha: 0.7),
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 8),
                CustomDarkTextField(
                  controller: passwordController,
                  hintText: "••••••••",
                  icon: Icons.lock_outline,
                  obscureText: true,
                  isPassword: true,
                  errorText: _passwordError,
                ),
                const SizedBox(height: 8),
                Text(
                  "Mínimo 8 caracteres, incluye una letra y un número.",
                  style: TextStyle(
                    color: Theme.of(
                      context,
                    ).colorScheme.onSurface.withValues(alpha: 0.38),
                    fontSize: 12,
                  ),
                ),

                const SizedBox(height: 40),

                // Register Button
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: onRegister,
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
                      "Registrarse",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                // Divider
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
                        "O REGÍSTRATE CON",
                        style: TextStyle(
                          color: Theme.of(
                            context,
                          ).colorScheme.onSurface.withValues(alpha: 0.54),
                          fontSize: 12,
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

                // Google Button
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: OutlinedButton(
                    onPressed: () async {
                      await authProvider.signInWithGoogle();
                      if (!context.mounted) return;

                      if (!authProvider.navegacion(context)) {
                        if (authProvider.responseApiError != null) {
                          errorDialog(
                            context: context,
                            mesaje: authProvider.responseApiError?.mensaje,
                            icon: Icons.error,
                          );
                        }
                      }
                    },
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(
                        color: Theme.of(
                          context,
                        ).colorScheme.onSurface.withValues(alpha: 0.24),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      foregroundColor: Theme.of(context).colorScheme.onSurface,
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
                          "Google",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 40),

                // Login Link
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "¿Ya tienes cuenta?",
                      style: TextStyle(
                        color: Theme.of(
                          context,
                        ).colorScheme.onSurface.withValues(alpha: 0.7),
                      ),
                    ),
                    TextButton(
                      onPressed: () => context.pop(),
                      child: Text(
                        "Inicia sesión",
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
    );
  }
}

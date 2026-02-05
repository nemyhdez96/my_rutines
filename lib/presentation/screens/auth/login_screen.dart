import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_routines/domain/entities/user/login_user.dart';
import 'package:my_routines/presentation/providers/auth_provider_my.dart';
import 'package:my_routines/presentation/widgets/dialog/defauld_dialog.dart';
import 'package:my_routines/presentation/widgets/forms/text_filed_app.dart';
import 'package:my_routines/presentation/widgets/forms/text_filed_password.dart';
import 'package:my_routines/presentation/widgets/loading_overlay.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(Object context) {
    return Scaffold(body: _LoginView());
  }
}

class _LoginView extends StatefulWidget {
  const _LoginView();

  @override
  State<StatefulWidget> createState() => _LoginViestate();
}

class _LoginViestate extends State<_LoginView> {
  late TextEditingController emailController;
  late TextEditingController passwordController;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final authProvider = context.watch<AuthProviderMy>();
    // authProvider.addListener(() {
    //   print("object");

    // });

    void navegacion() {
      if (authProvider.authUser != null) {
        context.go("/home");
      }
      if (authProvider.responseApiError != null) {
        errorDialog(
          context: context,
          mesaje: authProvider.responseApiError?.mensaje,
          icon: Icons.error,
        );
      }
    }

    void loginUser(String action) async {
      final loginUser = LoginUser(
        email: emailController.value.text,
        password: passwordController.value.text,
      );
      await authProvider.loginFirebase(loginUser, action);
      navegacion();
    }

    return LoadingOverlay(
      isLoading: authProvider.isLoading,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.only(right: 20, left: 20),
          child: Form(
            key: Key("f-login"),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Image.asset(
                  "assets/icons/rutina-de-ejercicio.png",
                  width: size.width * 0.7,
                  height: 150,
                  fit: BoxFit.contain,
                ),
                SizedBox(height: size.height * .05),
                TextFiledApp(
                  key: Key("email"),
                  emailController: emailController,
                  hintText: "Ingrese su nombre de usuario o correo",
                  labelText: "Usuario",
                ),
                SizedBox(height: 25),
                TextFiledPassword(
                  key: Key("value"),
                  passwordController: passwordController,
                  hintText: 'Ingrese su contraseña',
                  labelText: 'Contraseña',
                ),
                SizedBox(height: 25),
                SizedBox(
                  width: size.width * 09,
                  child: FilledButton(
                    onPressed: () {
                      loginUser("LOGIN");
                    },
                    child: Text("Iniciar sesión"),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    loginUser("CREATE");
                  },
                  child: Text("Crear cuenta"),
                ),
                TextButton.icon(onPressed: () {}, icon: Icon(Icons.fingerprint), label: Text("Iniciar sesión con huella")),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

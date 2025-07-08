import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_routines/domain/entities/user/loginUser.dart';
import 'package:my_routines/presentation/providers/auth_provider.dart';
import 'package:my_routines/presentation/widgets/Loading_overlay.dart';
import 'package:my_routines/presentation/widgets/dialog/defauld_dialog.dart';
import 'package:my_routines/presentation/widgets/forms/text_filed_app.dart';
import 'package:my_routines/presentation/widgets/forms/text_filed_password.dart';
import 'package:provider/provider.dart';

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
    final authProvider = context.watch<AuthProvider>();
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

    void loginUserw() async {
      final loginUser = Loginuser(
        email: emailController.value.text,
        password: passwordController.value.text,
      );
      await authProvider.loginUser(loginUser);
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
                      loginUserw();
                    },
                    child: Text("Iniciar sesión"),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    //
                    simpleDialog(context);
                  },
                  child: Text("Crear cuenta"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

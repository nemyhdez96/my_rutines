import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_routines/presentation/screens/ejercicios_screen.dart';
import 'package:my_routines/presentation/screens/auth/login_screen.dart';
import 'package:my_routines/presentation/screens/home_screen.dart';
import 'package:my_routines/presentation/screens/rutinas_screen.dart';
import 'package:my_routines/presentation/screens/auth/splash_screen.dart';
import 'package:my_routines/presentation/widgets/home/bottom_navigation_bar_home.dart';
import 'package:my_routines/config/router/utils_router.dart';
import 'package:my_routines/presentation/widgets/home/side_menu.dart';
import 'package:provider/provider.dart';
import 'package:my_routines/presentation/providers/auth_provider_my.dart';
import 'package:my_routines/presentation/screens/auth/register_screen.dart';
import 'package:my_routines/presentation/screens/auth/forgot_password_screen.dart';

final appRouter = GoRouter(
  initialLocation: "/splash",
  routes: [
    GoRoute(path: "/splash", builder: (context, state) => SplashScreen()),
    GoRoute(path: "/login", builder: (context, state) => LoginScreen()),
    GoRoute(path: "/register", builder: (context, state) => RegisterScreen()),
    GoRoute(
      path: "/forgot-password",
      builder: (context, state) => const ForgotPasswordScreen(),
    ),

    ShellRoute(
      builder: (context, state, child) {
        final UtilsRouter utilsRouter = UtilsRouter();
        final location = GoRouterState.of(context).uri.toString();
        final scaffoldKey = GlobalKey<ScaffoldState>();
        final authProvider = context.watch<AuthProviderMy>();
        final current = utilsRouter.getPath(location);
        return Scaffold(
          drawer: SideMenu(scaffoldKey: scaffoldKey),
          appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            title: (location == '/home')
                ? RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: Theme.of(context).textTheme.titleLarge,
                      children: [
                        const TextSpan(text: "Bienvenido,"),
                        TextSpan(
                          text:
                              authProvider.authUser?.usuario.nombre.isEmpty ==
                                  true
                              ? ""
                              : " ${authProvider.authUser?.usuario.nombre} ",
                        ),
                        WidgetSpan(
                          child: Icon(
                            Icons.waving_hand,
                            size: 24,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      ],
                    ),
                  )
                : Text(current.title),
            centerTitle: true,
            // leading: IconButton(
            //     onPressed: () {
            //       if ( !context.canPop() ) return;
            //             context.pop();
            //     },
            //     icon: const Icon(Icons.arrow_back_rounded),
            //   ),
            // actions: [
            //   IconButton(
            //     onPressed: () {},
            //     icon: const Icon(Icons.search_rounded),
            //   ),
            // ],
          ),
          body: child,
          bottomNavigationBar: BottomNavigationBarHome(),
        );
      },
      routes: [
        GoRoute(path: '/home', builder: (context, state) => const HomeScreen()),
        GoRoute(
          path: '/rutinas',
          builder: (context, state) => const RutinasScreen(),
        ),
        GoRoute(
          path: '/ejercicios',
          builder: (context, state) => const EjerciciosScreen(),
        ),
        // Agrega más rutas hijas aquí
      ],
    ),
  ],
);

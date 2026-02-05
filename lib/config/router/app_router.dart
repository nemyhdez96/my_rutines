import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_routines/presentation/screens/auth/auth_gate.dart';
import 'package:my_routines/presentation/screens/ejercicios_screen.dart';
import 'package:my_routines/presentation/screens/auth/login_screen.dart';
import 'package:my_routines/presentation/screens/home_screen.dart';
import 'package:my_routines/presentation/screens/rutinas_screen.dart';
import 'package:my_routines/presentation/screens/auth/splash_screen.dart';
import 'package:my_routines/presentation/widgets/home/bottom_navigation_bar_home.dart';
import 'package:my_routines/config/router/utils_router.dart';
import 'package:my_routines/presentation/widgets/home/side_menu.dart';

final appRouter = GoRouter(
  initialLocation: "/splash",
  routes: [
    GoRoute(path: "/splash", builder: (context, state) => SplashScreen()),
    GoRoute(path: "/login", builder: (context, state) => LoginScreen()),
    GoRoute(path: "/auth_gate", builder: (context, state) => AuthGate()),

    ShellRoute(
      builder: (context, state, child) {
        final UtilsRouter utilsRouter = UtilsRouter();
        final location = GoRouterState.of(context).uri.toString();
        final scaffoldKey = GlobalKey<ScaffoldState>();
        return Scaffold(
          drawer: SideMenu(scaffoldKey: scaffoldKey),
          appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            title: Text(utilsRouter.getPath(location).title),
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

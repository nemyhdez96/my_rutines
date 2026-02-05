import 'package:firebase_core/firebase_core.dart' show Firebase;
import 'package:flutter/material.dart';
import 'package:my_routines/firebase_options.dart';
import 'package:my_routines/infrastructure/datasources/auth/login_datasource_impl.dart';
import 'package:my_routines/presentation/providers/auth_provider_my.dart';
import 'package:provider/provider.dart';
import 'package:my_routines/config/router/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) =>
              AuthProviderMy(loginDatasource: LoginDatasourceImpl()),
        ),
      ],
      child: MaterialApp.router(
        routerConfig: appRouter,
        debugShowCheckedModeBanner: false,
        title: 'My routines',
        theme: ThemeData(
          colorSchemeSeed: Colors.cyanAccent,

          // colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 8, 5, 33)),
          // brightness: Brightness.dark
        ),
        darkTheme: ThemeData(
          colorSchemeSeed: Colors.cyanAccent,
          // colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 8, 5, 33)),
          brightness: Brightness.dark,
        ),
        themeMode: ThemeMode.system,
      ),
    );
  }
}

import 'package:flutter/material.dart';

class AppMaterial extends StatelessWidget {
  final Widget home;
  final String title;
  const AppMaterial({
    super.key, required this.home, required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: title,
    
      theme: ThemeData(
        colorSchemeSeed: Colors.cyanAccent,
      ),
      darkTheme: ThemeData(
        colorSchemeSeed: Colors.cyanAccent,
        brightness: Brightness.dark,
      ),
      themeMode: ThemeMode.system,
      home: home,
    );
  }
}
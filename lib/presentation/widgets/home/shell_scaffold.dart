import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_routines/presentation/widgets/home/bottom_navigation_bar_home.dart';

class ShellScaffold extends StatelessWidget {
  final Widget child;

  const ShellScaffold({required this.child, super.key});

  String _getTitle(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();
    if (location.startsWith('/home')) return "Inicio";
    if (location.startsWith('/rutinas')) return "Rutinas";
    if (location.startsWith('/cuenta')) return "Cuenta";
    return "Mi App";
  }

  List<Widget> _getActions(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();

    if (location.startsWith('/rutinas')) {
      return [
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: () {
            // Acción para rutinas
          },
        ),
      ];
    }

    if (location.startsWith('/cuenta')) {
      return [
        IconButton(
          icon: const Icon(Icons.settings),
          onPressed: () {
            // Acción para cuenta
          },
        ),
      ];
    }

    // Por defecto sin botones
    return [];
  }

  @override
  Widget build(BuildContext context) {
    final title = _getTitle(context);
    final actions = _getActions(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: actions,
      ),
      bottomNavigationBar: const BottomNavigationBarHome(),
      body: child,
    );
  }
}

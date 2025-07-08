import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_routines/config/router/utils_router.dart';

class BottomNavigationBarHome extends StatefulWidget {
  const BottomNavigationBarHome({super.key});

  @override
  State<StatefulWidget> createState() => _BottomNavigationBarHomeState();
}

class _BottomNavigationBarHomeState extends State<BottomNavigationBarHome> {
 final UtilsRouter utilsRouter =UtilsRouter(); 

  void _onTabIndex(index) {
    final String path = utilsRouter.getIndex(index).path;
    context.go(path);
  }

  int _getCurrentIndex(){
    final currentPath = GoRouterState.of(context).uri.toString();
    return utilsRouter.getPath(currentPath).index;
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Theme.of(context).colorScheme.onPrimary,
      onTap: _onTabIndex,
      currentIndex: _getCurrentIndex(),
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Inicio"),
        BottomNavigationBarItem(
          icon: Icon(Icons.rocket),
          label: "Rutinas",
          activeIcon: ButtonTheme(child: Icon(Icons.rocket)),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.supervised_user_circle),
          label: "Ejercicios",
          activeIcon: ButtonTheme(child: Icon(Icons.supervised_user_circle)),
        ),
      ],
    );
  }
}

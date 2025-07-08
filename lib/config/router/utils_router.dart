import 'package:my_routines/domain/entities/router_app_entities.dart';

class UtilsRouter {
  final List<RouterAppEntities> _routerappEntitiesList = [
    RouterAppEntities(path: "/home", title: "Inicio", index: 0),
    RouterAppEntities(path: "/rutinas", title: "Rutinas", index: 1),
    RouterAppEntities(path: "/ejercicios", title: "Ejercicios", index: 2),
  ];

  RouterAppEntities getIndex(int index) {
    return _routerappEntitiesList.firstWhere(
      (e) => e.index == index,
      orElse: () => _routerappEntitiesList[0],
    );
  }

   RouterAppEntities getPath(String path) {
    return _routerappEntitiesList.firstWhere(
      (e) => e.path == path,
      orElse: () => _routerappEntitiesList[0],
    );
  }
}

//final location = GoRouterState.of(context).uri.toString();
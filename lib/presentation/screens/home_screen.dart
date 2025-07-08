import 'package:flutter/material.dart';
import 'package:my_routines/presentation/providers/auth_provider.dart';
import 'package:my_routines/presentation/widgets/app_material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final String title = "Home";
    return AppMaterial(
      home: HomeScreenPage(title: title),
      title: title,
    );
  }
}

class HomeScreenPage extends StatefulWidget {
  final String title;
  const HomeScreenPage({super.key, required this.title});

  @override
  State<HomeScreenPage> createState() => HomeScreenPageState();
}

class HomeScreenPageState extends State<HomeScreenPage> {
  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Theme.of(context).colorScheme.inversePrimary,

      //   title: Text(widget.title),
      // ),
      floatingActionButton: FloatingActionButton.extended(
        label: const Text("Iniciar entrenaminento"),
        icon: Icon(Icons.add),
        onPressed: () {},
      ),
      // bottomNavigationBar: BottomNavigationBarHome(),
      body: Center(
        child: Column(
          children: [
            Text(authProvider.authUser!.usuario.nombre),
            Text(authProvider.authUser!.usuario.email),
          ],
        ),
      ),
    );
  }
}

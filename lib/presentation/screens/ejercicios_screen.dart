import 'package:flutter/material.dart';
import 'package:my_routines/presentation/widgets/app_material.dart';
import 'package:my_routines/presentation/widgets/home/bottom_navigation_bar_home.dart';

class EjerciciosScreen extends StatelessWidget {
  const EjerciciosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final String title = "Ejercicios";
    return AppMaterial(
      home: _EjerciciosScreenPage(title: title),
      title: title,
    );
  }
}

class _EjerciciosScreenPage extends StatefulWidget {
  final String title;

  const _EjerciciosScreenPage({super.key, required this.title});
  @override
  State<StatefulWidget> createState() => _EjerciciosScreenPageState();
}

class _EjerciciosScreenPageState extends State<_EjerciciosScreenPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
      body: Container(
        margin: EdgeInsetsGeometry.all(5),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: 50,
                itemBuilder: (context, index) {
                  return Row(
                    children: [
                      Text("hola $index"),
                      TextButton(
                        onPressed: () {},
                        child: Icon(Icons.add_box_rounded),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

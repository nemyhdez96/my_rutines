import 'package:flutter/material.dart';
import 'package:my_routines/presentation/widgets/app_material.dart';
import 'package:my_routines/presentation/widgets/my_card.dart';

class RutinasScreen extends StatelessWidget {
  const RutinasScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final String title = "Rutinas";
    return AppMaterial(
      home: _RutinasScreenPage(title: title),
      title: title,
    );
  }
}

class _RutinasScreenPage extends StatefulWidget {
  final String title;

  const _RutinasScreenPage({required this.title});
  @override
  State<StatefulWidget> createState() => _RutinasScreenPageState();
}

class _RutinasScreenPageState extends State<_RutinasScreenPage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

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
                  return MyCard(
                    child: Row(
                      children: [
                        Image.asset(
                          "assets/icons/rutina-de-ejercicio.png",
                          width: size.width * 0.2,
                          height: 150,
                          fit: BoxFit.contain,
                        ),
                        SizedBox(width: 25),
                        Text("holaaa $index"),
                        SizedBox(
                          width: 50,
                          child: TextButton(
                            onPressed: () {},
                            child: Icon(Icons.add_box_rounded),
                          ),
                        ),
                      ],
                    ),
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

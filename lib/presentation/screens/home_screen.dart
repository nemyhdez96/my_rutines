import 'package:flutter/material.dart';
import 'package:my_routines/presentation/widgets/app_material.dart';
import 'package:my_routines/presentation/widgets/my_card.dart';

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
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MyCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Rutina de hoy',
                      style: Theme.of(context).textTheme.headlineMedium
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Miercoles - piernas y glúteos ❤️❤️ ',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    Center(
                      child: TextButton(
                        onPressed: () {},
                        child: Text(
                          "Ver rutina",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              MyCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Rutina de hoy',
                      style: Theme.of(context).textTheme.headlineMedium
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Miercoles - piernas y glúteos ❤️❤️ ',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    Center(
                      child: TextButton(
                        onPressed: () {},
                        child: Text(
                          "Ver rutina",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              MyCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Rutina de hoy',
                      style: Theme.of(context).textTheme.headlineMedium
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Miercoles - piernas y glúteos ❤️❤️ ',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    Center(
                      child: TextButton(
                        onPressed: () {},
                        child: Text(
                          "Ver rutina",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              MyCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Rutina de hoy',
                      style: Theme.of(context).textTheme.headlineMedium
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Miercoles - piernas y glúteos ❤️❤️ ',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    Center(
                      child: TextButton(
                        onPressed: () {},
                        child: Text(
                          "Ver rutina",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              MyCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Rutina de hoy',
                      style: Theme.of(context).textTheme.headlineMedium
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Miercoles - piernas y glúteos ❤️❤️ ',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    Center(
                      child: TextButton(
                        onPressed: () {},
                        child: Text(
                          "Ver rutina",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

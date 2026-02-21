import 'package:flutter/material.dart';

class MyCard extends StatelessWidget {
  final Widget? child;
  const MyCard({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: child ?? Container(),
        ),
      ),
    );
  }
}

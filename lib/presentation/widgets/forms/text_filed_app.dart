import 'package:flutter/material.dart';

class TextFiledApp extends StatefulWidget {
  final TextEditingController emailController;
  final String hintText;
  final String labelText;

  const TextFiledApp({
    required super.key,
    required this.emailController,
    required this.hintText,
    required this.labelText,
  });

  @override
  State<TextFiledApp> createState() => _TextFiledAppState();
}

class _TextFiledAppState extends State<TextFiledApp> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      key: widget.key,
      controller: widget.emailController,
      decoration: InputDecoration(
        labelText: widget.labelText,
        border: OutlineInputBorder(),
        hintText: widget.hintText,
      ),
      keyboardType: TextInputType.emailAddress,
    );
  }
}

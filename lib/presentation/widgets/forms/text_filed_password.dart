import 'package:flutter/material.dart';

class TextFiledPassword extends StatefulWidget {
  final TextEditingController passwordController;
  final String hintText;
  final String labelText;

  const TextFiledPassword({
    required super.key,
    required this.passwordController,
    required this.hintText,
    required this.labelText,
  });

  @override
  State<TextFiledPassword> createState() => _TextFiledPasswordState();
}

class _TextFiledPasswordState extends State<TextFiledPassword> {
  bool _passwodVisible = false;

  @override
  Widget build(BuildContext context) {
    return TextField(
      key: widget.key,
      controller: widget.passwordController,
      obscureText: !_passwodVisible,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: widget.hintText,
        labelText: widget.labelText,
        suffixIcon: IconButton(
          onPressed: () {
            setState(() {
              _passwodVisible = !_passwodVisible;
            });
          },
          icon: Icon(_passwodVisible ? Icons.visibility : Icons.visibility_off),
        ),
      ),
    );
  }
}

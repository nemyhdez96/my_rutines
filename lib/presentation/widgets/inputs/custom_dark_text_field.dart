import 'package:flutter/material.dart';

class CustomDarkTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final String? labelText;
  final IconData icon;
  final bool obscureText;
  final bool isPassword;
  final String? errorText;

  const CustomDarkTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.icon,
    this.labelText,
    this.obscureText = false,
    this.isPassword = false,
    this.errorText,
  });

  @override
  State<CustomDarkTextField> createState() => _CustomDarkTextFieldState();
}

class _CustomDarkTextFieldState extends State<CustomDarkTextField> {
  late bool _isVisible;

  @override
  void initState() {
    super.initState();
    _isVisible = !widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.labelText != null) ...[
          Text(
            widget.labelText!,
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurface,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
        ],
        TextField(
          controller: widget.controller,
          obscureText: widget.isPassword ? !_isVisible : false,
          style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
          decoration: InputDecoration(
            filled: true,
            fillColor: Theme.of(context).colorScheme.surfaceContainerHighest,
            prefixIcon: Icon(
              widget.icon,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
            hintText: widget.hintText,
            hintStyle: TextStyle(
              color: Theme.of(
                context,
              ).colorScheme.onSurfaceVariant.withValues(alpha: 0.7),
            ),
            errorText: widget.errorText,
            errorMaxLines: 3,
            contentPadding: const EdgeInsets.symmetric(vertical: 16),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide.none,
            ),
            suffixIcon: widget.isPassword
                ? IconButton(
                    icon: Icon(
                      _isVisible ? Icons.visibility : Icons.visibility_off,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                    onPressed: () {
                      setState(() {
                        _isVisible = !_isVisible;
                      });
                    },
                  )
                : null,
          ),
        ),
      ],
    );
  }
}

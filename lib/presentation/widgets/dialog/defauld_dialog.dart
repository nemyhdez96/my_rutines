import 'package:flutter/material.dart';

void errorDialog({
  required BuildContext context,
  String? title,
  String? mesaje,
  IconData? icon,
}) {
  final theme = Theme.of(context);
  showDialog(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      icon: Icon(icon),
      iconColor: theme.colorScheme.error,
      title: title != null ? Center(child: Text(title)) : null,
      content: mesaje != null ? Text(mesaje) : null,
      actions: [
        Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                style: ButtonStyle(
                  foregroundColor: WidgetStatePropertyAll(theme.colorScheme.error),
                  overlayColor: WidgetStatePropertyAll(
                    theme.colorScheme.errorContainer,
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("Ok"),
              )
            ],
          ),
        ),
      ],
    ),
  );
}

void simpleDialog(BuildContext context) {
  showDialog<String>(
    context: context,
    builder: (BuildContext context) => Dialog(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('This is a typical dialog.'),
            const SizedBox(height: 15),
            FilledButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Close'),
            ),
          ],
        ),
      ),
    ),
  );
}

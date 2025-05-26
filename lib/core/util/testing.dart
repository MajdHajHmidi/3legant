import 'package:flutter/material.dart';

void showNotImplementedDialog(BuildContext context) {
  showDialog(
    context: context,
    builder:
        (context) => AlertDialog(
          title: Text('Coming soon'),
          content: Text('This feature is still in development'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        ),
  );
}

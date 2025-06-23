import 'package:flutter/material.dart';

void showErrorSnackBar(
  BuildContext context,
  String message, {
  Duration duration = const Duration(seconds: 4),
}) {
  final theme = Theme.of(context);

  // Hide any previous snackbars
  ScaffoldMessenger.of(context).clearSnackBars();

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      behavior: SnackBarBehavior.floating,
      backgroundColor: theme.colorScheme.error,
      content: Row(
        spacing: 12,
        children: [
          Icon(Icons.error_outline, color: theme.colorScheme.onError),
          Expanded(
            child: Text(
              message,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onError,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

void showSuccessSnackBar(
  BuildContext context,
  String message, {
  Duration duration = const Duration(seconds: 4),
}) {
  final theme = Theme.of(context);

  // Hide any previous snackbars
  ScaffoldMessenger.of(context).clearSnackBars();

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      behavior: SnackBarBehavior.floating,
      backgroundColor: theme.colorScheme.primary,
      duration: duration,
      content: Row(
        children: [
          Icon(Icons.check_circle_outline, color: theme.colorScheme.onPrimary),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              message,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onPrimary,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

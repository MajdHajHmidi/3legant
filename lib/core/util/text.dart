import 'package:flutter/material.dart';

Size calculateTextSize({
  required BuildContext context,
  required String text,
  required TextStyle style,
  required double maxWidth,
  int maxLines = 1,
  bool noScaling = false,
}) {
  final textPainter = TextPainter(
    text: TextSpan(text: text, style: style),
    textDirection: Directionality.of(context),
    textScaler:
        noScaling ? TextScaler.linear(1) : MediaQuery.of(context).textScaler,
    maxLines: maxLines,
  )..layout(maxWidth: maxWidth);

  return textPainter.size;
}

double calculateMaxTextHeight({
  required BuildContext context,
  required List<String> texts,
  required TextStyle style,
  required double maxWidth,
  int maxLines = 1,
  bool noScaling = false,
}) {
  if (texts.isEmpty) return 0.0;

  double maxHeight = 0;

  for (final text in texts) {
    final height =
        calculateTextSize(
          context: context,
          text: text,
          style: style,
          maxWidth: maxWidth,
          maxLines: maxLines,
          noScaling: noScaling,
        ).height;

    if (height > maxHeight) {
      maxHeight = height;
    }
  }

  return maxHeight;
}

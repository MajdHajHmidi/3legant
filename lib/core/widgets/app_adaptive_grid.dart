import '../util/text.dart';
import 'package:flutter/material.dart';

class AppAdaptiveSliverGrid extends StatelessWidget {
  final Widget Function(BuildContext context, int index) itembuilder;
  final int itemCount;
  final double minimumTileWidth;
  final double mainAxisSpacing;
  final double crossAxisSpacing;

  /// Height of grid children excluding text widgets (Text widgets
  /// scale differently across decives)
  final double staticChildHeight;

  /// Simulations of text widgets inside grid children that adapt to
  /// device scaling factor or don't have a fixed height
  final List<TextPlaceholderParams>? textPlaceholders;
  const AppAdaptiveSliverGrid({
    super.key,
    required this.itemCount,
    required this.minimumTileWidth,
    required this.mainAxisSpacing,
    required this.crossAxisSpacing,
    required this.staticChildHeight,
    required this.itembuilder,
    this.textPlaceholders,
  });

  @override
  Widget build(BuildContext context) {
    return SliverLayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.crossAxisExtent;
        final crossAxisCount = (width / minimumTileWidth).floor().clamp(1, 3);
        return SliverGrid(
          delegate: SliverChildBuilderDelegate(itembuilder, childCount: itemCount),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            mainAxisSpacing: mainAxisSpacing,
            crossAxisSpacing: crossAxisSpacing,
            crossAxisCount: crossAxisCount,
            mainAxisExtent: _calculateBlogsGridTileHeight(
              context: context,
              width: width,
              minimumTileWidth: minimumTileWidth,
              crossAxisCount: crossAxisCount,
              crossAxisSpacing: crossAxisSpacing,
              staticTileHeight: staticChildHeight,
              textPlaceholders: textPlaceholders,
            ),
          ),
        );
      },
    );
  }
}

double _calculateBlogsGridTileHeight({
  required BuildContext context,
  required double width, // Width of the entire grid view
  required int crossAxisCount,
  required double crossAxisSpacing,
  required double minimumTileWidth,
  required double staticTileHeight,
  List<TextPlaceholderParams>? textPlaceholders,
}) {
  if (textPlaceholders == null) {
    return staticTileHeight;
  }

  final tileWidth =
      (width - (crossAxisSpacing * (crossAxisCount - 1))) / crossAxisCount;

  double additionalHeight = 0;

  for (final textPlaceholder in textPlaceholders) {
    if (textPlaceholder.text != null) {
      additionalHeight +=
          calculateTextSize(
            context: textPlaceholder.context,
            text: textPlaceholder.text!,
            style: textPlaceholder.style,
            maxWidth:
                textPlaceholder.maxWidth ??
                (tileWidth - textPlaceholder.horizontalPadding),
            maxLines: textPlaceholder.maxLines,
            noScaling: textPlaceholder.noScaling,
          ).height;
    } else {
      additionalHeight += calculateMaxTextHeight(
        context: textPlaceholder.context,
        texts: textPlaceholder.texts!,
        style: textPlaceholder.style,
        maxWidth:
            textPlaceholder.maxWidth ??
            (tileWidth - textPlaceholder.horizontalPadding),
        maxLines: textPlaceholder.maxLines,
        noScaling: textPlaceholder.noScaling,
      );
    }
  }

  return staticTileHeight + additionalHeight;
}

class TextPlaceholderParams {
  final BuildContext context;

  /// Same text length across all grid children (Blog date)
  String? text;

  /// Different grid children may hold text that differs in length (Blog name)
  /// if `text` is not null, `texts` is ignored
  final List<String>? texts;

  /// The empty space between the grid child border and the start (or end) of
  /// the text widget
  final double horizontalPadding;
  final TextStyle style;
  final double? maxWidth;
  final int maxLines;
  final bool noScaling;

  TextPlaceholderParams({
    required this.context,
    this.text,
    this.texts,
    this.maxWidth,
    this.horizontalPadding = 0,
    required this.style,

    this.maxLines = 1,
    this.noScaling = false,
  }) {
    if ((text == null && texts == null) || (text != null && texts != null)) {
      throw Exception('Can\'t provide both `text` and `texts simultaneously`');
    }
  }
}

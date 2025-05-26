import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class AppNetworkImage extends StatefulWidget {
  final String imageUrl;
  final double? width;
  final double? height;
  final BoxFit fit;
  final BorderRadius? borderRadius;
  final bool _shimmer;
  final Alignment alignment;

  const AppNetworkImage({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.borderRadius,
    this.alignment = Alignment.center,
  }) : _shimmer = true;

  const AppNetworkImage.noShimmer({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.borderRadius,
    this.alignment = Alignment.center,
  }) : _shimmer = false;

  @override
  State<AppNetworkImage> createState() => _AppNetworkImageState();
}

class _AppNetworkImageState extends State<AppNetworkImage> {
  Key imageKey = UniqueKey();

  void reloadImage() {
    setState(() {
      imageKey = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    final placeholder = Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        width: widget.width,
        height: widget.height,
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: widget.borderRadius,
        ),
      ),
    );

    return ClipRRect(
      borderRadius: widget.borderRadius ?? BorderRadius.zero,
      child: CachedNetworkImage(
        key: imageKey,
        imageUrl: widget.imageUrl,
        width: widget.width,
        height: widget.height,
        alignment: widget.alignment,
        fit: widget.fit,
        placeholder: widget._shimmer ? ((context, url) => placeholder) : null,
        errorWidget:
            (context, url, error) => InkWell(
              borderRadius: widget.borderRadius,
              onTap: () {
                // Force reload (rebuilding CachedNetworkImage reloads it)
                reloadImage();
              },
              child: Ink(
                width: widget.width,
                height: widget.height,
                decoration: BoxDecoration(
                  borderRadius: widget.borderRadius,
                  color: Colors.grey.shade200,
                ),
                child: const Icon(Icons.refresh, color: Colors.grey),
              ),
            ),
      ),
    );
  }
}

class AppAssetImage extends StatelessWidget {
  const AppAssetImage({
    super.key,
    required this.assetPath,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.alignment = Alignment.center,
    this.borderRadius,
    this.clipBehavior = Clip.hardEdge,
  });

  final String assetPath;
  final double? width;
  final double? height;
  final BoxFit fit;
  final AlignmentGeometry alignment;
  final BorderRadius? borderRadius;
  final Clip clipBehavior;

  @override
  Widget build(BuildContext context) {
    final image = Image.asset(
      assetPath,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
    );

    if (borderRadius != null) {
      return ClipRRect(
        borderRadius: borderRadius ?? BorderRadius.zero,
        clipBehavior: clipBehavior,
        child: image,
      );
    }

    return image;
  }
}

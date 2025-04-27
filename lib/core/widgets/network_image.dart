import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class AppNetworkImage extends StatefulWidget {
  final String imageUrl;
  final double? width;
  final double? height;
  final BoxFit fit;
  final BorderRadius? borderRadius;

  const AppNetworkImage({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.borderRadius,
  });

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
        fit: widget.fit,
        placeholder: (context, url) => placeholder,
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

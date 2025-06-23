import 'package:flutter/material.dart';

import '../../../core/widgets/app_gallery_widget.dart';
import '../../../core/widgets/app_image.dart';

class HomeImageCarousel extends StatelessWidget {
  final List<String> images;
  const HomeImageCarousel({super.key, required this.images});

  @override
  Widget build(BuildContext context) {
    return AppGalleryWidget(
      itemCount: images.length,
      height: 300,
      borderRadius: BorderRadius.circular(12),
      itemBuilder:
          (index) => AppNetworkImage(
            imageUrl: images[index],
            fit: BoxFit.cover,
            alignment: Alignment(Alignment.center.x, Alignment.center.y + 0.2),
            width: double.infinity,
          ),
    );
  }
}

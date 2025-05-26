import 'dart:async';

import '../../../core/styles/colors.dart';
import '../../../core/util/duration_extension.dart';
import '../../../core/widgets/app_image.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomeImageCarousel extends StatefulWidget {
  final List<String> images;
  const HomeImageCarousel({super.key, required this.images});

  @override
  State<HomeImageCarousel> createState() => _HomeImageCarouselState();
}

class _HomeImageCarouselState extends State<HomeImageCarousel> {
  final pageController = PageController();
  late Timer timer;

  @override
  void initState() {
    timer = Timer.periodic(3.s, (timer) {
      final currentPage = pageController.page!.toInt();
      pageController.animateToPage(
        currentPage == widget.images.length - 1 ? 0 : currentPage + 1,
        duration: 500.ms,
        curve: Curves.fastOutSlowIn,
      );
    });

    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    timer.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {});

    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: SizedBox(
        height: 300,
        child: Stack(
          children: [
            PageView(
              controller: pageController,
              children:
                  widget.images
                      .map(
                        (image) => AppNetworkImage(
                          imageUrl: image,
                          height: 300,
                          fit: BoxFit.cover,
                          alignment: Alignment(
                            Alignment.center.x,
                            Alignment.center.y + 0.2,
                          ),
                          width: double.infinity,
                        ),
                      )
                      .toList(),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: IgnorePointer(
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.black.withAlpha(150),
                        Colors.black.withAlpha(50),
                        Colors.transparent,
                      ],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 16,
              left: 0,
              right: 0,
              child: IgnorePointer(
                child: SizedBox(
                  child: Center(
                    child: SmoothPageIndicator(
                      controller: pageController,
                      count: widget.images.length,
                      effect: ExpandingDotsEffect(
                        dotWidth: 8,
                        dotHeight: 8,
                        dotColor: AppColors.neutral_01.withAlpha(200),
                        activeDotColor: AppColors.neutral_01,
                        spacing: 12,
                        expansionFactor: 4,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

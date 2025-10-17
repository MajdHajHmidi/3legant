import 'package:e_commerce/core/util/periodic_timer.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../core/styles/colors.dart';
import '../../../core/util/duration_extension.dart';

class AppGalleryWidget extends StatefulWidget {
  final int itemCount;
  final Widget Function(int index) itemBuilder;
  final double? height;
  final BorderRadiusGeometry? borderRadius;
  const AppGalleryWidget({
    super.key,
    required this.itemCount,
    required this.itemBuilder,
    this.height,
    this.borderRadius,
  });

  @override
  State<AppGalleryWidget> createState() => _HomeImageCarouselState();
}

class _HomeImageCarouselState extends State<AppGalleryWidget> {
  final pageController = PageController();
  late PeriodicTimer timer;

  @override
  void initState() {
    timer = PeriodicTimer(
      duration: 3.s,
      onTick: () {
        final currentPage = pageController.page!.toInt();
        pageController.animateToPage(
          currentPage == widget.itemCount - 1 ? 0 : currentPage + 1,
          duration: 500.ms,
          curve: Curves.fastOutSlowIn,
        );
      },
    );
    timer.start();

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
    return Listener(
      onPointerDown: (_) => timer.pause(),
      onPointerUp: (_) => timer.resume(),
      onPointerCancel: (_) => timer.resume(),
      child: ClipRRect(
        borderRadius: widget.borderRadius ?? BorderRadius.zero,
        child: SizedBox(
          height: widget.height,
          child: Stack(
            children: [
              PageView(
                controller: pageController,
                children:
                    List.generate(
                      widget.itemCount,
                      (index) => widget.itemBuilder(index),
                    ).toList(),
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
                        count: widget.itemCount,
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
      ),
    );
  }
}

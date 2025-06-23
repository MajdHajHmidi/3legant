import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class SliverIndent extends StatelessWidget {
  final double? height;
  final double? width;
  const SliverIndent({super.key, this.height, this.width});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(child: SizedBox(height: height, width: width));
  }
}

/// A widget that animates the size of a sliver child.
///
/// This widget can be used to create an expand/collapse animation for a sliver.
/// It works by wrapping the sliver content and animating its layout and paint extent
/// based on the [isExpanded] flag.
class SliverExpandable extends StatefulWidget {
  /// The sliver child to animate.
  final Widget sliver;

  /// The duration of the animation.
  final Duration duration;

  /// The curve of the animation.
  final Curve curve;

  /// A flag to control the expanded/collapsed state.
  final bool isExpanded;

  const SliverExpandable({
    super.key,
    required this.sliver,
    required this.duration,
    required this.curve,
    required this.isExpanded,
  });

  @override
  State<SliverExpandable> createState() => _SliverExpandableState();
}

class _SliverExpandableState extends State<SliverExpandable>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);
    _animation = CurvedAnimation(parent: _controller, curve: widget.curve);

    // Set the initial state of the controller based on the `isExpanded` flag.
    if (widget.isExpanded) {
      _controller.value = 1.0;
    }
  }

  @override
  void didUpdateWidget(SliverExpandable oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Trigger the animation when the `isExpanded` flag changes.
    if (widget.isExpanded != oldWidget.isExpanded) {
      if (widget.isExpanded) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return _SliverAnimatedSize(
          progress: _animation.value,
          child: widget.sliver,
        );
      },
    );
  }
}

/// A private helper widget that uses a custom RenderSliver to perform the animation.
class _SliverAnimatedSize extends SingleChildRenderObjectWidget {
  /// The animation progress, from 0.0 (collapsed) to 1.0 (expanded).
  final double progress;

  const _SliverAnimatedSize({required Widget child, required this.progress})
    : super(child: child);

  @override
  RenderObject createRenderObject(BuildContext context) {
    return _RenderSliverAnimatedSize(progress: progress);
  }

  @override
  void updateRenderObject(
    BuildContext context,
    covariant _RenderSliverAnimatedSize renderObject,
  ) {
    renderObject.progress = progress;
  }
}

/// The custom RenderSliver that animates its geometry.
class _RenderSliverAnimatedSize extends RenderSliver
    with RenderObjectWithChildMixin<RenderSliver> {
  double _progress;

  _RenderSliverAnimatedSize({required double progress}) : _progress = progress;

  /// Gets and sets the animation progress, marking the render object for layout when it changes.
  double get progress => _progress;
  set progress(double value) {
    if (_progress == value) return;
    _progress = value;
    markNeedsLayout();
  }

  @override
  void performLayout() {
    // If we are fully collapsed or have no child, our geometry is zero.
    // This avoids laying out the child unnecessarily.
    if (child == null || _progress == 0.0) {
      geometry = SliverGeometry.zero;
      return;
    }

    // Layout the child to determine its full potential size.
    child!.layout(constraints, parentUsesSize: true);
    final childGeometry = child!.geometry!;

    // Animate all relevant extents of the sliver's geometry based on the
    // animation progress. This gives the parent ScrollView a consistent
    // picture of our size as we animate.
    geometry = childGeometry.copyWith(
      scrollExtent: childGeometry.scrollExtent * progress,
      paintExtent: childGeometry.paintExtent * progress,
      layoutExtent: childGeometry.layoutExtent * progress,
      maxPaintExtent: childGeometry.maxPaintExtent * progress,
      hitTestExtent: childGeometry.hitTestExtent * progress,
      cacheExtent: childGeometry.cacheExtent * progress,
    );
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    // Only paint the child if it's visible.
    if (child != null && geometry!.visible) {
      // Clip the painting of the child to the animated bounds.
      context.clipRectAndPaint(
        Rect.fromLTWH(
          offset.dx,
          offset.dy,
          constraints.crossAxisExtent,
          geometry!.paintExtent,
        ),
        Clip.hardEdge,
        Rect.zero, // The painting is already at the correct offset
        () {
          context.paintChild(child!, offset);
        },
      );
    }
  }

  @override
  bool hitTestChildren(
    SliverHitTestResult result, {
    required double mainAxisPosition,
    required double crossAxisPosition,
  }) {
    // Allow hit testing only on the visible part of the child.
    if (child != null &&
        geometry!.hitTestExtent > 0.0 &&
        mainAxisPosition < geometry!.hitTestExtent) {
      return child!.hitTest(
        result,
        mainAxisPosition: mainAxisPosition,
        crossAxisPosition: crossAxisPosition,
      );
    }
    return false;
  }

  // The paint transform is the identity because we are not moving the child, just clipping it.
  @override
  void applyPaintTransform(RenderObject child, Matrix4 transform) {}
}

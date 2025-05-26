import '../styles/colors.dart';
import '../util/duration_extension.dart';
import 'package:flutter/material.dart';

class AppCircularProgressIndicator extends StatefulWidget {
  final Color color;
  const AppCircularProgressIndicator({
    super.key,
    this.color = AppColors.primary,
  });

  @override
  State<AppCircularProgressIndicator> createState() =>
      _AppCircularProgressIndicatorState();
}

class _AppCircularProgressIndicatorState
    extends State<AppCircularProgressIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(vsync: this, duration: 1000.ms)
      ..repeat();

    _rotationAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(_animationController);

    // _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 15,
      width: 15,
      child: RotationTransition(
        turns: _rotationAnimation,
        child: CircularProgressIndicator(
          strokeCap: StrokeCap.round,
          strokeWidth: 2.5,
          value: 0.8,
          color: widget.color,
        ),
      ),
    );
  }
}

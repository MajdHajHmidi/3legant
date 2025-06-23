import 'package:e_commerce/core/widgets/app_circular_progress_indicator.dart';
import 'package:flutter/material.dart';

class ProductDetailsLoadingView extends StatelessWidget {
  const ProductDetailsLoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: const AppCircularProgressIndicator());
  }
}

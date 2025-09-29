import 'package:e_commerce/core/widgets/app_circular_progress_indicator.dart';
import 'package:flutter/material.dart';

class CartScreenLoadingView extends StatelessWidget {
  const CartScreenLoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: AppCircularProgressIndicator());
  }
}

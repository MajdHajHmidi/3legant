import 'package:e_commerce/core/styles/text_styles.dart';
import 'package:flutter/material.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('Cart screen', style: AppTextStyles.hero)),
    );
  }
}

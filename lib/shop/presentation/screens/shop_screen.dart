import 'package:e_commerce/core/styles/text_styles.dart';
import 'package:flutter/material.dart';

class ShopScreen extends StatelessWidget {
  const ShopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('Shop Screen', style: AppTextStyles.hero)),
    );
  }
}

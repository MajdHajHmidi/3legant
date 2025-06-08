import 'package:e_commerce/core/util/localization.dart';
import 'package:e_commerce/core/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';

class BlogsAppbar extends StatelessWidget {
  const BlogsAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomAppBar(text: localization(context).blogs);
  }
}

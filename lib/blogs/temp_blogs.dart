import 'package:e_commerce/core/styles/text_styles.dart';
import 'package:e_commerce/core/widgets/app_circular_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class BlogsScreen extends StatelessWidget {
  const BlogsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Blogs')),
      body: FutureBuilder(
        future: Supabase.instance.client.rpc(
          'get_blogs',
          params: {'page': 3},
          get: true,
        ),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: AppCircularProgressIndicator());
          }

          final blogs = snapshot.data!['blogs'] as List<dynamic>;
          return ListView.builder(
            itemCount: blogs.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(
                  blogs[index]['title'],
                  style: AppTextStyles.headline4,
                ),
                tileColor: index % 2 == 0 ? Colors.grey[300] : Colors.grey[100],
              );
            },
          );
        },
      ),
    );
  }
}

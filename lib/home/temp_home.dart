import 'package:e_commerce/core/navigation/router.dart';
import 'package:e_commerce/core/styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home')),
      body: CustomScrollView(
        slivers: [
          FutureBuilder(
            future: Supabase.instance.client.rpc(
              'get_blogs',
              params: {'page': 1},
              get: true,
            ),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return SliverToBoxAdapter(
                  child: Center(child: CircularProgressIndicator()),
                );
              }

              final blogs = snapshot.data!['blogs'] as List<dynamic>;
              return SliverList.builder(
                itemCount: blogs.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                      blogs[index]['title'],
                      style: AppTextStyles.headline4,
                    ),
                    tileColor:
                        index % 2 == 0 ? Colors.grey[300] : Colors.grey[100],
                  );
                },
              );
            },
          ),

          SliverToBoxAdapter(
            child: ElevatedButton(
              onPressed: () => context.pushNamed(AppRoutes.blogs.name),
              child: Text('See Other Blogs'),
            ),
          ),
        ],
      ),
    );
  }
}

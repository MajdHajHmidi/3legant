import 'package:e_commerce/core/styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Profile')),
      body: FutureBuilder(
        future: Supabase.instance.client.rpc(
          'get_products',
          params: {'page': 1},
          get: true,
        ),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          final blogs = snapshot.data!['products'] as List<dynamic>;
          return ListView.builder(
            itemCount: blogs.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(
                  blogs[index]['name'],
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

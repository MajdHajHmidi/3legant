import 'package:e_commerce/auth/data/auth_repo.dart';
import 'package:e_commerce/core/styles/text_styles.dart';
import 'package:e_commerce/core/widgets/app_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  Future<void> _signOut(BuildContext context) async {
    await SupabaseAuthRepo().signOut();
    context.go('/login'); // Redirect to login screen
  }

  @override
  Widget build(BuildContext context) {
    final user = Supabase.instance.client.auth.currentSession?.user;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          IconButton(
            onPressed: () => _signOut(context),
            icon: const Icon(Icons.logout),
            tooltip: 'Sign Out',
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            AppNetworkImage(
              imageUrl:
                  'https://yzvjrxpwozrcbfdtqkbi.supabase.co/storage/v1/object/public/blogs//section11.3.jpeg',
              borderRadius: BorderRadius.circular(12),
              fit: BoxFit.cover,
              height: 150,
              width: double.infinity,
            ),
            const SizedBox(height: 24),
            Text(
              user == null
                  ? 'Not signed in'
                  : user.userMetadata?['display_name'] ??
                      user.userMetadata?['name'] ??
                      user.userMetadata?['full_name'] ??
                      'No Name',
              style: AppTextStyles.headline4,
            ),
          ],
        ),
      ),
    );
  }
}

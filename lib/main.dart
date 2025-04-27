import 'package:device_preview/device_preview.dart';
import 'package:e_commerce/core/navigation/router.dart';
import 'package:e_commerce/core/styles/themes.dart';
import 'package:e_commerce/core/util/bloc_observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // ------ Load .env file ------
  await dotenv.load(fileName: ".env");

  // ------ Init supabase ------
  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL']!,
    anonKey: dotenv.env['SUPABASE_ANON_KEY']!,
  );

  // ------ Attach Bloc Observer ------
  Bloc.observer = AppBlocObserver();

  runApp(DevicePreview(builder: (context) => const MyApp()));

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
    );
  }
}

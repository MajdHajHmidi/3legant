import 'package:device_preview/device_preview.dart';
import 'package:e_commerce/core/styles/themes.dart';
import 'package:e_commerce/core/util/bloc_observer.dart';
import 'package:e_commerce/core/util/dependency_injection.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  final binding = WidgetsFlutterBinding.ensureInitialized();
  // * Initialize services here...
  launchNativeSplashScreen(binding);
  attachBlocObserver();
  setupDependencyInjection();
  await loadEnvFile();
  await initSupabase();

  // runApp(const MyApp());
  runApp(DevicePreview(builder: (context) => const MyApp()));
  removeNativeSplashScreen();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: serviceLocator<GoRouter>(),
      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('en'), // English
        Locale('ar'), // Arabic
      ],
    );
  }
}

Future<void> loadEnvFile() async {
  await dotenv.load(fileName: ".env");
}

Future<void> initSupabase() async {
  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL']!,
    anonKey: dotenv.env['SUPABASE_ANON_KEY']!,
  );
}

void attachBlocObserver() {
  Bloc.observer = AppBlocObserver();
}

void launchNativeSplashScreen(WidgetsBinding binding) {
  FlutterNativeSplash.preserve(widgetsBinding: binding);
}

void removeNativeSplashScreen() {
  FlutterNativeSplash.remove();
}

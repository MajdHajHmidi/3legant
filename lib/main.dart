import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
// import 'package:sentry_flutter/sentry_flutter.dart';

import 'core/styles/themes.dart';
import 'core/util/bloc_observer.dart';
import 'core/util/dependency_injection.dart';

Future<void> main() async {
  final binding = WidgetsFlutterBinding.ensureInitialized();
  // * Initialize services here...
  _launchNativeSplashScreen(binding);
  _attachBlocObserver();
  setupDependencyInjection();
  await _loadEnvFile();
  await _initSupabase();

  // * Sentry configuration
  if (kDebugMode) {
    runApp(DevicePreview(builder: (_) => const MyApp()));
  } else {
    // await SentryFlutter.init((options) {
    //   options.dsn = dotenv.env['SENTRY_DSN']!;
    //   // Adds request headers and IP for users,
    //   // visit: https://docs.sentry.io/platforms/dart/data-management/data-collected/ for more info
    //   options.sendDefaultPii = true;
    //   // Set tracesSampleRate to 1.0 to capture 100% of transactions for tracing.
    //   // We recommend adjusting this value in production.
    //   options.tracesSampleRate = 1.0;
    //   // The sampling rate for profiling is relative to tracesSampleRate
    //   // Setting to 1.0 will profile 100% of sampled transactions:
    //   options.profilesSampleRate = 1.0;
    //   // Set sessionSampleRate to 0.1 to capture 10% of sessions and onErrorSampleRate to 1.0 to capture 100% of errors.
    //   options.replay.sessionSampleRate = 0.1;
    //   options.replay.onErrorSampleRate = 1.0;
    // }, appRunner: () => runApp(SentryWidget(child: const MyApp())));
  }

  // * Disposes the splash screen after it's shown
  _removeNativeSplashScreen();
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

Future<void> _loadEnvFile() async {
  await dotenv.load(fileName: ".env");
}

Future<void> _initSupabase() async {
  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL']!,
    anonKey: dotenv.env['SUPABASE_ANON_KEY']!,
  );
}

void _attachBlocObserver() {
  Bloc.observer = AppBlocObserver();
}

void _launchNativeSplashScreen(WidgetsBinding binding) {
  FlutterNativeSplash.preserve(widgetsBinding: binding);
}

void _removeNativeSplashScreen() {
  FlutterNativeSplash.remove();
}

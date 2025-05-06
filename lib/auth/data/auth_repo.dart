import 'package:e_commerce/core/constants/app_constants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class AuthRepo {
  /// Returns status code
  Future<int> signinWithEmailAndPassword({
    required String email,
    required String password,
  });

  /// Returns status code
  Future<int> signupWithEmailAndPassword({
    required String email,
    required String password,
    required String name,
  });

  Future<int> signupWithGoogle(TargetPlatform platform);

  Future<int> signinWithGoogle(TargetPlatform platform);

  Future<int> signOut();
}

class SupabaseAuthRepo extends AuthRepo {
  @override
  Future<int> signinWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      await Supabase.instance.client.auth.signInWithPassword(
        email: email,
        password: password,
      );

      return 200;
    } on AuthException catch (exception) {
      if (exception.statusCode == null) {
        return 0;
      }

      return int.tryParse(exception.statusCode!) ?? 0;
    } catch (exception) {
      return 0;
    }
  }

  @override
  Future<int> signupWithEmailAndPassword({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      await Supabase.instance.client.auth.signUp(
        email: email,
        password: password,
        data: {'display_name': name},
        emailRedirectTo: AppConstants.emailVerificationSupabaseRedirectUrl,
      );

      return 200;
    } on AuthException catch (exception) {
      if (exception.statusCode == null) {
        return 0;
      }

      return int.tryParse(exception.statusCode!) ?? 0;
    } catch (exception) {
      return 0;
    }
  }

  @override
  Future<int> signOut() async {
    try {
      if (await GoogleSignIn().isSignedIn()) {
        GoogleSignIn().signOut();
      }
      await Supabase.instance.client.auth.signOut();

      return 200;
    } catch (exception) {
      return 0;
    }
  }

  @override
  Future<int> signinWithGoogle(TargetPlatform platform) async {
    try {
      if (platform == TargetPlatform.windows ||
          platform == TargetPlatform.macOS ||
          platform == TargetPlatform.linux ||
          kIsWeb) {
        await _desktopAndWebGoogleSupabaseAuthentication();

        return 200;
      }

      final googleUser = await _performGoogleUserAuthentication();

      if (googleUser == null) return 0; // User canceled sign-in

      final userExists = await _checkIfUserExists(googleUser.email);

      if (!userExists) {
        await signOut();
        return 0;
      }

      // Otherwise if user exists, sign in
      await _preformSupabaseGoogleAuthentication(googleUser);

      return 200;
    } catch (exception) {
      return 0;
    }
  }

  @override
  Future<int> signupWithGoogle(TargetPlatform platform) async {
    try {
      if (platform == TargetPlatform.windows ||
          platform == TargetPlatform.macOS ||
          platform == TargetPlatform.linux ||
          kIsWeb) {
        await _desktopAndWebGoogleSupabaseAuthentication();

        return 200;
      }

      final googleUser = await _performGoogleUserAuthentication();

      if (googleUser == null) return 0; // User canceled sign-in

      final userExists = await _checkIfUserExists(googleUser.email);

      if (userExists) {
        await signOut(); // Sign out from Google to prevent staying logged in
        return 0;
      }

      // Otherwise if user doesn't exists, sign up
      await _preformSupabaseGoogleAuthentication(googleUser);

      return 200;
    } catch (exception) {
      return 0;
    }
  }

  Future<void> _desktopAndWebGoogleSupabaseAuthentication() {
    return Supabase.instance.client.auth.signInWithOAuth(
      OAuthProvider.google,
      redirectTo:
          kIsWeb
              ? null
              : AppConstants
                  .googleSigninSupabaseRedirectUrl, // Optionally set the redirect link to bring back the user via deeplink.
      authScreenLaunchMode:
          kIsWeb
              ? LaunchMode.platformDefault
              : LaunchMode
                  .externalApplication, // Launch the auth screen in a new webview on mobile.
    );
  }

  Future<GoogleSignInAccount?> _performGoogleUserAuthentication() async {
    final webClientId = dotenv.env['GOOGLE_OAUTH_WEB_CLIENT_ID']!;
    final iosClientId = dotenv.env['GOOGLE_OAUTH_IOS_CLIENT_ID']!;
    final GoogleSignIn googleSignIn = GoogleSignIn(
      clientId: iosClientId,
      serverClientId: webClientId,
    );

    return await googleSignIn.signIn();
  }

  Future<bool> _checkIfUserExists(String email) async {
    return await Supabase.instance.client.rpc(
          'check_user_exists_by_email',
          params: {'email_input': email},
        )
        as bool;
  }

  Future<void> _preformSupabaseGoogleAuthentication(
    GoogleSignInAccount googleUser,
  ) async {
    final googleAuth = await googleUser.authentication;
    final accessToken = googleAuth.accessToken;
    final idToken = googleAuth.idToken;

    if (accessToken == null) {
      throw 'No Access Token found.';
    }
    if (idToken == null) {
      throw 'No ID Token found.';
    }

    await Supabase.instance.client.auth.signInWithIdToken(
      provider: OAuthProvider.google,
      idToken: idToken,
      accessToken: accessToken,
    );
  }
}

import 'package:flutter/foundation.dart';
import 'package:flutter_async_value/async_value.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:e_commerce/core/constants/app_constants.dart';
import 'package:e_commerce/core/models/user.dart' as app_user;
import 'package:e_commerce/core/util/app_failure.dart';
import 'package:e_commerce/core/util/supabase_error_handling.dart';

abstract class AuthRepo {
  /// Returns status code
  Future<AsyncResult<void, AppFailure>> signinWithEmailAndPassword({
    required String email,
    required String password,
  });

  /// Returns status code
  Future<AsyncResult<void, AppFailure>> signupWithEmailAndPassword({
    required String email,
    required String password,
    required String name,
  });

  Future<AsyncResult<void, AppFailure>> signupWithGoogle(
    TargetPlatform platform,
  );

  Future<AsyncResult<void, AppFailure>> signinWithGoogle(
    TargetPlatform platform,
  );

  Future<AsyncResult<void, AppFailure>> requestPasswordReset(String email);

  Future<AsyncResult<void, AppFailure>> updatePassword(String newPassword);

  Future<AsyncResult<void, AppFailure>> signOut();

  app_user.User? getCurrentUser();
}

class SupabaseAuthRepo extends AuthRepo {
  final supabase = Supabase.instance.client;

  @override
  Future<AsyncResult<void, AppFailure>> signinWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      await supabase.auth.signInWithPassword(email: email, password: password);

      return AsyncResult.data(data: null);
    } on AuthException catch (exception) {
      return AsyncResult.error(error: getSupabaseAuthErrorType(exception.code));
    } catch (_) {
      return AsyncResult.error(
        error: NetworkFailure(code: AuthFailureCodes.other.name),
      );
    }
  }

  @override
  Future<AsyncResult<void, AppFailure>> signupWithEmailAndPassword({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      await supabase.auth.signUp(
        email: email,
        password: password,
        data: {'display_name': name},
        emailRedirectTo: AppConstants.getAppDeepLinkUrl(
          AppConstants.emailVerificationSupabaseRedirectHost,
        ),
      );

      return AsyncResult.data(data: null);
    } on AuthException catch (exception) {
      return AsyncResult.error(error: getSupabaseAuthErrorType(exception.code));
    } catch (_) {
      return AsyncResult.error(
        error: NetworkFailure(code: AuthFailureCodes.other.name),
      );
    }
  }

  @override
  Future<AsyncResult<void, AppFailure>> signOut() async {
    try {
      if (await GoogleSignIn().isSignedIn()) {
        GoogleSignIn().signOut();
      }
      await supabase.auth.signOut();

      return AsyncResult.data(data: null);
    } on AuthException catch (exception) {
      return AsyncResult.error(error: getSupabaseAuthErrorType(exception.code));
    } catch (_) {
      return AsyncResult.error(
        error: NetworkFailure(code: AuthFailureCodes.other.name),
      );
    }
  }

  @override
  Future<AsyncResult<void, AppFailure>> signinWithGoogle(
    TargetPlatform platform,
  ) async {
    try {
      if (platform == TargetPlatform.windows ||
          platform == TargetPlatform.macOS ||
          platform == TargetPlatform.linux ||
          kIsWeb) {
        await _desktopAndWebGoogleSupabaseAuthentication();

        return AsyncResult.data(data: null);
      }

      final googleUser = await _performGoogleUserAuthentication();

      if (googleUser == null) {
        return AsyncResult.error(
          error: NetworkFailure(code: AuthFailureCodes.other.name),
        ); // User canceled sign-in
      }

      final userExists = await _checkIfUserExists(googleUser.email);

      if (!userExists) {
        await signOut();
        return AsyncResult.error(
          error: NetworkFailure(code: AuthFailureCodes.userDoesntExist.name),
        );
      }

      // Otherwise if user exists, sign in
      await _preformSupabaseGoogleAuthentication(googleUser);

      return AsyncResult.data(data: null);
    } catch (_) {
      return AsyncResult.error(
        error: NetworkFailure(code: AuthFailureCodes.other.name),
      );
    }
  }

  @override
  Future<AsyncResult<void, AppFailure>> signupWithGoogle(
    TargetPlatform platform,
  ) async {
    try {
      if (platform == TargetPlatform.windows ||
          platform == TargetPlatform.macOS ||
          platform == TargetPlatform.linux ||
          kIsWeb) {
        await _desktopAndWebGoogleSupabaseAuthentication();

        return AsyncResult.data(data: null);
      }

      final googleUser = await _performGoogleUserAuthentication();

      if (googleUser == null) {
        return AsyncResult.error(
          error: NetworkFailure(code: AuthFailureCodes.other.name),
        );
      } // User canceled sign-in

      final userExists = await _checkIfUserExists(googleUser.email);

      if (userExists) {
        await signOut(); // Sign out from Google to prevent staying logged in
        return AsyncResult.error(
          error: NetworkFailure(code: AuthFailureCodes.userAlreadyExists.name),
        );
      }

      // Otherwise if user doesn't exists, sign up
      await _preformSupabaseGoogleAuthentication(googleUser);

      return AsyncResult.data(data: null);
    } catch (_) {
      return AsyncResult.error(
        error: NetworkFailure(code: AuthFailureCodes.other.name),
      );
    }
  }

  Future<void> _desktopAndWebGoogleSupabaseAuthentication() {
    return supabase.auth.signInWithOAuth(
      OAuthProvider.google,
      redirectTo:
          kIsWeb
              ? null
              : AppConstants.getAppDeepLinkUrl(
                AppConstants.googleSigninSupabaseRedirectHost,
              ), // Optionally set the redirect link to bring back the user via deeplink.
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
    return await supabase.rpc(
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

    await supabase.auth.signInWithIdToken(
      provider: OAuthProvider.google,
      idToken: idToken,
      accessToken: accessToken,
    );
  }

  @override
  Future<AsyncResult<void, AppFailure>> requestPasswordReset(
    String email,
  ) async {
    try {
      await supabase.auth.resetPasswordForEmail(
        email,
        redirectTo: AppConstants.getAppDeepLinkUrl(
          AppConstants.emailPasswordResetSupabaseRedirectHost,
        ),
      );

      return AsyncResult.data(data: null);
    } on AuthException catch (exception) {
      return AsyncResult.error(error: getSupabaseAuthErrorType(exception.code));
    } catch (_) {
      return AsyncResult.error(
        error: NetworkFailure(code: AuthFailureCodes.other.name),
      );
    }
  }

  @override
  Future<AsyncResult<void, AppFailure>> updatePassword(
    String newPassword,
  ) async {
    try {
      await supabase.auth.updateUser(UserAttributes(password: newPassword));

      return AsyncResult.data(data: null);
    } on AuthException catch (exception) {
      return AsyncResult.error(error: getSupabaseAuthErrorType(exception.code));
    } catch (_) {
      return AsyncResult.error(
        error: NetworkFailure(code: AuthFailureCodes.other.name),
      );
    }
  }

  @override
  app_user.User? getCurrentUser() {
    final currentSession = Supabase.instance.client.auth.currentSession;

    if (currentSession == null) {
      return null;
    }

    final supabaseUser = currentSession.user;
    final name =
        supabaseUser.userMetadata?['display_name'] as String? ??
        supabaseUser.userMetadata?['name'] as String? ??
        supabaseUser.userMetadata?['full_name'] as String? ??
        'No Name';

    final profileUrl =
        supabaseUser.userMetadata?['picture'] as String? ??
        supabaseUser.userMetadata?['avatar_url'] as String?;

    return app_user.User(
      id: supabaseUser.id,
      name: name,
      email: supabaseUser.email,
      profileUrl: profileUrl,
    );
  }
}

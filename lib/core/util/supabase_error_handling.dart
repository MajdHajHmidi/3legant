import 'package:e_commerce/core/util/app_failure.dart';

AppFailure getSupabaseAuthErrorType(String? errorCode) {
  switch (errorCode) {
    case 'user_already_exists':
      return NetworkFailure(code: AuthFailureCodes.userAlreadyExists.name);
    case 'invalid_credentials':
      return NetworkFailure(
        code: AuthFailureCodes.invalidLoginCredentials.name,
      );
    case 'over_email_send_rate_limit':
      return NetworkFailure(code: AuthFailureCodes.tooManyRequests.name);
    case 'same_password':
      return NetworkFailure(code: AuthFailureCodes.cantUseOldPassword.name);
    case 'email_not_confirmed':
      return NetworkFailure(code: AuthFailureCodes.emailNotConfirmed.name);
    default:
      return NetworkFailure(code: AuthFailureCodes.other.name);
  }
}

import 'app_failure.dart';
import 'package:flutter/material.dart';
import 'package:flutter_async_value/flutter_async_value.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

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

Future<AsyncResult<T, AppFailure>> supabaseRpc<T>(
  String name, {
  T Function(Map<String, dynamic> json)? fromJson,
  Map<String, dynamic>? params,

  /// Key: Error code in supabase, Value, the error code to return
  Map<String, String>? customErrors,
  dynamic get = false,
}) async {
  try {
    final response = await Supabase.instance.client.rpc(
      name,
      params: params,
      get: get,
    );

    return AsyncResult.data(data: fromJson == null ? null : fromJson(response));
  } on PostgrestException catch (exception) {
    debugPrint(
      'Rpc Custom Exception -- Code: ${exception.code}, Message: ${exception.message}',
    );

    if (exception.code == null ||
        customErrors == null ||
        !customErrors.containsKey(exception.code)) {
      return AsyncResult.error(
        error: NetworkFailure(code: RpcFailureCodes.other.name),
      );
    }

    return AsyncResult.error(
      error: NetworkFailure(code: customErrors[exception.code!]!),
    );
  } catch (exception) {
    debugPrint('RPC Exception: $exception');
    return AsyncResult.error(
      error: NetworkFailure(code: RpcFailureCodes.other.name),
    );
  }
}

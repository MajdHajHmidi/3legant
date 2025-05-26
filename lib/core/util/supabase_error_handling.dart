import 'app_failure.dart';
import 'package:flutter/material.dart';
import 'package:flutter_async_value/async_value.dart';
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

Future<AsyncResult<Map<String, dynamic>, AppFailure>> supabaseRpc(
  String name, {
  Map<String, dynamic>? params,
  dynamic get = false,
}) async {
  try {
    final response = await Supabase.instance.client.rpc(
      name,
      params: params,
      get: get,
    );

    return AsyncResult.data(data: response as Map<String, dynamic>);
  } catch (exception) {
    debugPrint('RPC Excpetion: $exception');
    return AsyncResult.error(
      error: NetworkFailure(code: RpcFailureCodes.other.name),
    );
  }
}

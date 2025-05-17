class AppFailure {
  final String code;

  AppFailure({required this.code});
}

class NetworkFailure extends AppFailure {
  NetworkFailure({required super.code});
}

class CacheFailure extends AppFailure {
  CacheFailure({required super.code});
}

enum AuthFailureCodes {
  userAlreadyExists,
  userDoesntExist,
  invalidLoginCredentials,
  cantUseOldPassword,
  tooManyRequests,
  emailNotConfirmed,
  other,
}

class Errors {
  Errors._();

  static const String INTERNAL_SERVER_MESSAGE = 'Server failure encountered';

  static const String CACHE_FAILURE_MESSAGE =
      'Local storage failure encountered';

  static const String INVALID_AUTHENTICATION_MESSAGE =
      'Invalid username or password';

  static const String INVALID_API_MESSAGE =
      'Something went wrong while connecting to our servers';

  static const String INVALID_UNAUTHENTICATED_MESSAGE =
      'Something went wrong while authenticating your account. Try signing in back again.';

  static const String BAD_NETWORK_MESSAGE =
      'Internet connectivity is not available.';

  static const String UNKNOWN_FAILURE_MESSAGE = 'Some unknown error occurred';

  static const String INACCESSIBLE_ROUTE_MESSAGE =
      'The route is inaccessible. Please login first';
}

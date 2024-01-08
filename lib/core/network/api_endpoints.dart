// ignore_for_file: constant_identifier_names
// DO NOT USE 'dartfmt' on this file for formatting

import 'package:flutter/material.dart';

/// A utility class for getting paths for API endpoints.
/// This class has no constructor and all methods are `static`.
@immutable
class ApiEndpoint {
  const ApiEndpoint._();

  /// The base url of our REST API, to which all the requests will be sent.
  /// It is supplied at the time of building the apk or running the app:
  /// ```
  /// flutter build apk --debug --dart-define=BASE_URL=www.some_url.com
  /// ```
  /// OR
  /// ```
  /// flutter run --dart-define=BASE_URL=www.some_url.com
  /// ```
  static const baseUrl = 'http://91.147.94.186:9015';

  /// Returns the path for an authentication [endpoint].
  static String auth(AuthEndpoint endpoint) {
    switch (endpoint) {
      case AuthEndpoint.REGISTER:
        return '/user/api/v1/auth/registration';
      case AuthEndpoint.LOGIN:
        return '/user/api/v1/auth/login';
      case AuthEndpoint.REFRESH_TOKEN:
        return '/user/api/v1/auth/refresh';
    }
  }

  static String livestock(LiveStockEndpoint endpoint) {
    switch (endpoint) {
      case LiveStockEndpoint.GET:
        return '/farm/api/v1/livestock';
      case LiveStockEndpoint.POST:
        return '/farm/api/v1/livestock';
    }
  }
}

/// A collection of endpoints used for authentication purposes.
enum AuthEndpoint {
  /// An endpoint for registration requests.
  REGISTER,

  /// An endpoint for login requests.
  LOGIN,

  /// An endpoint for token refresh requests.
  REFRESH_TOKEN,
}

enum LiveStockEndpoint {
  ///An endpoint for creating livestock
  POST,

  ///An endpoint for displaying list of livestock
  GET,
}
